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

#define Margin 3

@interface ZSNavigationFilterMenuCell ()

@property (nonatomic, retain) CABasicAnimation *shakeAnimation;
@property (nonatomic, retain) UIImageView *checkView;

@end

@implementation ZSNavigationFilterMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(4*Margin, Margin, self.width - 8*Margin, self.height - 2*Margin)];
        [_bodyView setBackgroundColor:ZSSTYLEVAR(bodyViewColor)];
        [_bodyView.layer setBorderColor:[ZSSTYLEVAR(bodyViewBorderColor) CGColor]];
        [_bodyView.layer setBorderWidth:ZSSTYLEVAR(bodyViewBorderWidth)];
        [_bodyView.layer setCornerRadius:ZSSTYLEVAR(bodyViewCornerRadius)];
        _bodyView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [self.contentView addSubview:_bodyView];
        
        [self.textLabel setTextAlignment:ZSSTYLEVAR(textLabelAlignment)];
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
        [_bodyView setBackgroundColor:ZSSTYLEVAR(bodyViewHighlightedColor)];
        [_bodyView.layer setBorderWidth:0.f];
        
        if (![self.textLabel.text isEqualToString:NSLocalizedString(@"Cancel", @"")]) {
             [self.contentView addSubview:self.checkView];
        }
    } else {
        [_bodyView setBackgroundColor:ZSSTYLEVAR(bodyViewColor)];
        [_bodyView.layer setBorderWidth:ZSSTYLEVAR(bodyViewBorderWidth)];
        [_checkView removeFromSuperview];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (!self.selected) {
        if (highlighted) {
            
            [self.contentView.layer addAnimation:self.shakeAnimation forKey:nil];
            
            [UIView animateWithDuration:0.5 delay:0.f options:UIViewAnimationOptionAutoreverse animations:^(){
                [_bodyView setBackgroundColor:ZSSTYLEVAR(bodyViewHighlightedColor)];
                [_bodyView.layer setBorderWidth:0.f];
            } completion:NULL];
            
        } else {
            [UIView animateWithDuration:0.5 animations:^(){
                [_bodyView setBackgroundColor:ZSSTYLEVAR(bodyViewColor)];
                [_bodyView.layer setBorderWidth:ZSSTYLEVAR(bodyViewBorderWidth)];
            }];
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

- (UIImageView *)checkView
{
    if (!_checkView) {
        CGSize imageSize = CGSizeMake(_bodyView.height, _bodyView.height - 10);
        UIGraphicsBeginImageContext(imageSize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [ZSSTYLEVAR(checkViewColor) CGColor]);
        CGContextSetLineWidth(context, ZSSTYLEVAR(checkViewWidth));
        
        CGContextMoveToPoint(context, 7, 7);
        CGContextAddLineToPoint(context, imageSize.width / 2 - 5, imageSize.height / 2);
        CGContextAddLineToPoint(context, imageSize.height, 0);
        CGContextStrokePath(context);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
        _checkView = [[UIImageView alloc] initWithFrame:CGRectMake(_bodyView.right - imageSize.width, _bodyView.bottom - imageSize.height , imageSize.width, imageSize.height)];
        _checkView.image = image;
    }
    return _checkView;
}

@end
