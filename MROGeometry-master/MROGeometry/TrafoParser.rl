//
// TrafoParser.rl
//
// Created by Marcus Rohrmoser on 11.03.10.
// Copyright (c) 2010-2014, Marcus Rohrmoser mobile Software
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted
// provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of conditions
// and the following disclaimer.
//
// 2. The software must not be used for military or intelligence or related purposes nor
// anything that's in conflict with human rights as declared in http://www.un.org/en/documents/udhr/ .
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//

#import "TrafoParser.h"
#include <math.h>

#ifdef MRLogD
#undef MRLogD
#endif
// No Logging
#define MRLogD(x,...)

/** <a href="http://www.complang.org/ragel/">Ragel</a> parser
 * for <a href="http://www.w3.org/TR/SVG11/coords.html#TransformAttribute">transform attribute</a> - This file is auto-generated by rl2objc.sh.
 * <p>
 * DO NOT EDIT MANUALLY!!!
 * </p>
 */
@implementation TrafoParser

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-const-variable"

%%{

  machine trafo;

  #######################################################
  ## Define the actions
  #######################################################

  action CLEAR {
    two = NO;
    argc = 0;
  }

  action TWO {
    two = YES;
  }

  action BUF {
    [buf appendFormat:@"%c", *p];
    MRLogD(@"buffered '%@'", buf);
  }

  action NUMBER {
    const double v = [buf doubleValue];
    MRLogD(@"buffer to number '%@' -> %f", buf, v);
    argv[argc++] = v;
    [buf setString:@""];
  }

  action SKEW_X {
    if(YES)
      [NSException raise:@"Not implemented yet." format:@""];
  }

  action SKEW_Y {
    if(YES)
      [NSException raise:@"Not implemented yet." format:@""];
  }

  action ROTATE {
    MRLogD(@"rotate %f", argv[0]);
    argv[0] *= M_PI / 180;
    if(!two) 
      t = CGAffineTransformRotate(t, argv[0]);
    else
      [NSException raise:@"Not implemented yet." format:@""];
//      t = CGAffineTransformRotate(t, argv[0]);
//      t.rotate(argv[0], argv[1], argv[2]);
  }

  action SCALE {
    if(!two)
      argv[1] = argv[0];
    MRLogD(@"scale %f,%f", argv[0], argv[1]);
    t = CGAffineTransformScale(t, argv[0], argv[1]);
  }

  action TRANSLATE {
    if(!two)
      argv[1] = argv[0];
    MRLogD(@"translate %f,%f", argv[0], argv[1]);
    t = CGAffineTransformTranslate(t, argv[0], argv[1]);
  }

  action MATRIX {
    MRLogD(@"concat", nil);
    t = CGAffineTransformConcat(t, CGAffineTransformMake(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]) );
//    t.preConcatenate(new AffineTransform(argv));
  }

  #######################################################
  ## Define the grammar
  #######################################################

  wsp = space;
  digit_sequence = digit+;
  sign = "+" | "-";
  exponent = ( "e" | "E" ) sign? digit_sequence;
  fractional_constant = (digit_sequence? "." digit_sequence) | (digit_sequence ".");
  floating_point_constant = (fractional_constant exponent?) | (digit_sequence exponent);
  integer_constant = digit_sequence;
  comma = ",";
  comma_wsp = (wsp+ comma? wsp*) | (comma wsp*);
  number = (sign? @BUF (integer_constant | floating_point_constant)) @BUF %NUMBER;
  
  skewY = "skewY" wsp* "(" wsp* number wsp* ")" >CLEAR %SKEW_Y;
  skewX = "skewX" wsp* "(" wsp* number wsp* ")" >CLEAR %SKEW_X;
  rotate = ("rotate" wsp* "(" wsp* number ( comma_wsp number %TWO comma_wsp number )? wsp* ")") >CLEAR %ROTATE;
  scale = ("scale" wsp* "(" wsp* number ( comma_wsp number %TWO )? wsp* ")") >CLEAR %SCALE;
  translate = ("translate" wsp* "(" wsp* number ( comma_wsp number %TWO )? wsp* ")") >CLEAR %TRANSLATE;
  matrix = 
    "matrix" wsp* "(" wsp*
      number comma_wsp
      number comma_wsp
      number comma_wsp
      number comma_wsp
      number comma_wsp
      number wsp* ")" >CLEAR %MATRIX;
  transform =
      matrix
      | translate
      | scale
      | rotate
      | skewX
      | skewY;
  transforms =
    transform (comma_wsp+ transform)*;
  
  main := wsp* transforms? wsp*;
}%%

%% write data;

-(CGAffineTransform)newCGAffineTransformWithCString:(const char*)data length:(const size_t)length error:(NSError**)errPtr
{
  CGAffineTransform t = CGAffineTransformIdentity;
  if(data == NULL)
    return t;
  // high-level buffers
  BOOL two = NO;
  NSMutableString *buf = [[NSMutableString alloc] init];
  double argv[] = {0,0,0,0,0,0};
  int argc = 0;

//  ragel variables (low level)
  const char *p = data;
  const char *pe = data + length; // pointer "end"
  const char *eof = pe;
  int cs = 0;
//  int top;

///////////////////////////////////////////////////////////
//  init ragel
  %% write init;
///////////////////////////////////////////////////////////
//  exec ragel
  %% write exec;

  if ( errPtr != nil && cs < trafo_first_final )
    *errPtr = [self parseError:data position:p];
  return t;
}

-(CGAffineTransform)newCGAffineTransformWithNSString:(NSString*)data error:(NSError**)errPtr
{
  const char *c = [data UTF8String];
  return [self newCGAffineTransformWithCString:c length:strlen(c) error:errPtr];
}

#pragma clang diagnostic pop

@end
