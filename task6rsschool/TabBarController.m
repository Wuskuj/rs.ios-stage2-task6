//
//  TabBarController.m
//  task6rsschool
//
//  Created by Филипп on 6/23/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationViewController.h"
#import "CollectionViewController.h"
#import "HomeViewController.h"
#import "UIColor + Extension.h"
#import "NavigationControllerImageScroll.h"
#import "HomeNavigationBar.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationViewController *controller = [NavigationViewController new];
    NavigationControllerImageScroll *collectionVC = [NavigationControllerImageScroll new];
    HomeNavigationBar *homeVC = [HomeNavigationBar new];
    self.viewControllers = @[controller,collectionVC,homeVC];
    for (UITabBarItem *tabBarItem in self.tabBar.items)
    {
        tabBarItem.title = @"";
        tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    self.tabBar.items.firstObject.image = [UIImage imageNamed:@"info_unselected"];
    self.tabBar.items[1].image = [UIImage imageNamed:@"gallery_unselected"];
    self.tabBar.items[2].image = [UIImage imageNamed:@"home_unselected"];
    self.tabBar.barTintColor = [UIColor rsschoolWhiteColor];
    self.tabBar.items[0].selectedImage = [UIImage imageNamed:@"info_selected"];
    self.tabBar.items[1].selectedImage = [UIImage imageNamed:@"gallery_selected"];
    self.tabBar.items[2].selectedImage = [UIImage imageNamed:@"home_selected"];
}

@end
