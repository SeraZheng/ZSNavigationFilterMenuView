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
    ZSNavigationFilterMenu *filterMenu = [[ZSNavigationFilterMenu alloc] initWithTitle:[titleItems objectAtIndex:0]];
    [filterMenu setTitleItems:titleItems];
    
    self.navigationItem.titleView = filterMenu;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(33, 132, 214);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
