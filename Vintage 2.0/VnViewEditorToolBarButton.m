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

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [VnCurrentSettings buttonHighlightedBgColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    [self setNeedsDisplay];
}

- (void)setColored:(BOOL)colored
{
    _colored = colored;
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
    if(self.selected){
        return [VnCurrentSettings buttonIconHighlightedColor];
    }
    if(self.colored){
        return [VnCurrentSettings buttonIconColoredColor];
    }
    return [VnCurrentSettings buttonIconNormalColor];
}

- (void)drawRect:(CGRect)rect
{
    switch (_toolId) {
        case VnAdjustmentToolIdEffects:
            [self drawRectEffects:rect];
            break;
        case VnAdjustmentToolIdEffectOpacity:
            [self drawRectEffectOpacity:rect];
            break;
        case VnAdjustmentToolIdEffectHistory:
            [self drawRectEffectHistroy:rect];
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

- (void)drawRectEffectOpacity:(CGRect)rect
{
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(23.72, 30.36)];
    [bezier2Path addCurveToPoint: CGPointMake(26.42, 24.51) controlPoint1: CGPointMake(23.72, 28.82) controlPoint2: CGPointMake(24.6, 26.91)];
    [bezier2Path addCurveToPoint: CGPointMake(30.2, 21) controlPoint1: CGPointMake(28.87, 21.27) controlPoint2: CGPointMake(29.54, 21.02)];
    [bezier2Path addCurveToPoint: CGPointMake(30.21, 20.84) controlPoint1: CGPointMake(30.2, 20.95) controlPoint2: CGPointMake(30.21, 20.89)];
    [bezier2Path addCurveToPoint: CGPointMake(29.23, 18.08) controlPoint1: CGPointMake(30.23, 19.79) controlPoint2: CGPointMake(29.9, 18.87)];
    [bezier2Path addCurveToPoint: CGPointMake(26.53, 16.33) controlPoint1: CGPointMake(28.55, 17.3) controlPoint2: CGPointMake(27.65, 16.71)];
    [bezier2Path addCurveToPoint: CGPointMake(24.71, 15.86) controlPoint1: CGPointMake(25.97, 16.11) controlPoint2: CGPointMake(25.37, 15.95)];
    [bezier2Path addCurveToPoint: CGPointMake(22.7, 15.71) controlPoint1: CGPointMake(24.05, 15.76) controlPoint2: CGPointMake(23.38, 15.71)];
    [bezier2Path addCurveToPoint: CGPointMake(21.81, 15.74) controlPoint1: CGPointMake(22.39, 15.71) controlPoint2: CGPointMake(22.1, 15.72)];
    [bezier2Path addCurveToPoint: CGPointMake(20.92, 15.81) controlPoint1: CGPointMake(21.52, 15.77) controlPoint2: CGPointMake(21.22, 15.79)];
    [bezier2Path addCurveToPoint: CGPointMake(15.62, 17.5) controlPoint1: CGPointMake(19.05, 16.05) controlPoint2: CGPointMake(17.28, 16.61)];
    [bezier2Path addCurveToPoint: CGPointMake(12.12, 21.13) controlPoint1: CGPointMake(13.95, 18.4) controlPoint2: CGPointMake(12.78, 19.6)];
    [bezier2Path addCurveToPoint: CGPointMake(11.82, 22.07) controlPoint1: CGPointMake(11.99, 21.45) controlPoint2: CGPointMake(11.89, 21.77)];
    [bezier2Path addCurveToPoint: CGPointMake(11.73, 22.94) controlPoint1: CGPointMake(11.76, 22.37) controlPoint2: CGPointMake(11.73, 22.66)];
    [bezier2Path addCurveToPoint: CGPointMake(12.7, 25.41) controlPoint1: CGPointMake(11.73, 23.93) controlPoint2: CGPointMake(12.05, 24.75)];
    [bezier2Path addCurveToPoint: CGPointMake(14.95, 26.39) controlPoint1: CGPointMake(13.34, 26.06) controlPoint2: CGPointMake(14.09, 26.39)];
    [bezier2Path addCurveToPoint: CGPointMake(15.5, 26.34) controlPoint1: CGPointMake(15.13, 26.39) controlPoint2: CGPointMake(15.31, 26.37)];
    [bezier2Path addCurveToPoint: CGPointMake(16.08, 26.19) controlPoint1: CGPointMake(15.7, 26.31) controlPoint2: CGPointMake(15.89, 26.26)];
    [bezier2Path addCurveToPoint: CGPointMake(17, 25.71) controlPoint1: CGPointMake(16.38, 26.09) controlPoint2: CGPointMake(16.69, 25.93)];
    [bezier2Path addCurveToPoint: CGPointMake(17.89, 24.9) controlPoint1: CGPointMake(17.31, 25.5) controlPoint2: CGPointMake(17.61, 25.23)];
    [bezier2Path addCurveToPoint: CGPointMake(18, 24.76) controlPoint1: CGPointMake(17.93, 24.86) controlPoint2: CGPointMake(17.97, 24.81)];
    [bezier2Path addCurveToPoint: CGPointMake(18.11, 24.61) controlPoint1: CGPointMake(18.03, 24.71) controlPoint2: CGPointMake(18.07, 24.66)];
    [bezier2Path addCurveToPoint: CGPointMake(18.34, 24.31) controlPoint1: CGPointMake(18.18, 24.51) controlPoint2: CGPointMake(18.25, 24.4)];
    [bezier2Path addCurveToPoint: CGPointMake(18.6, 24.03) controlPoint1: CGPointMake(18.43, 24.21) controlPoint2: CGPointMake(18.51, 24.12)];
    [bezier2Path addCurveToPoint: CGPointMake(18.42, 24.02) controlPoint1: CGPointMake(18.53, 24.03) controlPoint2: CGPointMake(18.47, 24.03)];
    [bezier2Path addCurveToPoint: CGPointMake(18.28, 24) controlPoint1: CGPointMake(18.37, 24.01) controlPoint2: CGPointMake(18.32, 24)];
    [bezier2Path addCurveToPoint: CGPointMake(16.63, 23.63) controlPoint1: CGPointMake(17.63, 23.94) controlPoint2: CGPointMake(17.08, 23.81)];
    [bezier2Path addCurveToPoint: CGPointMake(15.95, 22.23) controlPoint1: CGPointMake(16.18, 23.45) controlPoint2: CGPointMake(15.95, 22.98)];
    [bezier2Path addCurveToPoint: CGPointMake(15.95, 21.98) controlPoint1: CGPointMake(15.95, 22.14) controlPoint2: CGPointMake(15.95, 22.06)];
    [bezier2Path addCurveToPoint: CGPointMake(15.98, 21.74) controlPoint1: CGPointMake(15.95, 21.91) controlPoint2: CGPointMake(15.96, 21.83)];
    [bezier2Path addCurveToPoint: CGPointMake(17.39, 18.94) controlPoint1: CGPointMake(16.07, 20.62) controlPoint2: CGPointMake(16.54, 19.69)];
    [bezier2Path addCurveToPoint: CGPointMake(20.34, 17.81) controlPoint1: CGPointMake(18.24, 18.18) controlPoint2: CGPointMake(19.22, 17.81)];
    [bezier2Path addCurveToPoint: CGPointMake(21.82, 18.19) controlPoint1: CGPointMake(21.01, 17.81) controlPoint2: CGPointMake(21.5, 17.94)];
    [bezier2Path addCurveToPoint: CGPointMake(22.31, 19.29) controlPoint1: CGPointMake(22.15, 18.45) controlPoint2: CGPointMake(22.31, 18.82)];
    [bezier2Path addCurveToPoint: CGPointMake(22.26, 19.81) controlPoint1: CGPointMake(22.31, 19.44) controlPoint2: CGPointMake(22.29, 19.61)];
    [bezier2Path addCurveToPoint: CGPointMake(22.08, 20.42) controlPoint1: CGPointMake(22.23, 20) controlPoint2: CGPointMake(22.17, 20.21)];
    [bezier2Path addCurveToPoint: CGPointMake(21.32, 22.15) controlPoint1: CGPointMake(21.89, 20.98) controlPoint2: CGPointMake(21.63, 21.55)];
    [bezier2Path addCurveToPoint: CGPointMake(20.37, 23.97) controlPoint1: CGPointMake(21.01, 22.74) controlPoint2: CGPointMake(20.69, 23.34)];
    [bezier2Path addCurveToPoint: CGPointMake(19.44, 25.82) controlPoint1: CGPointMake(20.05, 24.57) controlPoint2: CGPointMake(19.74, 25.19)];
    [bezier2Path addCurveToPoint: CGPointMake(18.69, 27.71) controlPoint1: CGPointMake(19.13, 26.45) controlPoint2: CGPointMake(18.89, 27.09)];
    [bezier2Path addCurveToPoint: CGPointMake(18.44, 28.79) controlPoint1: CGPointMake(18.59, 28.08) controlPoint2: CGPointMake(18.5, 28.43)];
    [bezier2Path addCurveToPoint: CGPointMake(18.34, 29.84) controlPoint1: CGPointMake(18.37, 29.14) controlPoint2: CGPointMake(18.34, 29.49)];
    [bezier2Path addCurveToPoint: CGPointMake(18.55, 31.32) controlPoint1: CGPointMake(18.34, 30.33) controlPoint2: CGPointMake(18.41, 30.83)];
    [bezier2Path addCurveToPoint: CGPointMake(19.27, 32.77) controlPoint1: CGPointMake(18.69, 31.81) controlPoint2: CGPointMake(18.93, 32.3)];
    [bezier2Path addCurveToPoint: CGPointMake(21.31, 34.5) controlPoint1: CGPointMake(19.83, 33.59) controlPoint2: CGPointMake(20.51, 34.17)];
    [bezier2Path addCurveToPoint: CGPointMake(23.82, 35) controlPoint1: CGPointMake(22.1, 34.83) controlPoint2: CGPointMake(22.94, 35)];
    [bezier2Path addCurveToPoint: CGPointMake(24.72, 34.95) controlPoint1: CGPointMake(24.12, 35) controlPoint2: CGPointMake(24.42, 34.98)];
    [bezier2Path addCurveToPoint: CGPointMake(25.49, 34.85) controlPoint1: CGPointMake(24.98, 34.92) controlPoint2: CGPointMake(25.23, 34.89)];
    [bezier2Path addCurveToPoint: CGPointMake(23.72, 30.36) controlPoint1: CGPointMake(24.4, 33.67) controlPoint2: CGPointMake(23.72, 32.1)];
    [bezier2Path closePath];
    bezier2Path.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezier2Path fill];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(38.06, 17.53)];
    [bezier3Path addCurveToPoint: CGPointMake(37.4, 16.07) controlPoint1: CGPointMake(37.92, 17.03) controlPoint2: CGPointMake(37.7, 16.54)];
    [bezier3Path addCurveToPoint: CGPointMake(36.69, 15.44) controlPoint1: CGPointMake(37.21, 15.81) controlPoint2: CGPointMake(36.97, 15.6)];
    [bezier3Path addCurveToPoint: CGPointMake(35.82, 15.1) controlPoint1: CGPointMake(36.41, 15.28) controlPoint2: CGPointMake(36.12, 15.17)];
    [bezier3Path addCurveToPoint: CGPointMake(35.58, 15.04) controlPoint1: CGPointMake(35.74, 15.08) controlPoint2: CGPointMake(35.66, 15.06)];
    [bezier3Path addCurveToPoint: CGPointMake(35.34, 15) controlPoint1: CGPointMake(35.51, 15.02) controlPoint2: CGPointMake(35.43, 15)];
    [bezier3Path addCurveToPoint: CGPointMake(35.19, 15) controlPoint1: CGPointMake(35.3, 15) controlPoint2: CGPointMake(35.25, 15)];
    [bezier3Path addCurveToPoint: CGPointMake(35.05, 15) controlPoint1: CGPointMake(35.14, 15) controlPoint2: CGPointMake(35.09, 15)];
    [bezier3Path addCurveToPoint: CGPointMake(33.89, 15.31) controlPoint1: CGPointMake(34.58, 14.98) controlPoint2: CGPointMake(34.19, 15.08)];
    [bezier3Path addCurveToPoint: CGPointMake(33.05, 16.16) controlPoint1: CGPointMake(33.59, 15.54) controlPoint2: CGPointMake(33.31, 15.82)];
    [bezier3Path addCurveToPoint: CGPointMake(32.89, 16.37) controlPoint1: CGPointMake(32.98, 16.23) controlPoint2: CGPointMake(32.93, 16.3)];
    [bezier3Path addCurveToPoint: CGPointMake(32.73, 16.62) controlPoint1: CGPointMake(32.84, 16.45) controlPoint2: CGPointMake(32.79, 16.53)];
    [bezier3Path addCurveToPoint: CGPointMake(34.31, 18.02) controlPoint1: CGPointMake(33.52, 17) controlPoint2: CGPointMake(34.05, 17.47)];
    [bezier3Path addCurveToPoint: CGPointMake(34.69, 20.2) controlPoint1: CGPointMake(34.56, 18.57) controlPoint2: CGPointMake(34.69, 19.29)];
    [bezier3Path addCurveToPoint: CGPointMake(34.45, 22.41) controlPoint1: CGPointMake(34.69, 20.84) controlPoint2: CGPointMake(34.61, 21.58)];
    [bezier3Path addCurveToPoint: CGPointMake(33.99, 24.11) controlPoint1: CGPointMake(34.34, 22.97) controlPoint2: CGPointMake(34.18, 23.54)];
    [bezier3Path addCurveToPoint: CGPointMake(34.3, 24.51) controlPoint1: CGPointMake(34.1, 24.24) controlPoint2: CGPointMake(34.2, 24.37)];
    [bezier3Path addCurveToPoint: CGPointMake(35.77, 26.7) controlPoint1: CGPointMake(34.9, 25.3) controlPoint2: CGPointMake(35.38, 26.02)];
    [bezier3Path addCurveToPoint: CGPointMake(37.53, 22.81) controlPoint1: CGPointMake(36.49, 25.42) controlPoint2: CGPointMake(37.08, 24.13)];
    [bezier3Path addCurveToPoint: CGPointMake(37.89, 21.61) controlPoint1: CGPointMake(37.66, 22.42) controlPoint2: CGPointMake(37.78, 22.02)];
    [bezier3Path addCurveToPoint: CGPointMake(38.15, 20.36) controlPoint1: CGPointMake(38, 21.21) controlPoint2: CGPointMake(38.08, 20.79)];
    [bezier3Path addCurveToPoint: CGPointMake(38.24, 19.74) controlPoint1: CGPointMake(38.19, 20.16) controlPoint2: CGPointMake(38.22, 19.96)];
    [bezier3Path addCurveToPoint: CGPointMake(38.28, 19.13) controlPoint1: CGPointMake(38.26, 19.53) controlPoint2: CGPointMake(38.28, 19.33)];
    [bezier3Path addCurveToPoint: CGPointMake(38.06, 17.53) controlPoint1: CGPointMake(38.27, 18.57) controlPoint2: CGPointMake(38.2, 18.04)];
    [bezier3Path closePath];
    bezier3Path.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezier3Path fill];
    
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(30.36, 23)];
    [bezier4Path addCurveToPoint: CGPointMake(25.72, 30.36) controlPoint1: CGPointMake(30.29, 23) controlPoint2: CGPointMake(25.72, 27.8)];
    [bezier4Path addCurveToPoint: CGPointMake(30.36, 35) controlPoint1: CGPointMake(25.72, 32.93) controlPoint2: CGPointMake(27.8, 35)];
    [bezier4Path addCurveToPoint: CGPointMake(35, 30.36) controlPoint1: CGPointMake(32.92, 35) controlPoint2: CGPointMake(35, 32.92)];
    [bezier4Path addCurveToPoint: CGPointMake(30.36, 23) controlPoint1: CGPointMake(35, 27.8) controlPoint2: CGPointMake(30.43, 23)];
    [bezier4Path addLineToPoint: CGPointMake(30.36, 23)];
    [bezier4Path closePath];
    bezier4Path.miterLimit = 4;
    
    bezier4Path.usesEvenOddFillRule = YES;
    
    [[self fillColor] setFill];
    [bezier4Path fill];
    
    
}

