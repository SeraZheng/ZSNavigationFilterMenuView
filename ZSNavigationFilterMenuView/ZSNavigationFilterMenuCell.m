//
//  CVPullDownMenuCell.m
//  CV
//
//  Created by bv-zheng on 12/4/15.
//  Copyright © 2015 Broadvision. All rights reserved.
//

#import "ZSNavigationFilterMenuCell.h"
#import "UIViewAdditions.h"
#import "ZSDefaultStyleSheet.h"

#define Margin 5

@interface ZSNavigationFilterMenuCell ()

@property (nonatomic, retain) CABasicAnimation *shakeAnimation;

@end

@implementation ZSNavigationFilterMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(4*Margin, Margin, self.width - 8*Margin, self.height - 2*Margin)];
        [_bodyView setBackgroundColor:[UIColor clearColor]];
        [_bodyView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [_bodyView.layer setBorderWidth:1.f];
        [_bodyView.layer setCornerRadius:6.0];
        _bodyView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [self.contentView addSubview:_bodyView];
        
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        [self.textLabel setTextColor:ZSSTYLEVAR(textDefaultColor)];
        [self.textLabel setFont:ZSSTYLEVAR(textFont)];
        [self.textLabel setHighlightedTextColor:ZSSTYLEVAR(textHighlightedColor)];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [_bodyView setBackgroundColor:RGBCOLOR(29, 120, 191)];
        [_bodyView.layer setBorderWidth:0.f];
    } else {
        [_bodyView setBackgroundColor:[UIColor clearColor]];
        [_bodyView.layer setBorderWidth:1.f];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (!self.selected) {
        if (highlighted) {
            
            [self.contentView.layer addAnimation:self.shakeAnimation forKey:nil];
            
            [_bodyView setBackgroundColor:RGBCOLOR(29, 120, 191)];
            [_bodyView.layer setBorderWidth:0.f];
            
        } else {
            [_bodyView setBackgroundColor:[UIColor clearColor]];
            [_bodyView.layer setBorderWidth:1.f];
        }
    }
}

- (CABasicAnimation *)shakeAnimation
{
    if (!_shakeAnimation) {
        CGPoint viewPosition = self.contentView.layer.position;
        _shakeAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        [_shakeAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
        [_shakeAnimation setFromValue:[NSValue valueWithCGPoint:CGPointMake(viewPosition.x - 10, viewPosition.y)]];
        [_shakeAnimation setToValue:[NSValue valueWithCGPoint:CGPointMake(viewPosition.x + 10, viewPosition.y)]];
        [_shakeAnimation setAutoreverses:YES];
        [_shakeAnimation setRepeatCount:2];
        [_shakeAnimation setDuration:0.05];
    }
    return _shakeAnimation;
}

@end
