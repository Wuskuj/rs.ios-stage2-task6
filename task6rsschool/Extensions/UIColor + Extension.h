//
//  UIColor + Extension.h
//  task6rsschool
//
//  Created by Филипп on 6/20/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "UIkit/UIkit.h"

@interface UIColor (RSSchool)

+(UIColor *)rsschoolBlackColor;
+(UIColor *)rsschoolWhiteColor;
+(UIColor *)rsschoolRedColor;
+(UIColor *)rsschoolBlueColor;
+(UIColor *)rsschoolGreenColor;
+(UIColor *)rsschoolYellowColor;
+(UIColor *)rsschoolGrayColor;
+(UIColor *)rsschoolYellowHighlightedColor;

+ (UIColor *)colorWithHexString:(NSString *) hexString;
@end
