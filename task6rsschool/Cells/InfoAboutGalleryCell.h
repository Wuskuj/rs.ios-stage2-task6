//
//  InfoAboutGalleryCell.h
//  task6rsschool
//
//  Created by Филипп on 6/20/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Photos;
NS_ASSUME_NONNULL_BEGIN

@interface InfoAboutGalleryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelOneq;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (nonatomic, strong) PHImageManager *manager;
@property (nonatomic,strong) UIImage *imageForAsset;

@end

NS_ASSUME_NONNULL_END
