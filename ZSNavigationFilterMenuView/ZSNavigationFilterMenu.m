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

#define kSpace 9
#define Image_Height 30
#define Image_Width 30

@interface ZSNavigationFilterMenu ()

@property (nonatomic, retain) UIImage *downIcon;

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
        
        _maxSize = CGSizeMake(200, 40);
        
        [self setImage:self.downIcon forState:UIControlStateNormal];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - Image_Width, 0, 0)];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addTarget:self action:@selector(filterTitleTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithTitleItems:(NSArray *)titles iconItems:(NSArray *)icons
{
    if (icons) {
        NSAssert(icons.count == titles.count, @"icons' count must be equal to titles' count");
    }
    
    if (self = [self init]) {
        _titleItems = titles;
        _iconItems = icons;
        self.selectRow = 0;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    NSAttributedString *attributedTitle;
    if (state == UIControlStateNormal) {
        attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:self.defaultAttributes];
        [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
        
    }
    else if (state == UIControlStateHighlighted) {
        attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:self.highlightAttributes];
        [self setAttributedTitle:attributedTitle forState:UIControlStateHighlighted];
    }
    
    CGSize size = [attributedTitle boundingRectWithSize:self.maxSize options:NSStringDrawingTruncatesLastVisibleLine context:nil].size;
    [self setSize:size];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0 , size.width - kSpace + 2, 0, 0)];
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
        _pullMenuController.titleItems = _titleItems;
        [_pullMenuController.tableView reloadData];
    }
}

- (void)setSelectRow:(NSInteger)selectRow
{
    _selectRow = selectRow;
    
    [self setTitle:[self.titleItems objectAtIndex:selectRow] forState:UIControlStateNormal];
    [self setTitle:[self.titleItems objectAtIndex:selectRow] forState:UIControlStateHighlighted];
    
    if (_pullMenuController) {
        _pullMenuController.selectRow = selectRow;
    }
}

#pragma mark -
#pragma mark pull down menu

- (ZSNavigationFilterMenuController *)pullMenuController
{
    if (!_pullMenuController) {
        NSAssert(self.titleItems.count < 10, @"the count of title items must be less than 10");
        
        _pullMenuController = [[ZSNavigationFilterMenuController alloc] initWithTitleItems:self.titleItems iconItems:self.iconItems];
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
    self.selectRow = row;
    
    if (NULL != self.changeTitleCompletion) {
        _changeTitleCompletion([self.titleItems objectAtIndex:row], row);
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
        CGContextSetStrokeColorWithColor(context, [ZSSTYLEVAR(strokeLineColor) CGColor]);
        CGContextSetLineWidth(context, ZSSTYLEVAR(strokeWidth));
        
        CGContextMoveToPoint(context, kSpace, kSpace);
        CGContextAddLineToPoint(context, Image_Width/2, Image_Width - kSpace);
        CGContextAddLineToPoint(context, Image_Width - kSpace, kSpace);
        
        CGContextStrokePath(context);
        
        _downIcon = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    
    return _downIcon;
}

@end
