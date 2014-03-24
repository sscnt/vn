//
//  UIFocusControlView.m
//  Vintage
//
//  Created by SSC on 2014/03/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIFocusControlView.h"

@implementation UIFocusControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //// 12時の方向を0
        _angle = 0.0f;
        _defaultPosition = self.center;
        _position = _defaultPosition;
        self.backgroundColor = [UIColor clearColor];
        
        //// Rotation
        UIFocusRotationControlView* rotation = [[UIFocusRotationControlView alloc] init];
        rotation.delegate = self;
        [self addSubview:rotation];
    }
    return self;
}
- (void)setActive:(BOOL)active
{
    _active = active;
    if(active){
        self.alpha = 1.0f;
    }else{
        self.alpha = 0.40f;
    }
}

- (void)rotation:(UIFocusRotationControlView *)view didAngleChange:(CGFloat)angle
{
    _angle = angle;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.992 green: 0.616 blue: 0 alpha: 1];
    
    //// Oval Drawing
    CGFloat ovalRadius = 15.0f;
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - ovalRadius, rect.size.height / 2.0f - ovalRadius, ovalRadius * 2.0f, ovalRadius * 2.0f)];
    [color setStroke];
    ovalPath.lineWidth = 3;
    [ovalPath stroke];
    ovalRadius = 10.0f;
    ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - ovalRadius, rect.size.height / 2.0f - ovalRadius, ovalRadius * 2.0f, ovalRadius * 2.0f)];
    [color setStroke];
    ovalPath.lineWidth = 2;
    [ovalPath stroke];
    ovalRadius = 6.0f;
}


@end
