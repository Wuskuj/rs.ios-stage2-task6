//
//  Data.m
//  task6rsschool
//
//  Created by Филипп on 6/22/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "Data.h"
#import "UIColor + Extension.h"
@interface Data()

@end


@implementation Data


-(void)getPicture:(InfoAboutFileViewController*)controller asset:(PHAsset*)asset 
{
    if (self.asset != asset) {
        self.asset = asset;
    __weak Data *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        weakSelf.manager = [PHImageManager defaultManager];
        PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
        [requestOptions setSynchronous:NO];
        [requestOptions setVersion:PHImageRequestOptionsVersionCurrent];
        [requestOptions setDeliveryMode:PHImageRequestOptionsDeliveryModeOpportunistic];
        [requestOptions setResizeMode:PHImageRequestOptionsResizeModeNone];

        [weakSelf.manager requestImageForAsset:weakSelf.asset
                                    targetSize:PHImageManagerMaximumSize
                                   contentMode:PHImageContentModeDefault
                                       options:requestOptions
                                 resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    controller.imageView.image = result;
                });
        }];
    });
    }
}
@end
