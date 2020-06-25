//
//  NavigationViewController.m
//  task6rsschool
//
//  Created by Филипп on 6/21/20.
//  Copyright © 2020 Filipp. All rights reserved.


#import "NavigationViewController.h"
#import "UIColor + Extension.h"
@interface NavigationViewController ()
@property (nonatomic,strong) TableViewFirstViewController *table;
@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table = [TableViewFirstViewController new];
    self.viewControllers = @[self.table];
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.barTintColor = [UIColor rsschoolYellowColor];
    [self.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor rsschoolBlackColor]}];
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self.table];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarItem.title = @"";
}





@end
