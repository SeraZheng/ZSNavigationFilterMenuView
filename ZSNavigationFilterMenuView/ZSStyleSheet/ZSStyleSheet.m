//
//  ZSStyleSheet.m
//  ZSNavigationFilterMenuDemo
//
//  Created by bv-zheng on 12/14/15.
//  Copyright © 2015 Sera. All rights reserved.
//

#import "ZSStyleSheet.h"
#import "ZSDefaultStyleSheet.h"

@implementation ZSStyleSheet

static ZSStyleSheet* gStyleSheet = nil;

#pragma mark -
#pragma mark Class public

+ (ZSStyleSheet*)globalStyleSheet {
    if (!gStyleSheet) {
        gStyleSheet = [[ZSDefaultStyleSheet alloc] init];
    }
    return gStyleSheet;
}

+ (void)setGlobalStyleSheet:(ZSStyleSheet*)styleSheet {
    gStyleSheet = styleSheet;
}

@end
