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

//cell color
- (UIColor*)cellBackgroundColor;
- (UIColor*)bodyViewHighlightedColor;

//text label
- (UIFont*)textFont;
- (UIColor*)textDefaultColor;
- (UIColor*)textHighlightedColor;


@end
