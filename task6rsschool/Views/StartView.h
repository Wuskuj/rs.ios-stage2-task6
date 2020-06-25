//
//  startView.h
//  task6rsschool
//
//  Created by Филипп on 6/19/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriangleView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol StartViewDelegate <NSObject>

-(void)onButtonTap;

@end


@interface StartView : UIView

@property(weak,nonatomic) id<StartViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *squareView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet TriangleView *triangleView;
@property (weak, nonatomic) IBOutlet UIView *circleView;
- (void)rotateImageView:(TriangleView*)view;
- (void)pulseCircle:(UIView*)view;

- (void)squarePoitionNew:(UIView*)view;
@end

NS_ASSUME_NONNULL_END
