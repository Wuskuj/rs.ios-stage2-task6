//
//  startView.m
//  task6rsschool
//
//  Created by Филипп on 6/19/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "StartView.h"
#import "TriangleView.h"
#import "UIColor + Extension.h"

@interface StartView ()


@end


@implementation StartView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

-(void)customInit
{
    [[NSBundle mainBundle] loadNibNamed:@"CustomStartView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    [self setupSettings];
    [self setupButton];
}


-(void)setupButton
{
    [self.startButton setTitle:@"START" forState:UIControlStateNormal];
    self.startButton.backgroundColor = UIColor.rsschoolYellowColor;
    [self.startButton setTitleColor:UIColor.rsschoolBlackColor forState:UIControlStateNormal];
    self.startButton.layer.cornerRadius = self.startButton.frame.size.height / 2;
    self.startButton.clipsToBounds = YES;
    [self.startButton addTarget:self
                         action:@selector(actionForButton)
               forControlEvents:UIControlEventTouchUpInside];

}


-(void)actionForButton
{
    [self.delegate onButtonTap];
}


- (void)rotateImageView:(TriangleView*)view
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [view setTransform:CGAffineTransformRotate(view.transform, M_PI_2)];
    }completion:^(BOOL finished){
        if (finished) {
            [self rotateImageView:view];
        }
    }];
}


- (void)pulseCircle:(UIView*)view
{
    view.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateKeyframesWithDuration:1 delay:0 options: UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat animations:^{
        view.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {

    }];

}


- (void)squarePoitionNew:(UIView*)view
{
    CGRect startFrame = view.frame;
    CGRect frame = view.frame;
    frame.origin.y = view.frame.size.width / 10;

    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = frame;
    }completion:^(BOOL finished){
        if (finished) {
            if (startFrame.origin.y != 0 ) {
                [self newPostiton:view];
            }else {
                [self squarePoitionNew:view];
            }

        }
    }];
}

- (void)newPostiton:(UIView*)view
{
    CGRect frame = view.frame;
    frame.origin.y = view.frame.origin.y - (view.frame.size.width / 10) * 2;

    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = frame;
    }completion:^(BOOL finished){
        if (finished) {
            [self squarePoitionNew:view];
        }
    }];

}


-(void)setupSettings {
    self.circleView.layer.cornerRadius = CGRectGetHeight(self.circleView.frame) / 2;
    self.circleView.backgroundColor = [UIColor rsschoolRedColor];
    self.circleView.clipsToBounds = YES;
    self.squareView.backgroundColor = [UIColor rsschoolBlueColor];
}

@end
