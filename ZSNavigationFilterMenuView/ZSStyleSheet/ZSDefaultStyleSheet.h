//
//  ZSDefaultStyleSheet.h
//  ZSNavigationFilterMenuDemo
//
//  Created by bv-zheng on 12/15/15.
//  Copyright © 2015 Sera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSStyleSheet.h"

@interface ZSDefaultStyleSheet : ZSStyleSheet

//title icon style
- (UIColor*)strokeLineColor;
- (CGFloat)strokeWidth;

//cell style
- (UIColor*)cellBackgroundColor;
- (UIColor*)bodyViewColor;
- (UIColor*)bodyViewHighlightedColor;
- (UIColor*)bodyViewBorderColor;
- (CGFloat)bodyViewBorderWidth;
- (CGFloat)bodyViewCornerRadius;

//text label style
- (UIFont*)textFont;
- (UIColor*)textDefaultColor;
- (UIColor*)textHighlightedColor;
- (NSTextAlignment)textLabelAlignment;

//background view style
- (UIColor*)backgroundViewColor;

// check view style
- (UIColor*)checkViewColor;
- (CGFloat)checkViewWidth;

@end
