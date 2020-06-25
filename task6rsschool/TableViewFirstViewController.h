//
//  TableViewFirstViewController.h
//  task6rsschool
//
//  Created by Филипп on 6/20/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface TableViewFirstViewController : UIViewController<PHPhotoLibraryChangeObserver>
@property(nonatomic , strong) PHCachingImageManager *imageManager;
@end

NS_ASSUME_NONNULL_END
