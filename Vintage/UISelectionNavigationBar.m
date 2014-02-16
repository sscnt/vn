//
//  UISelectionNavigationBar.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UISelectionNavigationBar.h"

@implementation UISelectionNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:40.0f/255.0f alpha:0.65f]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.0f, rect.size.height - 1.0f)];
    [bezierPath addLineToPoint: CGPointMake(rect.size.width, rect.size.height - 1.0f)];
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];

}


@end
