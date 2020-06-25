//
//  InfoAboutFileViewController.m
//  task6rsschool
//
//  Created by Филипп on 6/22/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "InfoAboutFileViewController.h"
#import "UIColor + Extension.h"
@import Photos;
@interface InfoAboutFileViewController ()

@end

@implementation InfoAboutFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.asset = [PHAsset new];
    self.asset = self.assetSend;
    self.creationDateLabel.text = self.stringCreationDate;
    self.modificationDateLabel.text = self.stringModificationDate;
    self.typeImageLabel.text = self.stringType;
    [self setupButton];
    [self setupSettings];
}


-(void)setupButton
{
    [self.buttonLabel setTitle:@"Share" forState:UIControlStateNormal];
    self.buttonLabel.backgroundColor = UIColor.rsschoolYellowColor;
    [self.buttonLabel setTitleColor:UIColor.rsschoolBlackColor forState:UIControlStateNormal];
    self.buttonLabel.layer.cornerRadius = self.buttonLabel.frame.size.height / 2;
    self.buttonLabel.clipsToBounds = YES;
    [self.buttonLabel addTarget:self
                         action:@selector(actionForButton)
               forControlEvents:UIControlEventTouchUpInside];

}


- (void)viewWillLayoutSubviews
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    BOOL isLandscape = UIDeviceOrientationIsLandscape(orientation);
    if (isLandscape) {
        [self.scrollView setScrollEnabled:true];
    }else {
         [self.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
         [self.scrollView setScrollEnabled:false];
    }
    
}



-(void)actionForButton
{
    if ([self.stringType isEqualToString:@"Video"])
    {
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:self.asset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *videoAsset = (AVURLAsset *)asset;
            NSURL *videoURL = videoAsset.URL;


            dispatch_async(dispatch_get_main_queue(), ^{
                UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[videoURL] applicationActivities:nil];
                activityViewController.excludedActivityTypes = @[UIActivityTypeSaveToCameraRoll];
                if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
                    [self presentViewController:activityViewController animated:true completion:nil];
                }else {
                    activityViewController.modalPresentationStyle = UIModalPresentationPopover;
                    [self presentViewController:activityViewController animated:true completion:nil];
                    UIPopoverPresentationController *presentationController =
                    [activityViewController popoverPresentationController];
                    presentationController.permittedArrowDirections =
                    UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
                    presentationController.sourceView = self.view;
                    presentationController.sourceRect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0);
                }

            });
        }];
    }else if ([self.stringType isEqualToString:@"Image"])
    {
        [self.asset requestContentEditingInputWithOptions:[PHContentEditingInputRequestOptions new] completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
            NSURL *imageURL = contentEditingInput.fullSizeImageURL;
            dispatch_async(dispatch_get_main_queue(), ^{
                UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[imageURL] applicationActivities:nil];
                activityViewController.excludedActivityTypes = @[UIActivityTypeSaveToCameraRoll];

                if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
                    [self presentViewController:activityViewController animated:true completion:nil];
                }
                else {
                    activityViewController.modalPresentationStyle = UIModalPresentationPopover;
                    [self presentViewController:activityViewController animated:true completion:nil];
                    UIPopoverPresentationController *presentationController =
                    [activityViewController popoverPresentationController];
                    presentationController.permittedArrowDirections =
                    UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
                    presentationController.sourceView = self.view;
                    presentationController.sourceRect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0);
                }
            });
        }];
    }
}

-(void)setupSettings
{
    self.modificationDateGrayLabel.textColor = [UIColor rsschoolGrayColor];
    self.creationDateGrayLabel.textColor = [UIColor rsschoolGrayColor];
    self.typeGrayLabel.textColor = [UIColor rsschoolGrayColor];
    self.creationDateLabel.textColor = [UIColor rsschoolBlackColor];
    self.modificationDateLabel.textColor = [UIColor rsschoolBlackColor];
    self.typeImageLabel.textColor = [UIColor rsschoolBlackColor];
}



@end
