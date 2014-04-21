//
//  VnVIewEditorToolBar.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnVIewEditorToolBar.h"

@implementation VnVIewEditorToolBar

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen width], 50.0f);
    self = [super initWithFrame:frame];
    if (self) {
        _right = 0.0f;
        self.backgroundColor = [UIColor colorWithRed:s255(32.0f) green:s255(30.0f) blue:s255(30.0f) alpha:1.0];
    }
    return self;
}

- (void)appendButton:(VnViewEditorToolBarButton *)button
{
    [button setX:_right];
    [self addSubview:button];
    _right = [button right];
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed:s255(2.0f) green:s255(0.0f) blue:s255(0.0f) alpha:0.10f];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, 0)];
    [bezierPath addLineToPoint: CGPointMake(rect.size.width, 0)];
    [color setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    //// Bezier Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, rect.size.height)];
    [bezierPath addLineToPoint: CGPointMake(rect.size.width, rect.size.height)];
    [color setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    

}

@end
