//
//  HomeNavigationBar.m
//  task6rsschool
//
//  Created by Филипп on 6/24/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "HomeNavigationBar.h"
#import "HomeViewController.h"
#import "UIColor + Extension.h"
@interface HomeNavigationBar ()

@end

@implementation HomeNavigationBar

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *rootVc = [HomeViewController new];
    self.viewControllers = @[rootVc];
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.barTintColor = [UIColor rsschoolYellowColor];
    [self.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor rsschoolBlackColor]}];
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
