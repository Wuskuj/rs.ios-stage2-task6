//
//  InfoAboutFileViewController.h
//  task6rsschool
//
//  Created by Филипп on 6/22/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;
NS_ASSUME_NONNULL_BEGIN

@interface InfoAboutFileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *creationDateGrayLabel;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateGrayLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeGrayLabel;



@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeImageLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonLabel;
@property (strong, nonatomic) UIImageView *imageSet;

@property (nonatomic, strong) NSString *stringCreationDate;
@property (nonatomic, strong) NSString *stringModificationDate;
@property (nonatomic, strong) NSString *stringType;

@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, strong) PHAsset *assetSend;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
