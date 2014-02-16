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
    CGRect frame = CGRectMake(0.0f, 0.0f, radius * 8.0f, radius * 4.0f);
    self = [super initWithFrame:frame];
    if (self) {
        _radius = radius;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(_radius * 4.0f - _radius + 2.0f, _radius * 2.0f - _radius - 2.0f, _radius * 2.0 - 4.0f, _radius * 2.0 - 4.0f)];
    [[UIColor whiteColor] setFill];
    [ovalPath fill];
    [[UIColor colorWithWhite:26.0f/255.0f alpha:1.0f] setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
}

@end