- (void)drawRectEffectHistroy:(CGRect)rect
{
    
    
    //// Bezier 5 Drawing
    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint: CGPointMake(26.17, 32.87)];
    [bezier5Path addCurveToPoint: CGPointMake(26.19, 32.61) controlPoint1: CGPointMake(26.17, 32.78) controlPoint2: CGPointMake(26.18, 32.7)];
    [bezier5Path addCurveToPoint: CGPointMake(26.17, 32.87) controlPoint1: CGPointMake(26.18, 32.7) controlPoint2: CGPointMake(26.17, 32.78)];
    [bezier5Path closePath];
    bezier5Path.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezier5Path fill];
    
    
    //// Bezier 6 Drawing
    UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path moveToPoint: CGPointMake(26.14, 33.53)];
    [bezier6Path addCurveToPoint: CGPointMake(26.15, 33.32) controlPoint1: CGPointMake(26.14, 33.46) controlPoint2: CGPointMake(26.15, 33.39)];
    [bezier6Path addCurveToPoint: CGPointMake(26.14, 33.53) controlPoint1: CGPointMake(26.15, 33.39) controlPoint2: CGPointMake(26.14, 33.46)];
    [bezier6Path closePath];
    bezier6Path.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezier6Path fill];
    
    
    //// Bezier 7 Drawing
    UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
    [bezier7Path moveToPoint: CGPointMake(26.17, 34.05)];
    [bezier7Path addCurveToPoint: CGPointMake(26.16, 33.94) controlPoint1: CGPointMake(26.16, 34.02) controlPoint2: CGPointMake(26.16, 33.98)];
    [bezier7Path addCurveToPoint: CGPointMake(26.17, 34.05) controlPoint1: CGPointMake(26.16, 33.98) controlPoint2: CGPointMake(26.16, 34.02)];
    [bezier7Path closePath];
    bezier7Path.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezier7Path fill];
    
    
    //// Bezier 8 Drawing
    UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
    [bezier8Path moveToPoint: CGPointMake(26.23, 32.04)];
    [bezier8Path addCurveToPoint: CGPointMake(26.26, 31.79) controlPoint1: CGPointMake(26.24, 31.96) controlPoint2: CGPointMake(26.25, 31.88)];
    [bezier8Path addCurveToPoint: CGPointMake(26.23, 32.04) controlPoint1: CGPointMake(26.25, 31.88) controlPoint2: CGPointMake(26.24, 31.96)];
    [bezier8Path closePath];
    bezier8Path.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezier8Path fill];
    
    
    //// Bezier 9 Drawing
    UIBezierPath* bezier9Path = [UIBezierPath bezierPath];
    [bezier9Path moveToPoint: CGPointMake(24.27, 31.55)];
    [bezier9Path addCurveToPoint: CGPointMake(22.21, 26.91) controlPoint1: CGPointMake(22.75, 29.91) controlPoint2: CGPointMake(21.69, 28.52)];
    [bezier9Path addCurveToPoint: CGPointMake(26.6, 24.38) controlPoint1: CGPointMake(22.73, 25.31) controlPoint2: CGPointMake(24.41, 24.81)];
    [bezier9Path addCurveToPoint: CGPointMake(30.19, 21.02) controlPoint1: CGPointMake(27.65, 22.5) controlPoint2: CGPointMake(28.62, 21.11)];
    [bezier9Path addCurveToPoint: CGPointMake(30.21, 20.84) controlPoint1: CGPointMake(30.2, 20.96) controlPoint2: CGPointMake(30.21, 20.9)];
    [bezier9Path addCurveToPoint: CGPointMake(29.23, 18.08) controlPoint1: CGPointMake(30.23, 19.79) controlPoint2: CGPointMake(29.9, 18.87)];
    [bezier9Path addCurveToPoint: CGPointMake(26.53, 16.33) controlPoint1: CGPointMake(28.55, 17.3) controlPoint2: CGPointMake(27.65, 16.71)];
    [bezier9Path addCurveToPoint: CGPointMake(24.71, 15.86) controlPoint1: CGPointMake(25.97, 16.11) controlPoint2: CGPointMake(25.37, 15.95)];
    [bezier9Path addCurveToPoint: CGPointMake(22.7, 15.71) controlPoint1: CGPointMake(24.05, 15.76) controlPoint2: CGPointMake(23.38, 15.71)];
    [bezier9Path addCurveToPoint: CGPointMake(21.81, 15.75) controlPoint1: CGPointMake(22.39, 15.71) controlPoint2: CGPointMake(22.1, 15.72)];
    [bezier9Path addCurveToPoint: CGPointMake(20.92, 15.81) controlPoint1: CGPointMake(21.52, 15.77) controlPoint2: CGPointMake(21.22, 15.79)];
    [bezier9Path addCurveToPoint: CGPointMake(15.62, 17.5) controlPoint1: CGPointMake(19.05, 16.05) controlPoint2: CGPointMake(17.28, 16.61)];
    [bezier9Path addCurveToPoint: CGPointMake(12.12, 21.13) controlPoint1: CGPointMake(13.95, 18.4) controlPoint2: CGPointMake(12.78, 19.61)];
    [bezier9Path addCurveToPoint: CGPointMake(11.82, 22.07) controlPoint1: CGPointMake(11.99, 21.45) controlPoint2: CGPointMake(11.89, 21.77)];
    [bezier9Path addCurveToPoint: CGPointMake(11.73, 22.94) controlPoint1: CGPointMake(11.76, 22.37) controlPoint2: CGPointMake(11.73, 22.66)];
    [bezier9Path addCurveToPoint: CGPointMake(12.7, 25.41) controlPoint1: CGPointMake(11.73, 23.93) controlPoint2: CGPointMake(12.05, 24.75)];
    [bezier9Path addCurveToPoint: CGPointMake(14.95, 26.39) controlPoint1: CGPointMake(13.34, 26.06) controlPoint2: CGPointMake(14.09, 26.39)];
    [bezier9Path addCurveToPoint: CGPointMake(15.5, 26.34) controlPoint1: CGPointMake(15.13, 26.39) controlPoint2: CGPointMake(15.31, 26.37)];
    [bezier9Path addCurveToPoint: CGPointMake(16.08, 26.19) controlPoint1: CGPointMake(15.7, 26.31) controlPoint2: CGPointMake(15.89, 26.26)];
    [bezier9Path addCurveToPoint: CGPointMake(17, 25.71) controlPoint1: CGPointMake(16.38, 26.09) controlPoint2: CGPointMake(16.69, 25.93)];
    [bezier9Path addCurveToPoint: CGPointMake(17.89, 24.91) controlPoint1: CGPointMake(17.31, 25.5) controlPoint2: CGPointMake(17.61, 25.23)];
    [bezier9Path addCurveToPoint: CGPointMake(18, 24.76) controlPoint1: CGPointMake(17.93, 24.86) controlPoint2: CGPointMake(17.97, 24.81)];
    [bezier9Path addCurveToPoint: CGPointMake(18.11, 24.61) controlPoint1: CGPointMake(18.03, 24.71) controlPoint2: CGPointMake(18.07, 24.66)];
    [bezier9Path addCurveToPoint: CGPointMake(18.34, 24.31) controlPoint1: CGPointMake(18.18, 24.51) controlPoint2: CGPointMake(18.25, 24.41)];
    [bezier9Path addCurveToPoint: CGPointMake(18.6, 24.03) controlPoint1: CGPointMake(18.43, 24.21) controlPoint2: CGPointMake(18.51, 24.12)];
    [bezier9Path addCurveToPoint: CGPointMake(18.42, 24.02) controlPoint1: CGPointMake(18.53, 24.03) controlPoint2: CGPointMake(18.47, 24.03)];
    [bezier9Path addCurveToPoint: CGPointMake(18.28, 24) controlPoint1: CGPointMake(18.37, 24.01) controlPoint2: CGPointMake(18.32, 24)];
    [bezier9Path addCurveToPoint: CGPointMake(16.63, 23.63) controlPoint1: CGPointMake(17.63, 23.94) controlPoint2: CGPointMake(17.08, 23.81)];
    [bezier9Path addCurveToPoint: CGPointMake(15.95, 22.23) controlPoint1: CGPointMake(16.18, 23.45) controlPoint2: CGPointMake(15.95, 22.98)];
    [bezier9Path addCurveToPoint: CGPointMake(15.95, 21.99) controlPoint1: CGPointMake(15.95, 22.14) controlPoint2: CGPointMake(15.95, 22.06)];
    [bezier9Path addCurveToPoint: CGPointMake(15.98, 21.74) controlPoint1: CGPointMake(15.95, 21.91) controlPoint2: CGPointMake(15.96, 21.83)];
    [bezier9Path addCurveToPoint: CGPointMake(17.39, 18.94) controlPoint1: CGPointMake(16.07, 20.63) controlPoint2: CGPointMake(16.54, 19.69)];
    [bezier9Path addCurveToPoint: CGPointMake(20.34, 17.81) controlPoint1: CGPointMake(18.24, 18.18) controlPoint2: CGPointMake(19.22, 17.81)];
    [bezier9Path addCurveToPoint: CGPointMake(21.82, 18.19) controlPoint1: CGPointMake(21.01, 17.81) controlPoint2: CGPointMake(21.5, 17.94)];
    [bezier9Path addCurveToPoint: CGPointMake(22.31, 19.29) controlPoint1: CGPointMake(22.15, 18.45) controlPoint2: CGPointMake(22.31, 18.82)];
    [bezier9Path addCurveToPoint: CGPointMake(22.26, 19.81) controlPoint1: CGPointMake(22.31, 19.44) controlPoint2: CGPointMake(22.29, 19.61)];
    [bezier9Path addCurveToPoint: CGPointMake(22.08, 20.42) controlPoint1: CGPointMake(22.23, 20) controlPoint2: CGPointMake(22.17, 20.21)];
    [bezier9Path addCurveToPoint: CGPointMake(21.32, 22.15) controlPoint1: CGPointMake(21.89, 20.98) controlPoint2: CGPointMake(21.63, 21.56)];
    [bezier9Path addCurveToPoint: CGPointMake(20.37, 23.97) controlPoint1: CGPointMake(21.01, 22.74) controlPoint2: CGPointMake(20.69, 23.35)];
    [bezier9Path addCurveToPoint: CGPointMake(19.44, 25.82) controlPoint1: CGPointMake(20.05, 24.57) controlPoint2: CGPointMake(19.74, 25.19)];
    [bezier9Path addCurveToPoint: CGPointMake(18.69, 27.71) controlPoint1: CGPointMake(19.13, 26.46) controlPoint2: CGPointMake(18.89, 27.09)];
    [bezier9Path addCurveToPoint: CGPointMake(18.44, 28.79) controlPoint1: CGPointMake(18.59, 28.08) controlPoint2: CGPointMake(18.5, 28.43)];
    [bezier9Path addCurveToPoint: CGPointMake(18.34, 29.84) controlPoint1: CGPointMake(18.37, 29.14) controlPoint2: CGPointMake(18.34, 29.49)];
    [bezier9Path addCurveToPoint: CGPointMake(18.55, 31.32) controlPoint1: CGPointMake(18.34, 30.33) controlPoint2: CGPointMake(18.41, 30.83)];
    [bezier9Path addCurveToPoint: CGPointMake(19.27, 32.77) controlPoint1: CGPointMake(18.69, 31.81) controlPoint2: CGPointMake(18.93, 32.3)];
    [bezier9Path addCurveToPoint: CGPointMake(21.31, 34.5) controlPoint1: CGPointMake(19.83, 33.59) controlPoint2: CGPointMake(20.51, 34.17)];
    [bezier9Path addCurveToPoint: CGPointMake(23.82, 35) controlPoint1: CGPointMake(22.1, 34.83) controlPoint2: CGPointMake(22.94, 35)];
    [bezier9Path addCurveToPoint: CGPointMake(24.32, 34.97) controlPoint1: CGPointMake(23.99, 35) controlPoint2: CGPointMake(24.16, 34.98)];
    [bezier9Path addCurveToPoint: CGPointMake(24.27, 31.55) controlPoint1: CGPointMake(24.07, 34.11) controlPoint2: CGPointMake(24.12, 33.01)];
    [bezier9Path closePath];
    bezier9Path.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezier9Path fill];
    
    
    //// Bezier 10 Drawing
    UIBezierPath* bezier10Path = [UIBezierPath bezierPath];
    [bezier10Path moveToPoint: CGPointMake(34.31, 18.02)];
    [bezier10Path addCurveToPoint: CGPointMake(34.69, 20.2) controlPoint1: CGPointMake(34.56, 18.57) controlPoint2: CGPointMake(34.69, 19.29)];
    [bezier10Path addCurveToPoint: CGPointMake(34.45, 22.4) controlPoint1: CGPointMake(34.69, 20.84) controlPoint2: CGPointMake(34.61, 21.58)];
    [bezier10Path addCurveToPoint: CGPointMake(33.99, 24.13) controlPoint1: CGPointMake(34.34, 22.98) controlPoint2: CGPointMake(34.18, 23.55)];
    [bezier10Path addCurveToPoint: CGPointMake(34.13, 24.38) controlPoint1: CGPointMake(34.03, 24.22) controlPoint2: CGPointMake(34.08, 24.29)];
    [bezier10Path addCurveToPoint: CGPointMake(36.61, 25.07) controlPoint1: CGPointMake(35.07, 24.56) controlPoint2: CGPointMake(35.91, 24.77)];
    [bezier10Path addCurveToPoint: CGPointMake(37.53, 22.81) controlPoint1: CGPointMake(36.96, 24.32) controlPoint2: CGPointMake(37.27, 23.57)];
    [bezier10Path addCurveToPoint: CGPointMake(37.89, 21.61) controlPoint1: CGPointMake(37.66, 22.42) controlPoint2: CGPointMake(37.78, 22.02)];
    [bezier10Path addCurveToPoint: CGPointMake(38.14, 20.36) controlPoint1: CGPointMake(37.99, 21.21) controlPoint2: CGPointMake(38.08, 20.79)];
    [bezier10Path addCurveToPoint: CGPointMake(38.24, 19.74) controlPoint1: CGPointMake(38.19, 20.16) controlPoint2: CGPointMake(38.22, 19.96)];
    [bezier10Path addCurveToPoint: CGPointMake(38.27, 19.13) controlPoint1: CGPointMake(38.26, 19.53) controlPoint2: CGPointMake(38.27, 19.33)];
    [bezier10Path addCurveToPoint: CGPointMake(38.06, 17.53) controlPoint1: CGPointMake(38.27, 18.57) controlPoint2: CGPointMake(38.2, 18.04)];
    [bezier10Path addCurveToPoint: CGPointMake(37.4, 16.07) controlPoint1: CGPointMake(37.92, 17.03) controlPoint2: CGPointMake(37.7, 16.54)];
    [bezier10Path addCurveToPoint: CGPointMake(36.69, 15.44) controlPoint1: CGPointMake(37.21, 15.81) controlPoint2: CGPointMake(36.97, 15.6)];
    [bezier10Path addCurveToPoint: CGPointMake(35.82, 15.1) controlPoint1: CGPointMake(36.41, 15.28) controlPoint2: CGPointMake(36.12, 15.16)];
    [bezier10Path addCurveToPoint: CGPointMake(35.58, 15.04) controlPoint1: CGPointMake(35.74, 15.08) controlPoint2: CGPointMake(35.66, 15.06)];
    [bezier10Path addCurveToPoint: CGPointMake(35.34, 15) controlPoint1: CGPointMake(35.51, 15.01) controlPoint2: CGPointMake(35.43, 15)];
    [bezier10Path addCurveToPoint: CGPointMake(35.19, 15) controlPoint1: CGPointMake(35.3, 15) controlPoint2: CGPointMake(35.25, 15)];
    [bezier10Path addCurveToPoint: CGPointMake(35.05, 15) controlPoint1: CGPointMake(35.14, 15) controlPoint2: CGPointMake(35.09, 15)];
    [bezier10Path addCurveToPoint: CGPointMake(33.89, 15.31) controlPoint1: CGPointMake(34.58, 14.98) controlPoint2: CGPointMake(34.19, 15.08)];
    [bezier10Path addCurveToPoint: CGPointMake(33.05, 16.16) controlPoint1: CGPointMake(33.59, 15.54) controlPoint2: CGPointMake(33.31, 15.82)];
    [bezier10Path addCurveToPoint: CGPointMake(32.89, 16.37) controlPoint1: CGPointMake(32.98, 16.23) controlPoint2: CGPointMake(32.93, 16.3)];
    [bezier10Path addCurveToPoint: CGPointMake(32.73, 16.62) controlPoint1: CGPointMake(32.84, 16.45) controlPoint2: CGPointMake(32.79, 16.53)];
    [bezier10Path addCurveToPoint: CGPointMake(34.31, 18.02) controlPoint1: CGPointMake(33.52, 17) controlPoint2: CGPointMake(34.05, 17.47)];
    [bezier10Path closePath];
    bezier10Path.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezier10Path fill];
    
    
    //// Bezier 11 Drawing
    UIBezierPath* bezier11Path = [UIBezierPath bezierPath];
    [bezier11Path moveToPoint: CGPointMake(26.29, 34.53)];
    [bezier11Path addCurveToPoint: CGPointMake(26.25, 34.45) controlPoint1: CGPointMake(26.28, 34.5) controlPoint2: CGPointMake(26.26, 34.48)];
    [bezier11Path addCurveToPoint: CGPointMake(26.29, 34.53) controlPoint1: CGPointMake(26.26, 34.48) controlPoint2: CGPointMake(26.28, 34.5)];
    [bezier11Path closePath];
    bezier11Path.miterLimit = 4;
    
    [[self fillColor] setFill];
    [bezier11Path fill];
    
    
    
    //// Bezier 12 Drawing
    UIBezierPath* bezier12Path = [UIBezierPath bezierPath];
    [bezier12Path moveToPoint: CGPointMake(32.83, 26.16)];
    [bezier12Path addCurveToPoint: CGPointMake(34.36, 30.85) controlPoint1: CGPointMake(37.56, 27.06) controlPoint2: CGPointMake(37.67, 27.35)];
    [bezier12Path addCurveToPoint: CGPointMake(30.36, 33.75) controlPoint1: CGPointMake(34.92, 35.56) controlPoint2: CGPointMake(34.68, 35.79)];
    [bezier12Path addCurveToPoint: CGPointMake(26.36, 30.85) controlPoint1: CGPointMake(26.04, 35.78) controlPoint2: CGPointMake(25.8, 35.67)];
    [bezier12Path addCurveToPoint: CGPointMake(27.89, 26.16) controlPoint1: CGPointMake(23.05, 27.35) controlPoint2: CGPointMake(23.16, 27.06)];
    [bezier12Path addCurveToPoint: CGPointMake(32.83, 26.16) controlPoint1: CGPointMake(30.21, 21.95) controlPoint2: CGPointMake(30.51, 21.95)];
    [bezier12Path closePath];
    bezier12Path.miterLimit = 4;
    
    bezier12Path.usesEvenOddFillRule = YES;
    
    [[self fillColor] setFill];
    [bezier12Path fill];
}

@end
