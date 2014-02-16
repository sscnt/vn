//
//  UISelectionNavigationBar.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UINavigationBarView.h"

@implementation UINavigationBarView

- (id)initWithPosition:(NavigationBarViewPosition)position
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 44.0f);
    if (position == NavigationBarViewPositionBottom) {
        frame = CGRectMake(0.0f, [UIScreen screenSize].height - 44.0f, [UIScreen screenSize].width, 44.0f);
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:40.0f/255.0f alpha:0.65f]];
        _position = position;
        _buttonWidth = 44.0f;
        _rightButtonPositionLeft = [UIScreen screenSize].width - _buttonWidth;
        _leftButtonPositionLeft = 0.0f;
    }
    return self;
}

- (void)appendButtonToLeft:(UIButton *)button
{
    button.center = CGPointMake(ceilf(_buttonWidth / 2.0) + _leftButtonPositionLeft, 22.0f);
    [self addSubview:button];
    _leftButtonPositionLeft += _buttonWidth;
}

- (void)appendButtonToRight:(UIButton *)button
{
    button.center = CGPointMake(_rightButtonPositionLeft - ceilf(_buttonWidth / 2.0), 22.0f);
    [self addSubview:button];
    _rightButtonPositionLeft -= _buttonWidth;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat y = rect.size.height;
    if (self.position == NavigationBarViewPositionBottom) {
        y = 0.0f;
    }
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.0f, y)];
    [bezierPath addLineToPoint: CGPointMake(rect.size.width, y)];
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];

}


@end
