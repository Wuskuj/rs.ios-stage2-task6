//
//  ImagePreviewFullViewCell.h
//  task6rsschool
//
//  Created by Филипп on 6/23/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagePreviewFullViewCell : UICollectionViewCell <UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIScrollView *scrollImg;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGet;
@end

NS_ASSUME_NONNULL_END
