//
//  HomeViewController.m
//  task6rsschool
//
//  Created by Филипп on 6/23/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor + Extension.h"
#import "ViewController.h"
@interface HomeViewController ()
@property (nonatomic, strong) StartView *startView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customInit];
    [self setupSettings];
    self.startView = [StartView new];
    [self setupLabels];
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.title = @"RSSchool 6 Task";
    self.view.backgroundColor = [UIColor rsschoolWhiteColor];
}


-(void)customInit
{
    [[NSBundle mainBundle] loadNibNamed:@"HomeViewController" owner:self options:nil];
    self.imageViewApple.image =  [UIImage imageNamed:@"apple"];
    [self setupButton:[UIColor rsschoolYellowColor] tintColor:[UIColor rsschoolBlackColor] button:self.buttonOpenGitVC titile:@"Open Git VC" action:@selector(actionForButtonGoToRSSchool)];
    [self setupButton:[UIColor rsschoolRedColor] tintColor:[UIColor rsschoolWhiteColor] button:self.goToStartButton titile:@"Go to start!" action:@selector(actionForButtonGoToStartVC)];
    self.lineOneView.backgroundColor = [UIColor rsschoolGrayColor];
    self.secondLineView.backgroundColor = [UIColor rsschoolGrayColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    [self.startView rotateImageView:self.triangleView];
    [self.startView squarePoitionNew:self.squareView];
    [self.startView pulseCircle:self.circleView];
}

- (void)viewWillLayoutSubviews
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    BOOL isLandscape = UIDeviceOrientationIsLandscape(orientation);
    if (isLandscape) {
        [self.scrollView setScrollEnabled:true];
    }else {
        [self.scrollView setScrollEnabled:false];
    }

}

-(void)setupSettings {
    self.circleView.layer.cornerRadius = CGRectGetHeight(self.circleView.frame) / 2;
    self.circleView.backgroundColor = [UIColor rsschoolRedColor];
    self.circleView.clipsToBounds = YES;
    self.squareView.backgroundColor = [UIColor rsschoolBlueColor];
}

-(void)setupButton:(UIColor*)color tintColor:(UIColor*)tintColor button:(UIButton*)button titile:(NSString*)string action:(SEL)action
{
    [button setTitle:string forState:UIControlStateNormal];
    button.backgroundColor = color;
    [button setTitleColor:tintColor forState:UIControlStateNormal];
    button.layer.cornerRadius = button.frame.size.height / 2;
    button.clipsToBounds = YES;
    [button addTarget:self
                         action:action
               forControlEvents:UIControlEventTouchUpInside];
}

-(void)actionForButtonGoToRSSchool
{
    NSURL *safariUrl = [NSURL URLWithString:@"https://wuskuj.github.io/rsschool-cv/cv"];
    [[UIApplication sharedApplication] openURL:safariUrl options:@{} completionHandler:nil];

}
-(void)actionForButtonGoToStartVC
{
    ViewController *vc = [ViewController new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:true completion:nil];
}

-(void)setupLabels
{
    self.nameLabel.text = UIDevice.currentDevice.name;
    self.modelLabel.text = UIDevice.currentDevice.model;
    self.systemLabel.text = [NSString stringWithFormat:@"%@ %@", UIDevice.currentDevice.systemName ,UIDevice.currentDevice.systemVersion];
}

@end
