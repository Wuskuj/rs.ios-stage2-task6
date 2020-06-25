//
//  NavigationControllerImageScrollViewController.m
//  task6rsschool
//
//  Created by Филипп on 6/23/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "NavigationControllerImageScroll.h"
#import "CollectionViewController.h"
#import "UIColor + Extension.h"
@import Photos;
@interface NavigationControllerImageScroll ()

@end

@implementation NavigationControllerImageScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    CollectionViewController *rootVc = [CollectionViewController new];
    self.viewControllers = @[rootVc];
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.barTintColor = [UIColor rsschoolYellowColor];
    [self.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor rsschoolBlackColor]}];
     [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:rootVc];
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
