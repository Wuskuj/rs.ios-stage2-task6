//
//  ViewController.m
//  task6rsschool
//
//  Created by Филипп on 6/19/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "ViewController.h"
#import "StartView.h"
#import "NavigationViewController.h"
#import "TabBarController.h"
@interface ViewController ()<StartViewDelegate>
@property(strong, nonatomic) StartView *startView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.startView = [[StartView alloc] initWithFrame:self.view.frame];
    self.startView.delegate = self;
    [self setupView];

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{   [super viewDidAppear:animated];
    [self.startView rotateImageView:self.startView.triangleView];
    [self.startView squarePoitionNew:self.startView.squareView];
    [self.startView pulseCircle:self.startView.circleView];
}
-(void)setupView
{
    [self.view addSubview:self.startView];
    self.startView.translatesAutoresizingMaskIntoConstraints = false;

    [NSLayoutConstraint activateConstraints:@[
        [self.startView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.startView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.startView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.startView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor]
    ]];
}


- (void)onButtonTap
{

    if (PHPhotoLibrary.authorizationStatus == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized){
                dispatch_async(dispatch_get_main_queue(), ^{
                    TabBarController *vc = [TabBarController new];
                    vc.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:vc animated:true completion:nil];
                });
            }
        }];
    }else if (PHPhotoLibrary.authorizationStatus == PHAuthorizationStatusAuthorized){
        dispatch_async(dispatch_get_main_queue(), ^{
            TabBarController *vc = [TabBarController new];
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:vc animated:true completion:nil];
        });
    }

}


@end
