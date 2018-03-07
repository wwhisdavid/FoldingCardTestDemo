//
//  TDMacro.h
//  Pods
//
//  Created by guoran on 2018/3/8.
//

#ifndef TDMacro_h
#define TDMacro_h

#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define SCREENSCALE             (SCREEN_WIDTH / 375.f)
#define SuitLength(length)      (floor(SCREENSCALE * length))

#endif /* TDMacro_h */
