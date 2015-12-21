//
//  CVPullDownMenuController.h
//  CV
//
//  Created by bv-zheng on 12/3/15.
//  Copyright © 2015 Broadvision. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZSPullDownMenuDelegate <NSObject>

- (void)pullDownMenuDidDismiss;

- (void)pullDownMenuDidChangeToRow:(NSInteger)row;

@end

@interface ZSNavigationFilterMenuController : UITableViewController

@property (nonatomic, retain) NSArray *items;
@property (nonatomic, assign) NSInteger selectRow;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, unsafe_unretained) id<ZSPullDownMenuDelegate> menuDelegate;

- (instancetype)initWithItems:(NSArray *)items;

- (void)show:(BOOL)enable animated:(BOOL)animate;

@end
