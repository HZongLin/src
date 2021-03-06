################################################################################
#
#            !!!!!   Do NOT edit this file directly!   !!!!!
#
#            Edit mktests.PL and/or parts/inc/cop instead.
#
#  This file was automatically generated from the definition files in the
#  parts/inc/ subdirectory by mktests.PL. To learn more about how all this
#  works, please read the F<HACKERS> file that came with this distribution.
#
################################################################################

BEGIN {
  if ($ENV{'PERL_CORE'}) {
    chdir 't' if -d 't';
    @INC = ('../lib', '../ext/Devel-PPPort/t') if -d '../lib' && -d '../ext';
    require Config; import Config;
    use vars '%Config';
    if (" $Config{'extensions'} " !~ m[ Devel/PPPort ]) {
      print "1..0 # Skip -- Perl configured without Devel::PPPort module\n";
      exit 0;
    }
  }
  else {
    unshift @INC, 't';
  }

  sub load {
    eval "use Test";
    require 'testutil.pl' if $@;
  }

  if (28) {
    load();
    plan(tests => 28);
  }
}

use Devel::PPPort;
use strict;
$^W = 1;

package Devel::PPPort;
use vars '@ISA';
require DynaLoader;
@ISA = qw(DynaLoader);
bootstrap Devel::PPPort;

package main;

my $package;
{
  package MyPackage;
  $package = &Devel::PPPort::CopSTASHPV();
}
print "# $package\n";
ok($package, "MyPackage");

my $file = &Devel::PPPort::CopFILE();
print "# $file\n";
ok($file =~ /cop/i);

BEGIN {
  if ($] < 5.006000) {
    # Skip
    for (1..28) {
      ok(1, 1);
    }
    exit;
  }
}

BEGIN {
    package DB;
    no strict "refs";
    local $^P = 1;
    sub sub { &$DB::sub }
}

{ package One; sub one { Devel::PPPort::caller_cx($_[0]) } }
{
    package Two;
    sub two { One::one(@_) }
    sub dbtwo {
        BEGIN { $^P = 1 }
        One::one(@_);
        BEGIN { $^P = 0 }
    }
}

for (
    # This is rather confusing. The package is the package the call is
    # made *from*, the sub name is the sub the call is made *to*. When
    # DB::sub is involved the first call is to DB::sub from the calling
    # package, the second is to the real sub from package DB.
    [\&One::one, 0, qw/main one main one/],
    [\&One::one, 2, ],
    [\&Two::two, 0, qw/Two one Two one/],
    [\&Two::two, 1, qw/main two main two/],
    [\&Two::dbtwo, 0, qw/Two sub DB one/],
    [\&Two::dbtwo, 1, qw/main dbtwo main dbtwo/],
) {
    my ($sub, $arg, @want) = @$_;
    my @got = $sub->($arg);
    ok(@got, @want);
    for (0..$#want) {
        ok($got[$_], $want[$_]);
    }
}

