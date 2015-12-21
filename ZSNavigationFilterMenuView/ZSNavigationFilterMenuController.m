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

@end

@implementation ZSNavigationFilterMenuController

- (instancetype)initWithItems:(NSArray *)items
{
    if (self = [super init]) {
        _items = items;
        _backgroundView = [[UIView alloc] initWithFrame:ZSScreenBounds()];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.alpha = 0.f;
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBack:)]];
    }
    return self;
}

- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ZSScreenHeight(), ZSScreenWidth(), (_items.count + 1) * Row_Height)];
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
        NSTimeInterval duration = enable ? Animate_Duration_Show : Animate_Duration_Hide;
        [UIView animateWithDuration:duration animations:^(){
            
            if (enable) {
                self.backgroundView.alpha = Alpha;
                self.tableView.bottom = ZSScreenHeight();
            } else {
                self.backgroundView.alpha = 0;
                self.tableView.top = ZSScreenHeight();
            }
        } completion:^(BOOL finished){
            if (enable) {

            } else {
                [self.tableView removeFromSuperview];
                [self.backgroundView removeFromSuperview];
                
                if ([self.menuDelegate respondsToSelector:@selector(pullDownMenuDidDismiss)]) {
                    [self.menuDelegate pullDownMenuDidDismiss];
                }
            }
        }];
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

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"pull_menu";
    
    ZSNavigationFilterMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZSNavigationFilterMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if ([indexPath row] == _items.count) {
        [cell.textLabel setText:NSLocalizedString(@"Cancel", @"")];
    } else {
        [cell.textLabel setText:[_items objectAtIndex:[indexPath row]]];
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
    if ([indexPath row] != _items.count) {
        self.selectRow = [indexPath row];
        
        if ([self.menuDelegate respondsToSelector:@selector(pullDownMenuDidChangeToRow:)]) {
            [self.menuDelegate pullDownMenuDidChangeToRow:self.selectRow];
        }
    }
    
    [self show:NO animated:YES];
}

@end
