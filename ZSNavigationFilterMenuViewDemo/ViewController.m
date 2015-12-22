//
//  ViewController.m
//  ZSNavigationFilterMenuViewDemo
//
//  Created by bv-zheng on 12/21/15.
//  Copyright © 2015 Sera. All rights reserved.
//

#import "ViewController.h"
#import "ZSNavigationFilterMenu.h"
#import "ZSStyleSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSArray *titleItems = @[@"12Test", @"1234Test", @"123456Test", @"12345678Test", @"1234567890Test"];

    /** Use titles with icons
     
    NSArray *iconItems = @[[UIImage imageNamed:@"numbers"],
                           [UIImage imageNamed:@"offline_files"],
                           [UIImage imageNamed:@"ok"],
                           [UIImage imageNamed:@"pages"],
                           [UIImage imageNamed:@"pdf"]];
    ZSNavigationFilterMenu *filterMenu = [[ZSNavigationFilterMenu alloc] initWithTitleItems:titleItems iconItems:iconItems];
    */
    
    // Use titles only, set selectRow necessarily
    ZSNavigationFilterMenu *filterMenu = [[ZSNavigationFilterMenu alloc] init];
    [filterMenu setTitleItems:titleItems];
    [filterMenu setSelectRow:0];
    
    self.navigationItem.titleView = filterMenu;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(33, 132, 214);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
