//
//  CVSourceFilterTitleView.h
//  CV
//
//  Created by bv-zheng on 12/3/15.
//  Copyright © 2015 Broadvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSNavigationFilterMenuController.h"

@interface ZSNavigationFilterMenu : UIButton <ZSPullDownMenuDelegate>


/**
 *  @brief selected row
 */
@property (nonatomic, assign) NSInteger selectRow;

/**
 *  @brief all title menus
 */
@property (nonatomic, retain) NSArray *titleItems;

/**
 *  @brief default title attributes for UIControlStateNormal
 */
@property (nonatomic, retain) NSDictionary *defaultAttributes;

/**
 *  @brief highlight title attributes for UIControlStateHighlighted
 */
@property (nonatomic, retain) NSDictionary *highlightAttributes;

/**
 *  @brief max size for title
 */
@property (nonatomic, assign) CGSize maxSize;

/**
 *  @brief pull down controller
 */
@property (nonatomic, retain, readonly) ZSNavigationFilterMenuController *pullMenuController;

/**
 *  @brief reload menu every show time
 */
@property (nonatomic, assign) BOOL shouldReload;

/**
 *  @brief block for selecting one menu
 */
@property (nonatomic, copy) void (^changeTitleCompletion)(NSString *title, NSInteger row);

- (instancetype)initWithTitle:(NSString *)title;

@end
