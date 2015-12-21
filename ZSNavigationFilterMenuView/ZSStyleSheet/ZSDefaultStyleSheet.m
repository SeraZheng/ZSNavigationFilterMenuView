//
//  ZSDefaultStyleSheet.m
//  ZSNavigationFilterMenuDemo
//
//  Created by bv-zheng on 12/15/15.
//  Copyright © 2015 Sera. All rights reserved.
//

#import "ZSDefaultStyleSheet.h"
#import "ZSGlobalStyle.h"

@implementation ZSDefaultStyleSheet

#pragma mark -
#pragma mark cell color

- (UIColor*)cellBackgroundColor{
    return RGBCOLOR(33, 132, 214);
}

- (UIColor*)bodyViewHighlightedColor{
    return RGBCOLOR(29, 120, 191);
}

#pragma mark -
#pragma mark text label

- (UIFont *)textFont
{
    return [UIFont boldSystemFontOfSize:18];
}

- (UIColor*)textDefaultColor {
    return RGBCOLOR(255, 255, 255);
}

- (UIColor*)textHighlightedColor{
    return [UIColor lightGrayColor];
}



@end
