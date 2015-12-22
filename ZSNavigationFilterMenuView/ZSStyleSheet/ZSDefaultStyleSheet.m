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

- (UIColor *)strokeLineColor
{
    return [UIColor whiteColor];
}

- (CGFloat)strokeWidth
{
    return 2.f;
}

#pragma mark -
#pragma mark cell

- (UIColor*)cellBackgroundColor{
    return RGBCOLOR(33, 132, 214);
}

- (UIColor *)bodyViewColor
{
    return [UIColor clearColor];
}

- (UIColor*)bodyViewHighlightedColor{
    return RGBCOLOR(29, 120, 191);
}

- (UIColor *)bodyViewBorderColor
{
    return [UIColor whiteColor];
}

- (CGFloat)bodyViewBorderWidth
{
    return 1.f;
}

- (CGFloat)bodyViewCornerRadius
{
    return 6.f;
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

- (NSTextAlignment)textLabelAlignment
{
    /**for icons
    return NSTextAlignmentLeft;
    */
    
    //for titles only
    return NSTextAlignmentCenter;
}

#pragma mark -
#pragma mark background view

- (UIColor *)backgroundViewColor
{
    return [UIColor whiteColor];
}

#pragma mark -
#pragma mark check view

- (UIColor *)checkViewColor
{
    return [UIColor whiteColor];
}

- (CGFloat)checkViewWidth
{
    return 2.f;
}

@end
