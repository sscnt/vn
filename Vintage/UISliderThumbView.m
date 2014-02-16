//
//  UISliderThumbVIew.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UISliderThumbView.h"

@implementation UISliderThumbVIew

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 40.0f, 40.0f);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height)];
    [[UIColor whiteColor] setFill];
    [ovalPath fill];
    [[UIColor blackColor] setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
}


@end
