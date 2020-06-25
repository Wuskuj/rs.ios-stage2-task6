//
//  ImagePreviewFullViewCell.m
//  task6rsschool
//
//  Created by Филипп on 6/23/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "ImagePreviewFullViewCell.h"

@implementation ImagePreviewFullViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupImageViewAndScroll];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImageViewAndScroll];
    }
    return self;
}


-(void)setupImageViewAndScroll {
    self.scrollImg = [[UIScrollView alloc] init];
    self.scrollImg.delegate = self;
    self.scrollImg.alwaysBounceVertical = false;
    self.scrollImg.alwaysBounceHorizontal = false;
    self.scrollImg.showsVerticalScrollIndicator = true;
    [self.scrollImg flashScrollIndicators];

    self.scrollImg.minimumZoomScale = 1.0;
    self.scrollImg.maximumZoomScale = 4.0;

    self.doubleTapGet = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapScrollViews:)];
    self.doubleTapGet.numberOfTapsRequired = 2;
    [self.scrollImg addGestureRecognizer:self.doubleTapGet];
    [self addSubview:self.scrollImg];



    self.imgView = [[UIImageView alloc]init];
    self.backgroundColor = [UIColor blackColor];

    self.imgView.clipsToBounds = true;
    [self.scrollImg addSubview:self.imgView];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.doubleTapGet.delegate = self;
}

-(void)handleDoubleTapScrollViews:(UITapGestureRecognizer*)recognizer
{
    if (self.scrollImg.zoomScale == 1) {
        [self.scrollImg zoomToRect:[self zoomRectForScale:self.scrollImg.maximumZoomScale center:[recognizer locationInView:recognizer.view]] animated:true];
    }else {
        [self.scrollImg setZoomScale:1 animated:true];
    }
}


-(CGRect)zoomRectForScale:(CGFloat)scale center:(CGPoint)center
{
    CGRect zoomRect = CGRectZero;
    zoomRect.size.height = self.imgView.frame.size.height / scale;
    zoomRect.size.width = self.imgView.frame.size.width / scale;
    CGPoint newCenter = [self.imgView convertPoint:center fromView:self.scrollImg];
    zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgView;
}

- (void)prepareForReuse
{
    [self.scrollImg setZoomScale:1 animated:true];
}


- (void)layoutSubviews
{
    self.scrollImg.frame = self.bounds;
    self.imgView.frame = self.bounds;
}
@end
