//
//  Data.h
//  task6rsschool
//
//  Created by Филипп on 6/22/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoAboutGalleryCell.h"
#import "InfoAboutFileViewController.h"
@import Photos;
NS_ASSUME_NONNULL_BEGIN

@interface Data : NSObject
@property (strong, nonatomic) UIImage *image;
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, strong) PHImageManager *manager;
@property (nonatomic, strong) NSIndexPath *indexPath;
-(void)getPicture:(InfoAboutFileViewController*)controller asset:(PHAsset*)asset;
@end

NS_ASSUME_NONNULL_END
