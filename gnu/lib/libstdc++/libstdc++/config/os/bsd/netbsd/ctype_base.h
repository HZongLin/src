// Locale support -*- C++ -*-

// Copyright (C) 2000 Free Software Foundation, Inc.
//
// This file is part of the GNU ISO C++ Library.  This library is free
// software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the
// Free Software Foundation; either version 2, or (at your option)
// any later version.

// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License along
// with this library; see the file COPYING.  If not, write to the Free
// Software Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307,
// USA.

// As a special exception, you may use this file as part of a free software
// library without restriction.  Specifically, if other files instantiate
// templates or use macros or inline functions from this file, or you compile
// this file and link it with other files to produce an executable, this
// file does not by itself cause the resulting executable to be covered by
// the GNU General Public License.  This exception does not however
// invalidate any other reasons why the executable file might be covered by
// the GNU General Public License.

//
// ISO C++ 14882: 22.1  Locales
//
  
// Information as gleaned from /usr/include/ctype.h on NetBSD.
// Full details can be found from the CVS files at:
//   anoncvs@anoncvs.netbsd.org:/cvsroot/basesrc/include/ctype.h
// See www.netbsd.org for details of access.
  
  struct ctype_base
  {
    // Non-standard typedefs.
    typedef const unsigned char*	__to_type;

    // NB: Offsets into ctype<char>::_M_table force a particular size
    // on the mask type. Because of this, we don't use an enum.
    typedef unsigned char      	mask;
    static const mask upper    	= _U;
    static const mask lower 	= _L;
    static const mask alpha 	= _U | _L;
    static const mask digit 	= _N;
    static const mask xdigit 	= _N | _X;
    static const mask space 	= _S;
    static const mask print 	= _P | _U | _L | _N | _B;
    static const mask graph 	= _P | _U | _L | _N;
    static const mask cntrl 	= _C;
    static const mask punct 	= _P;
    static const mask alnum 	= _U | _L | _N;
  };
