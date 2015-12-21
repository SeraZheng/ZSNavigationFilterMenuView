//
//  ZSGlobalStyle.h
//  ZSNavigationFilterMenuDemo
//
//  Created by bv-zheng on 12/15/15.
//  Copyright © 2015 Sera. All rights reserved.
//

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define ZSSTYLESHEET ((id)[ZSStyleSheet globalStyleSheet])

#define ZSSTYLEVAR(_VARNAME) [ZSSTYLESHEET _VARNAME]
