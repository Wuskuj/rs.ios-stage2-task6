//
//  TriangleView.m
//  task6rsschool
//
//  Created by Филипп on 6/20/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "TriangleView.h"
#import "UIColor + Extension.h"
@implementation TriangleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint   (context, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMidY(rect));  // mid right
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(context);

    UIColor *color = [UIColor rsschoolGreenColor];
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetRGBFillColor(context,red , green, blue, alpha);
    CGContextFillPath(context);
}



@end
