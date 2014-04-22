//
//  VnViewEditorToolBarButton.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewEditorToolBarButton.h"

@implementation VnViewEditorToolBarButton

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [VnCurrentSettings barHeight], [VnCurrentSettings barHeight]);
    self = [super initWithFrame:frame];
    if (self) {
        self.highlighted = NO;
        self.enabled = NO;
        _childButtons = [NSMutableArray array];
        self.delegate = [VnEditorButtonManager instance];
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.80f;
        [self addTarget:self action:@selector(didTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setToolId:(VnAdjustmentToolId)toolId
{
    _toolId = toolId;
    [self setNeedsDisplay];
}

#pragma mark flag



#pragma mark event

- (void)didTouchUpInside
{
    [self.delegate didToolBarButtonTouchUpInside:self];
}

#pragma mark drawrect

- (UIColor *)fillColor
{
    return [UIColor colorWithWhite:1.0f alpha:0.80f];
}

- (void)drawRect:(CGRect)rect
{
    switch (_toolId) {
        case VnAdjustmentToolIdEffects:
            [self drawRectEffects:rect];
            break;
        case VnAdjustmentToolIdEffectOpacity:
            break;
        default:
            break;
    }
}

- (void)drawRectEffects:(CGRect)rect
{
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(35.24, 27.61)];
    [bezierPath addCurveToPoint: CGPointMake(31.85, 31.71) controlPoint1: CGPointMake(34.27, 29.18) controlPoint2: CGPointMake(33.14, 30.55)];
    [bezierPath addCurveToPoint: CGPointMake(29.07, 33.6) controlPoint1: CGPointMake(31.1, 32.38) controlPoint2: CGPointMake(30.17, 33.01)];
    [bezierPath addCurveToPoint: CGPointMake(25.63, 34.84) controlPoint1: CGPointMake(27.96, 34.19) controlPoint2: CGPointMake(26.81, 34.6)];
    [bezierPath addCurveToPoint: CGPointMake(24.73, 34.95) controlPoint1: CGPointMake(25.33, 34.88) controlPoint2: CGPointMake(25.03, 34.92)];
    [bezierPath addCurveToPoint: CGPointMake(23.82, 35) controlPoint1: CGPointMake(24.43, 34.98) controlPoint2: CGPointMake(24.12, 35)];
    [bezierPath addCurveToPoint: CGPointMake(21.31, 34.5) controlPoint1: CGPointMake(22.94, 35) controlPoint2: CGPointMake(22.1, 34.83)];
    [bezierPath addCurveToPoint: CGPointMake(19.28, 32.77) controlPoint1: CGPointMake(20.51, 34.17) controlPoint2: CGPointMake(19.84, 33.59)];
    [bezierPath addCurveToPoint: CGPointMake(18.55, 31.32) controlPoint1: CGPointMake(18.93, 32.3) controlPoint2: CGPointMake(18.69, 31.82)];
    [bezierPath addCurveToPoint: CGPointMake(18.34, 29.84) controlPoint1: CGPointMake(18.41, 30.83) controlPoint2: CGPointMake(18.34, 30.33)];
    [bezierPath addCurveToPoint: CGPointMake(18.44, 28.79) controlPoint1: CGPointMake(18.34, 29.5) controlPoint2: CGPointMake(18.37, 29.15)];
    [bezierPath addCurveToPoint: CGPointMake(18.7, 27.71) controlPoint1: CGPointMake(18.5, 28.44) controlPoint2: CGPointMake(18.59, 28.08)];
    [bezierPath addCurveToPoint: CGPointMake(19.44, 25.82) controlPoint1: CGPointMake(18.89, 27.09) controlPoint2: CGPointMake(19.14, 26.46)];
    [bezierPath addCurveToPoint: CGPointMake(20.37, 23.97) controlPoint1: CGPointMake(19.74, 25.19) controlPoint2: CGPointMake(20.05, 24.57)];
    [bezierPath addCurveToPoint: CGPointMake(21.32, 22.15) controlPoint1: CGPointMake(20.7, 23.35) controlPoint2: CGPointMake(21.01, 22.74)];
    [bezierPath addCurveToPoint: CGPointMake(22.08, 20.42) controlPoint1: CGPointMake(21.64, 21.56) controlPoint2: CGPointMake(21.89, 20.98)];
    [bezierPath addCurveToPoint: CGPointMake(22.26, 19.81) controlPoint1: CGPointMake(22.17, 20.21) controlPoint2: CGPointMake(22.23, 20)];
    [bezierPath addCurveToPoint: CGPointMake(22.31, 19.29) controlPoint1: CGPointMake(22.29, 19.62) controlPoint2: CGPointMake(22.31, 19.44)];
    [bezierPath addCurveToPoint: CGPointMake(21.82, 18.2) controlPoint1: CGPointMake(22.31, 18.82) controlPoint2: CGPointMake(22.15, 18.45)];
    [bezierPath addCurveToPoint: CGPointMake(20.34, 17.81) controlPoint1: CGPointMake(21.5, 17.94) controlPoint2: CGPointMake(21.01, 17.81)];
    [bezierPath addCurveToPoint: CGPointMake(17.39, 18.94) controlPoint1: CGPointMake(19.22, 17.81) controlPoint2: CGPointMake(18.24, 18.19)];
    [bezierPath addCurveToPoint: CGPointMake(15.99, 21.74) controlPoint1: CGPointMake(16.54, 19.69) controlPoint2: CGPointMake(16.07, 20.63)];
    [bezierPath addCurveToPoint: CGPointMake(15.95, 21.99) controlPoint1: CGPointMake(15.96, 21.83) controlPoint2: CGPointMake(15.95, 21.91)];
    [bezierPath addCurveToPoint: CGPointMake(15.95, 22.23) controlPoint1: CGPointMake(15.95, 22.06) controlPoint2: CGPointMake(15.95, 22.14)];
    [bezierPath addCurveToPoint: CGPointMake(16.63, 23.63) controlPoint1: CGPointMake(15.95, 22.98) controlPoint2: CGPointMake(16.18, 23.45)];
    [bezierPath addCurveToPoint: CGPointMake(18.28, 24) controlPoint1: CGPointMake(17.08, 23.81) controlPoint2: CGPointMake(17.63, 23.94)];
    [bezierPath addCurveToPoint: CGPointMake(18.42, 24.02) controlPoint1: CGPointMake(18.32, 24) controlPoint2: CGPointMake(18.37, 24.01)];
    [bezierPath addCurveToPoint: CGPointMake(18.6, 24.03) controlPoint1: CGPointMake(18.48, 24.03) controlPoint2: CGPointMake(18.54, 24.03)];
    [bezierPath addCurveToPoint: CGPointMake(18.34, 24.31) controlPoint1: CGPointMake(18.51, 24.12) controlPoint2: CGPointMake(18.43, 24.21)];
    [bezierPath addCurveToPoint: CGPointMake(18.12, 24.62) controlPoint1: CGPointMake(18.26, 24.41) controlPoint2: CGPointMake(18.18, 24.51)];
    [bezierPath addCurveToPoint: CGPointMake(18, 24.76) controlPoint1: CGPointMake(18.07, 24.66) controlPoint2: CGPointMake(18.03, 24.71)];
    [bezierPath addCurveToPoint: CGPointMake(17.89, 24.91) controlPoint1: CGPointMake(17.97, 24.82) controlPoint2: CGPointMake(17.93, 24.86)];
    [bezierPath addCurveToPoint: CGPointMake(17, 25.71) controlPoint1: CGPointMake(17.61, 25.23) controlPoint2: CGPointMake(17.31, 25.5)];
    [bezierPath addCurveToPoint: CGPointMake(16.08, 26.2) controlPoint1: CGPointMake(16.69, 25.93) controlPoint2: CGPointMake(16.38, 26.09)];
    [bezierPath addCurveToPoint: CGPointMake(15.5, 26.34) controlPoint1: CGPointMake(15.89, 26.26) controlPoint2: CGPointMake(15.7, 26.31)];
    [bezierPath addCurveToPoint: CGPointMake(14.95, 26.39) controlPoint1: CGPointMake(15.31, 26.38) controlPoint2: CGPointMake(15.13, 26.39)];
    [bezierPath addCurveToPoint: CGPointMake(12.7, 25.41) controlPoint1: CGPointMake(14.09, 26.39) controlPoint2: CGPointMake(13.34, 26.06)];
    [bezierPath addCurveToPoint: CGPointMake(11.73, 22.94) controlPoint1: CGPointMake(12.05, 24.75) controlPoint2: CGPointMake(11.73, 23.93)];
    [bezierPath addCurveToPoint: CGPointMake(11.83, 22.07) controlPoint1: CGPointMake(11.73, 22.66) controlPoint2: CGPointMake(11.76, 22.37)];
    [bezierPath addCurveToPoint: CGPointMake(12.12, 21.13) controlPoint1: CGPointMake(11.89, 21.77) controlPoint2: CGPointMake(11.99, 21.46)];
    [bezierPath addCurveToPoint: CGPointMake(15.62, 17.51) controlPoint1: CGPointMake(12.78, 19.61) controlPoint2: CGPointMake(13.95, 18.4)];
    [bezierPath addCurveToPoint: CGPointMake(20.92, 15.81) controlPoint1: CGPointMake(17.28, 16.61) controlPoint2: CGPointMake(19.05, 16.05)];
    [bezierPath addCurveToPoint: CGPointMake(21.81, 15.74) controlPoint1: CGPointMake(21.22, 15.79) controlPoint2: CGPointMake(21.52, 15.77)];
    [bezierPath addCurveToPoint: CGPointMake(22.69, 15.71) controlPoint1: CGPointMake(22.1, 15.72) controlPoint2: CGPointMake(22.39, 15.71)];
    [bezierPath addCurveToPoint: CGPointMake(24.71, 15.86) controlPoint1: CGPointMake(23.38, 15.71) controlPoint2: CGPointMake(24.05, 15.76)];
    [bezierPath addCurveToPoint: CGPointMake(26.53, 16.33) controlPoint1: CGPointMake(25.37, 15.95) controlPoint2: CGPointMake(25.97, 16.11)];
    [bezierPath addCurveToPoint: CGPointMake(29.22, 18.08) controlPoint1: CGPointMake(27.65, 16.71) controlPoint2: CGPointMake(28.55, 17.3)];
    [bezierPath addCurveToPoint: CGPointMake(30.21, 20.84) controlPoint1: CGPointMake(29.9, 18.87) controlPoint2: CGPointMake(30.23, 19.79)];
    [bezierPath addCurveToPoint: CGPointMake(30.13, 21.7) controlPoint1: CGPointMake(30.21, 21.12) controlPoint2: CGPointMake(30.18, 21.4)];
    [bezierPath addCurveToPoint: CGPointMake(29.89, 22.58) controlPoint1: CGPointMake(30.07, 21.98) controlPoint2: CGPointMake(29.99, 22.28)];
    [bezierPath addCurveToPoint: CGPointMake(29.08, 24.52) controlPoint1: CGPointMake(29.67, 23.25) controlPoint2: CGPointMake(29.4, 23.89)];
    [bezierPath addCurveToPoint: CGPointMake(28.08, 26.39) controlPoint1: CGPointMake(28.76, 25.14) controlPoint2: CGPointMake(28.42, 25.77)];
    [bezierPath addCurveToPoint: CGPointMake(26.81, 28.97) controlPoint1: CGPointMake(27.59, 27.36) controlPoint2: CGPointMake(27.16, 28.22)];
    [bezierPath addCurveToPoint: CGPointMake(26.15, 30.84) controlPoint1: CGPointMake(26.45, 29.72) controlPoint2: CGPointMake(26.23, 30.35)];
    [bezierPath addCurveToPoint: CGPointMake(26.15, 30.9) controlPoint1: CGPointMake(26.15, 30.86) controlPoint2: CGPointMake(26.15, 30.88)];
    [bezierPath addCurveToPoint: CGPointMake(26.15, 30.97) controlPoint1: CGPointMake(26.15, 30.93) controlPoint2: CGPointMake(26.15, 30.95)];
    [bezierPath addCurveToPoint: CGPointMake(26.11, 31.02) controlPoint1: CGPointMake(26.12, 30.99) controlPoint2: CGPointMake(26.11, 31.01)];
    [bezierPath addCurveToPoint: CGPointMake(26.11, 31.06) controlPoint1: CGPointMake(26.11, 31.03) controlPoint2: CGPointMake(26.11, 31.04)];
    [bezierPath addCurveToPoint: CGPointMake(26.39, 31.66) controlPoint1: CGPointMake(26.13, 31.32) controlPoint2: CGPointMake(26.23, 31.52)];
    [bezierPath addCurveToPoint: CGPointMake(27.21, 31.87) controlPoint1: CGPointMake(26.55, 31.8) controlPoint2: CGPointMake(26.82, 31.87)];
    [bezierPath addCurveToPoint: CGPointMake(31.08, 29.7) controlPoint1: CGPointMake(28.65, 31.87) controlPoint2: CGPointMake(29.94, 31.15)];
    [bezierPath addCurveToPoint: CGPointMake(33.72, 24.9) controlPoint1: CGPointMake(32.22, 28.24) controlPoint2: CGPointMake(33.1, 26.65)];
    [bezierPath addCurveToPoint: CGPointMake(34.45, 22.4) controlPoint1: CGPointMake(34.05, 24.07) controlPoint2: CGPointMake(34.29, 23.23)];
    [bezierPath addCurveToPoint: CGPointMake(34.69, 20.2) controlPoint1: CGPointMake(34.61, 21.58) controlPoint2: CGPointMake(34.69, 20.84)];
    [bezierPath addCurveToPoint: CGPointMake(34.31, 18.02) controlPoint1: CGPointMake(34.69, 19.29) controlPoint2: CGPointMake(34.56, 18.57)];
    [bezierPath addCurveToPoint: CGPointMake(32.72, 16.62) controlPoint1: CGPointMake(34.05, 17.47) controlPoint2: CGPointMake(33.52, 17)];
    [bezierPath addCurveToPoint: CGPointMake(32.88, 16.37) controlPoint1: CGPointMake(32.79, 16.53) controlPoint2: CGPointMake(32.84, 16.45)];
    [bezierPath addCurveToPoint: CGPointMake(33.05, 16.16) controlPoint1: CGPointMake(32.93, 16.3) controlPoint2: CGPointMake(32.98, 16.23)];
    [bezierPath addCurveToPoint: CGPointMake(33.89, 15.31) controlPoint1: CGPointMake(33.31, 15.82) controlPoint2: CGPointMake(33.58, 15.54)];
    [bezierPath addCurveToPoint: CGPointMake(35.05, 15) controlPoint1: CGPointMake(34.19, 15.08) controlPoint2: CGPointMake(34.57, 14.98)];
    [bezierPath addCurveToPoint: CGPointMake(35.19, 15) controlPoint1: CGPointMake(35.09, 15) controlPoint2: CGPointMake(35.14, 15)];
    [bezierPath addCurveToPoint: CGPointMake(35.34, 15) controlPoint1: CGPointMake(35.25, 15) controlPoint2: CGPointMake(35.29, 15)];
    [bezierPath addCurveToPoint: CGPointMake(35.58, 15.04) controlPoint1: CGPointMake(35.42, 15) controlPoint2: CGPointMake(35.5, 15.01)];
    [bezierPath addCurveToPoint: CGPointMake(35.82, 15.1) controlPoint1: CGPointMake(35.65, 15.06) controlPoint2: CGPointMake(35.73, 15.08)];
    [bezierPath addCurveToPoint: CGPointMake(36.69, 15.44) controlPoint1: CGPointMake(36.12, 15.16) controlPoint2: CGPointMake(36.41, 15.28)];
    [bezierPath addCurveToPoint: CGPointMake(37.4, 16.07) controlPoint1: CGPointMake(36.97, 15.6) controlPoint2: CGPointMake(37.21, 15.81)];
    [bezierPath addCurveToPoint: CGPointMake(38.06, 17.53) controlPoint1: CGPointMake(37.7, 16.54) controlPoint2: CGPointMake(37.92, 17.03)];
    [bezierPath addCurveToPoint: CGPointMake(38.27, 19.13) controlPoint1: CGPointMake(38.2, 18.04) controlPoint2: CGPointMake(38.27, 18.57)];
    [bezierPath addCurveToPoint: CGPointMake(38.24, 19.74) controlPoint1: CGPointMake(38.27, 19.32) controlPoint2: CGPointMake(38.26, 19.53)];
    [bezierPath addCurveToPoint: CGPointMake(38.14, 20.36) controlPoint1: CGPointMake(38.22, 19.96) controlPoint2: CGPointMake(38.19, 20.16)];
    [bezierPath addCurveToPoint: CGPointMake(37.88, 21.61) controlPoint1: CGPointMake(38.08, 20.79) controlPoint2: CGPointMake(37.99, 21.21)];
    [bezierPath addCurveToPoint: CGPointMake(37.53, 22.81) controlPoint1: CGPointMake(37.78, 22.02) controlPoint2: CGPointMake(37.66, 22.42)];
    [bezierPath addCurveToPoint: CGPointMake(35.24, 27.61) controlPoint1: CGPointMake(36.97, 24.44) controlPoint2: CGPointMake(36.21, 26.04)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezierPath fill];

}

@end
