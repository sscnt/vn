//
//  UISliderThumbVIew.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UISliderThumbView.h"

@implementation UISliderThumbVIew

- (id)initWithRadius:(CGFloat)radius
{
    CGRect frame = CGRectMake(0.0f, 0.0f, radius * 2.0f, radius * 2.0f);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(2.0f, 2.0f, rect.size.width - 4.0f, rect.size.height - 4.0f)];
    [[UIColor whiteColor] setFill];
    [ovalPath fill];
    [[UIColor blackColor] setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
}


@end
