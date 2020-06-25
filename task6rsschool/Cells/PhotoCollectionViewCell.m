//
//  PhotoCollectionViewCell.m
//  task6rsschool
//
//  Created by Филипп on 6/23/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImageView];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageViewPhoto.frame = self.bounds;
}


-(void)setupImageView {
    self.imageViewPhoto = [[UIImageView alloc]init];
    self.imageViewPhoto.contentMode = UIViewContentModeScaleAspectFill;
    self.imageViewPhoto.clipsToBounds = true;
    self.imageViewPhoto.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.imageViewPhoto];

    [NSLayoutConstraint activateConstraints:@[
        [self.imageViewPhoto.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.imageViewPhoto.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.imageViewPhoto.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.imageViewPhoto.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
     ]];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imageViewPhoto.image = nil;
}


@end
