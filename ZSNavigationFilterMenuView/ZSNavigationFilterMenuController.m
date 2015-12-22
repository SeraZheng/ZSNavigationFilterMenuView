//
//  CVPullDownMenuController.m
//  CV
//
//  Created by bv-zheng on 12/3/15.
//  Copyright © 2015 Broadvision. All rights reserved.
//

#import "ZSNavigationFilterMenuController.h"
#import "ZSNavigationFilterMenuCell.h"
#import "UIViewAdditions.h"
#import "ZSDefaultStyleSheet.h"

#define Animate_Duration_Show 0.3
#define Animate_Duration_Hide 0.2
#define Row_Height 48
#define Alpha 0.7

@interface ZSNavigationFilterMenuController ()

@property (nonatomic, retain) CABasicAnimation *exitAnimation;

@end

@implementation ZSNavigationFilterMenuController

- (instancetype)initWithTitleItems:(NSArray *)titles iconItems:(NSArray *)icons
{
    if (self = [super init]) {
        _titleItems = titles;
        _iconItems = icons;
        
        _backgroundView = [[UIView alloc] initWithFrame:ZSScreenBounds()];
        _backgroundView.backgroundColor = ZSSTYLEVAR(backgroundViewColor);
        _backgroundView.alpha = 0.f;
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBack:)]];
    }
    return self;
}

- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ZSScreenHeight(), ZSScreenWidth(), (_titleItems.count + 1) * Row_Height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)show:(BOOL)enable animated:(BOOL)animate
{
    if (enable) {
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.backgroundView];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.tableView];
    }
    
    if (animate) {
        
        NSTimeInterval duration = enable ? 1 : Animate_Duration_Hide;
        if (enable) {
            [UIView animateWithDuration:duration delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^(){
                
                self.backgroundView.alpha = Alpha;
                self.tableView.bottom = ZSScreenHeight();
            } completion:NULL];
        }
        else {
            [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionTransitionFlipFromTop animations:^(){
                self.backgroundView.alpha = 0;
                self.tableView.top = ZSScreenHeight();
                
            } completion:^(BOOL finish){
                [self.tableView removeFromSuperview];
                [self.backgroundView removeFromSuperview];
                
                if ([self.menuDelegate respondsToSelector:@selector(pullDownMenuDidDismiss)]) {
                    [self.menuDelegate pullDownMenuDidDismiss];
                }
            }];
        }
    }
    else {
        if (!enable) {
            [self.tableView removeFromSuperview];
            [self.backgroundView removeFromSuperview];
            
            if ([self.menuDelegate respondsToSelector:@selector(pullDownMenuDidDismiss)]) {
                [self.menuDelegate pullDownMenuDidDismiss];
            }
        }
    }
}

- (void)tapBack:(UIGestureRecognizer *)recognizer
{
    [self show:NO animated:YES];
}

- (UIImage*)scaleImage:(UIImage*)image
{
    CGSize size = image.size;
    if (size.height > Row_Height - 20) {
        CGFloat scale = (Row_Height - 20) / size.height;
        size = CGSizeMake(Row_Height - 20, size.width * scale);
        
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return scaledImage;
    }
    return image;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleItems.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"pull_menu";
    
    ZSNavigationFilterMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZSNavigationFilterMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if ([indexPath row] == _titleItems.count) {
        [cell.textLabel setText:NSLocalizedString(@"Cancel", @"")];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    } else {
        NSString *title = [_titleItems objectAtIndex:[indexPath row]];
        NSAssert([title isKindOfClass:[NSString class]], @"title must be kind of NSString");
        [cell.textLabel setText:title];
    }
    
    if (_iconItems && [indexPath row] != _titleItems.count) {
        
        UIImage *image = [_iconItems objectAtIndex:[indexPath row]];
        NSAssert([image isKindOfClass:[UIImage class]], @"icon must be kind of UIImage");
        cell.imageView.image = [self scaleImage:image];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:ZSSTYLEVAR(cellBackgroundColor)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Row_Height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] != _titleItems.count) {
        self.selectRow = [indexPath row];
        
        if ([self.menuDelegate respondsToSelector:@selector(pullDownMenuDidChangeToRow:)]) {
            [self.menuDelegate pullDownMenuDidChangeToRow:self.selectRow];
        }
    }
    
    [self show:NO animated:YES];
}

@end
