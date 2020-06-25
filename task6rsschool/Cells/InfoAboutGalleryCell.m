//
//  InfoAboutGalleryCell.m
//  task6rsschool
//
//  Created by Филипп on 6/20/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "InfoAboutGalleryCell.h"
#import "UIColor + Extension.h"

@interface InfoAboutGalleryCell()

@end


@implementation InfoAboutGalleryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageViewCell.contentMode = UIViewContentModeScaleAspectFill;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.imageViewCell = [UIImageView new];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageViewCell = [UIImageView new];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imageViewCell.image = [UIImage imageNamed:@"noPhoto"];
}




@end
