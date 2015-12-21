//
//  ZSStyleSheet.h
//  ZSNavigationFilterMenuDemo
//
//  Created by bv-zheng on 12/14/15.
//  Copyright © 2015 Sera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSGlobalStyle.h"

@interface ZSStyleSheet : NSObject

+ (ZSStyleSheet*)globalStyleSheet;
+ (void)setGlobalStyleSheet:(ZSStyleSheet*)styleSheet;

@end
