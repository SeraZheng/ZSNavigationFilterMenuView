//
//  CVSourceFilterTitleView.m
//  CV
//
//  Created by bv-zheng on 12/3/15.
//  Copyright © 2015 Broadvision. All rights reserved.
//

#import "ZSNavigationFilterMenu.h"
#import "ZSDefaultStyleSheet.h"
#import "UIViewAdditions.h"
#import <math.h>

#define kSpace 6
#define Image_Height 30
#define Image_Width 30

@interface ZSNavigationFilterMenu ()

@property (nonatomic, retain) UIImage *downIcon;
@property (nonatomic, retain) UIImage *upIcon;

@end

@implementation ZSNavigationFilterMenu

@synthesize pullMenuController = _pullMenuController;

- (instancetype)init
{
    if (self = [super init]) {
       
        _defaultAttributes = ({
            NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
            [defaults setObject:ZSSTYLEVAR(textDefaultColor) forKey:NSForegroundColorAttributeName];
            [defaults setObject:[UIFont boldSystemFontOfSize:19] forKey:NSFontAttributeName];
            
            defaults;
        });
        
        _highlightAttributes = ({
            NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
            [defaults setObject:ZSSTYLEVAR(textHighlightedColor) forKey:NSForegroundColorAttributeName];
            [defaults setObject:[UIFont boldSystemFontOfSize:19] forKey:NSFontAttributeName];
            
            defaults;
        });
        
        _selectRow = 0;
        _maxSize = CGSizeMake(200, 40);
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addTarget:self action:@selector(filterTitleTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [self init]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateHighlighted];
        
        [self setImage:self.downIcon forState:UIControlStateNormal];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - Image_Width, 0, 0)];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    CGSize size;
    if (state == UIControlStateNormal) {
        [self setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:self.defaultAttributes] forState:UIControlStateNormal];
        
        size = [title boundingRectWithSize:self.maxSize options:NSStringDrawingUsesFontLeading attributes:self.defaultAttributes context:nil].size;
    }
    else if (state == UIControlStateHighlighted) {
        [self setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:self.highlightAttributes] forState:UIControlStateHighlighted];
        
        size = [title boundingRectWithSize:self.maxSize options:NSStringDrawingUsesFontLeading attributes:self.highlightAttributes context:nil].size;
    }
    
    [self setSize:size];
    [self setImageEdgeInsets:UIEdgeInsetsMake(Image_Height/2 - size.height/2 , size.width, 0, 0)];
}

- (void)filterTitleTap
{
    [UIView animateWithDuration:0.2 animations:^(){
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];

    [self.pullMenuController show:YES animated:YES];
}

#pragma mark -
#pragma mark setters

- (void)setTitleItems:(NSArray *)titleItems
{
    _titleItems = titleItems;

    if (self.shouldReload && _pullMenuController) {
        _pullMenuController.items = _titleItems;
        [_pullMenuController.tableView reloadData];
    }
}

- (void)setSelectRow:(NSInteger)selectRow
{
    _selectRow = selectRow;
    
    if (_pullMenuController) {
        _pullMenuController.selectRow = selectRow;
    }
}

#pragma mark -
#pragma mark pull down menu

- (ZSNavigationFilterMenuController *)pullMenuController
{
    if (!_pullMenuController) {
        NSAssert(self.titleItems.count < 6, @"the count of title items must be less than 6");
        
        _pullMenuController = [[ZSNavigationFilterMenuController alloc] initWithItems:self.titleItems];
        _pullMenuController.menuDelegate = self;
        _pullMenuController.selectRow = _selectRow;
    }
    return _pullMenuController;
}

#pragma mark -
#pragma mark CVPullDownMenuDelegate

- (void)pullDownMenuDidDismiss
{
    [UIView animateWithDuration:0.2 animations:^(){
        self.imageView.transform = CGAffineTransformMakeRotation(0);
    }];
}

- (void)pullDownMenuDidChangeToRow:(NSInteger)row
{
    _selectRow = row;
    [self setTitle:[self.titleItems objectAtIndex:row] forState:UIControlStateNormal];
    
    if (NULL != self.changeTitleCompletion) {
        _changeTitleCompletion(row);
    }
}

#pragma mark -
#pragma mark icon

- (UIImage *)downIcon
{
    if (!_downIcon) {
        CGSize size = CGSizeMake(Image_Width, Image_Height);
        UIGraphicsBeginImageContext(size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBStrokeColor(context, 255, 255, 255, 1);
        CGContextSetLineWidth(context, 2.f);
        
        CGContextMoveToPoint(context, kSpace, kSpace);
        CGContextAddLineToPoint(context, Image_Width/2, Image_Width - 2*kSpace);
        CGContextAddLineToPoint(context, Image_Width - kSpace, kSpace);
        
        CGContextStrokePath(context);
        
        _downIcon = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    
    return _downIcon;
}

@end
