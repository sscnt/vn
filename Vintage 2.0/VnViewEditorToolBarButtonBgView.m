//
//  VnViewEditorToolBarButtonBgView.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewEditorToolBarButtonBgView.h"

@implementation VnViewEditorToolBarButtonBgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _selected = NO;
        _colored = NO;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [VnCurrentSettings barBgColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        self.backgroundColor = [VnCurrentSettings buttonHighlightedBgColor];
    } else {
        self.backgroundColor = [VnCurrentSettings barBgColor];
    }
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
        case VnAdjustmentToolIdEffectHistory:
            [self drawRectEffectHistroy:rect];
            break;
        case VnAdjustmentToolIdEffectOpacity:
            [self drawRectEffectOpacity:rect];
            break;
        case VnAdjustmentToolIdTextures:
            [self drawRectEffectHistroy:rect];
            break;
        case VnAdjustmentToolIdTextureHistory:
            [self drawRectEffectHistroy:rect];
            break;
        case VnAdjustmentToolIdTextureOpacity:
            [self drawRectEffectHistroy:rect];
            break;
        case VnAdjustmentToolIdPhotoFilters:
            [self drawRectEffectHistroy:rect];
            break;
        case VnAdjustmentToolIdPhotoFilterHistory:
            [self drawRectEffectHistroy:rect];
            break;
        case VnAdjustmentToolIdPhotoFilterOpacity:
            [self drawRectEffectHistroy:rect];
            break;
        case VnAdjustmentToolIdBrightness:
            [self drawRectBrightness:rect];
            break;
        case VnAdjustmentToolIdLevels:
            [self drawRectLevels:rect];
            break;
        default:
            break;
    }
}

- (void)drawRectEffects:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [self fillColor];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(35.03, 27.56)];
    [bezierPath addCurveToPoint: CGPointMake(31.71, 31.58) controlPoint1: CGPointMake(34.08, 29.1) controlPoint2: CGPointMake(32.98, 30.44)];
    [bezierPath addCurveToPoint: CGPointMake(28.98, 33.42) controlPoint1: CGPointMake(30.98, 32.23) controlPoint2: CGPointMake(30.06, 32.84)];
    [bezierPath addCurveToPoint: CGPointMake(25.62, 34.64) controlPoint1: CGPointMake(27.9, 34) controlPoint2: CGPointMake(26.77, 34.41)];
    [bezierPath addCurveToPoint: CGPointMake(24.73, 34.75) controlPoint1: CGPointMake(25.32, 34.68) controlPoint2: CGPointMake(25.03, 34.72)];
    [bezierPath addCurveToPoint: CGPointMake(23.85, 34.8) controlPoint1: CGPointMake(24.44, 34.78) controlPoint2: CGPointMake(24.14, 34.8)];
    [bezierPath addCurveToPoint: CGPointMake(21.38, 34.31) controlPoint1: CGPointMake(22.98, 34.8) controlPoint2: CGPointMake(22.16, 34.63)];
    [bezierPath addCurveToPoint: CGPointMake(19.39, 32.62) controlPoint1: CGPointMake(20.61, 33.98) controlPoint2: CGPointMake(19.94, 33.42)];
    [bezierPath addCurveToPoint: CGPointMake(18.68, 31.2) controlPoint1: CGPointMake(19.06, 32.16) controlPoint2: CGPointMake(18.82, 31.68)];
    [bezierPath addCurveToPoint: CGPointMake(18.48, 29.74) controlPoint1: CGPointMake(18.54, 30.71) controlPoint2: CGPointMake(18.48, 30.23)];
    [bezierPath addCurveToPoint: CGPointMake(18.57, 28.72) controlPoint1: CGPointMake(18.48, 29.41) controlPoint2: CGPointMake(18.51, 29.06)];
    [bezierPath addCurveToPoint: CGPointMake(18.83, 27.66) controlPoint1: CGPointMake(18.64, 28.37) controlPoint2: CGPointMake(18.72, 28.02)];
    [bezierPath addCurveToPoint: CGPointMake(19.55, 25.81) controlPoint1: CGPointMake(19.01, 27.05) controlPoint2: CGPointMake(19.26, 26.43)];
    [bezierPath addCurveToPoint: CGPointMake(20.47, 23.99) controlPoint1: CGPointMake(19.85, 25.19) controlPoint2: CGPointMake(20.15, 24.58)];
    [bezierPath addCurveToPoint: CGPointMake(21.4, 22.21) controlPoint1: CGPointMake(20.79, 23.38) controlPoint2: CGPointMake(21.1, 22.79)];
    [bezierPath addCurveToPoint: CGPointMake(22.14, 20.52) controlPoint1: CGPointMake(21.71, 21.63) controlPoint2: CGPointMake(21.95, 21.07)];
    [bezierPath addCurveToPoint: CGPointMake(22.32, 19.92) controlPoint1: CGPointMake(22.23, 20.31) controlPoint2: CGPointMake(22.29, 20.11)];
    [bezierPath addCurveToPoint: CGPointMake(22.37, 19.41) controlPoint1: CGPointMake(22.35, 19.73) controlPoint2: CGPointMake(22.37, 19.56)];
    [bezierPath addCurveToPoint: CGPointMake(21.89, 18.34) controlPoint1: CGPointMake(22.37, 18.95) controlPoint2: CGPointMake(22.21, 18.59)];
    [bezierPath addCurveToPoint: CGPointMake(20.44, 17.96) controlPoint1: CGPointMake(21.58, 18.09) controlPoint2: CGPointMake(21.09, 17.96)];
    [bezierPath addCurveToPoint: CGPointMake(17.55, 19.06) controlPoint1: CGPointMake(19.34, 17.96) controlPoint2: CGPointMake(18.38, 18.33)];
    [bezierPath addCurveToPoint: CGPointMake(16.17, 21.81) controlPoint1: CGPointMake(16.72, 19.8) controlPoint2: CGPointMake(16.26, 20.72)];
    [bezierPath addCurveToPoint: CGPointMake(16.14, 22.05) controlPoint1: CGPointMake(16.15, 21.9) controlPoint2: CGPointMake(16.14, 21.98)];
    [bezierPath addCurveToPoint: CGPointMake(16.14, 22.29) controlPoint1: CGPointMake(16.14, 22.12) controlPoint2: CGPointMake(16.14, 22.2)];
    [bezierPath addCurveToPoint: CGPointMake(16.81, 23.66) controlPoint1: CGPointMake(16.14, 23.02) controlPoint2: CGPointMake(16.36, 23.48)];
    [bezierPath addCurveToPoint: CGPointMake(18.42, 24.02) controlPoint1: CGPointMake(17.25, 23.84) controlPoint2: CGPointMake(17.79, 23.96)];
    [bezierPath addCurveToPoint: CGPointMake(18.56, 24.04) controlPoint1: CGPointMake(18.46, 24.02) controlPoint2: CGPointMake(18.51, 24.03)];
    [bezierPath addCurveToPoint: CGPointMake(18.73, 24.06) controlPoint1: CGPointMake(18.61, 24.05) controlPoint2: CGPointMake(18.67, 24.06)];
    [bezierPath addCurveToPoint: CGPointMake(18.48, 24.33) controlPoint1: CGPointMake(18.65, 24.14) controlPoint2: CGPointMake(18.56, 24.23)];
    [bezierPath addCurveToPoint: CGPointMake(18.26, 24.63) controlPoint1: CGPointMake(18.4, 24.42) controlPoint2: CGPointMake(18.32, 24.52)];
    [bezierPath addCurveToPoint: CGPointMake(18.15, 24.77) controlPoint1: CGPointMake(18.21, 24.67) controlPoint2: CGPointMake(18.18, 24.72)];
    [bezierPath addCurveToPoint: CGPointMake(18.04, 24.91) controlPoint1: CGPointMake(18.12, 24.82) controlPoint2: CGPointMake(18.08, 24.87)];
    [bezierPath addCurveToPoint: CGPointMake(17.17, 25.7) controlPoint1: CGPointMake(17.76, 25.23) controlPoint2: CGPointMake(17.47, 25.49)];
    [bezierPath addCurveToPoint: CGPointMake(16.27, 26.17) controlPoint1: CGPointMake(16.86, 25.91) controlPoint2: CGPointMake(16.56, 26.07)];
    [bezierPath addCurveToPoint: CGPointMake(15.7, 26.32) controlPoint1: CGPointMake(16.08, 26.24) controlPoint2: CGPointMake(15.89, 26.28)];
    [bezierPath addCurveToPoint: CGPointMake(15.16, 26.37) controlPoint1: CGPointMake(15.51, 26.35) controlPoint2: CGPointMake(15.33, 26.37)];
    [bezierPath addCurveToPoint: CGPointMake(12.95, 25.4) controlPoint1: CGPointMake(14.32, 26.37) controlPoint2: CGPointMake(13.58, 26.05)];
    [bezierPath addCurveToPoint: CGPointMake(12, 22.99) controlPoint1: CGPointMake(12.32, 24.76) controlPoint2: CGPointMake(12, 23.96)];
    [bezierPath addCurveToPoint: CGPointMake(12.1, 22.13) controlPoint1: CGPointMake(12, 22.71) controlPoint2: CGPointMake(12.03, 22.43)];
    [bezierPath addCurveToPoint: CGPointMake(12.38, 21.22) controlPoint1: CGPointMake(12.16, 21.84) controlPoint2: CGPointMake(12.25, 21.53)];
    [bezierPath addCurveToPoint: CGPointMake(15.81, 17.66) controlPoint1: CGPointMake(13.04, 19.72) controlPoint2: CGPointMake(14.18, 18.54)];
    [bezierPath addCurveToPoint: CGPointMake(21.01, 16) controlPoint1: CGPointMake(17.44, 16.79) controlPoint2: CGPointMake(19.18, 16.23)];
    [bezierPath addCurveToPoint: CGPointMake(21.88, 15.94) controlPoint1: CGPointMake(21.3, 15.98) controlPoint2: CGPointMake(21.59, 15.96)];
    [bezierPath addCurveToPoint: CGPointMake(22.75, 15.91) controlPoint1: CGPointMake(22.16, 15.92) controlPoint2: CGPointMake(22.45, 15.91)];
    [bezierPath addCurveToPoint: CGPointMake(24.72, 16.05) controlPoint1: CGPointMake(23.42, 15.91) controlPoint2: CGPointMake(24.08, 15.96)];
    [bezierPath addCurveToPoint: CGPointMake(26.51, 16.51) controlPoint1: CGPointMake(25.36, 16.15) controlPoint2: CGPointMake(25.96, 16.3)];
    [bezierPath addCurveToPoint: CGPointMake(29.14, 18.23) controlPoint1: CGPointMake(27.6, 16.89) controlPoint2: CGPointMake(28.48, 17.46)];
    [bezierPath addCurveToPoint: CGPointMake(30.11, 20.93) controlPoint1: CGPointMake(29.81, 19) controlPoint2: CGPointMake(30.13, 19.9)];
    [bezierPath addCurveToPoint: CGPointMake(30.03, 21.77) controlPoint1: CGPointMake(30.11, 21.21) controlPoint2: CGPointMake(30.08, 21.48)];
    [bezierPath addCurveToPoint: CGPointMake(29.79, 22.64) controlPoint1: CGPointMake(29.97, 22.05) controlPoint2: CGPointMake(29.9, 22.34)];
    [bezierPath addCurveToPoint: CGPointMake(29, 24.53) controlPoint1: CGPointMake(29.58, 23.29) controlPoint2: CGPointMake(29.32, 23.92)];
    [bezierPath addCurveToPoint: CGPointMake(28.02, 26.37) controlPoint1: CGPointMake(28.69, 25.14) controlPoint2: CGPointMake(28.36, 25.76)];
    [bezierPath addCurveToPoint: CGPointMake(26.77, 28.89) controlPoint1: CGPointMake(27.54, 27.31) controlPoint2: CGPointMake(27.12, 28.16)];
    [bezierPath addCurveToPoint: CGPointMake(26.13, 30.73) controlPoint1: CGPointMake(26.43, 29.63) controlPoint2: CGPointMake(26.21, 30.24)];
    [bezierPath addCurveToPoint: CGPointMake(26.13, 30.79) controlPoint1: CGPointMake(26.13, 30.75) controlPoint2: CGPointMake(26.13, 30.77)];
    [bezierPath addCurveToPoint: CGPointMake(26.13, 30.85) controlPoint1: CGPointMake(26.13, 30.81) controlPoint2: CGPointMake(26.13, 30.83)];
    [bezierPath addCurveToPoint: CGPointMake(26.1, 30.9) controlPoint1: CGPointMake(26.11, 30.87) controlPoint2: CGPointMake(26.1, 30.89)];
    [bezierPath addCurveToPoint: CGPointMake(26.1, 30.95) controlPoint1: CGPointMake(26.1, 30.91) controlPoint2: CGPointMake(26.1, 30.92)];
    [bezierPath addCurveToPoint: CGPointMake(26.37, 31.53) controlPoint1: CGPointMake(26.12, 31.2) controlPoint2: CGPointMake(26.21, 31.39)];
    [bezierPath addCurveToPoint: CGPointMake(27.17, 31.74) controlPoint1: CGPointMake(26.52, 31.67) controlPoint2: CGPointMake(26.79, 31.74)];
    [bezierPath addCurveToPoint: CGPointMake(30.96, 29.6) controlPoint1: CGPointMake(28.58, 31.74) controlPoint2: CGPointMake(29.84, 31.02)];
    [bezierPath addCurveToPoint: CGPointMake(33.55, 24.91) controlPoint1: CGPointMake(32.08, 28.18) controlPoint2: CGPointMake(32.94, 26.62)];
    [bezierPath addCurveToPoint: CGPointMake(34.26, 22.46) controlPoint1: CGPointMake(33.87, 24.09) controlPoint2: CGPointMake(34.11, 23.27)];
    [bezierPath addCurveToPoint: CGPointMake(34.5, 20.3) controlPoint1: CGPointMake(34.42, 21.65) controlPoint2: CGPointMake(34.5, 20.93)];
    [bezierPath addCurveToPoint: CGPointMake(34.12, 18.17) controlPoint1: CGPointMake(34.5, 19.41) controlPoint2: CGPointMake(34.37, 18.7)];
    [bezierPath addCurveToPoint: CGPointMake(32.57, 16.79) controlPoint1: CGPointMake(33.87, 17.63) controlPoint2: CGPointMake(33.35, 17.17)];
    [bezierPath addCurveToPoint: CGPointMake(32.73, 16.55) controlPoint1: CGPointMake(32.64, 16.71) controlPoint2: CGPointMake(32.69, 16.63)];
    [bezierPath addCurveToPoint: CGPointMake(32.89, 16.35) controlPoint1: CGPointMake(32.77, 16.48) controlPoint2: CGPointMake(32.82, 16.41)];
    [bezierPath addCurveToPoint: CGPointMake(33.71, 15.51) controlPoint1: CGPointMake(33.14, 16.01) controlPoint2: CGPointMake(33.41, 15.73)];
    [bezierPath addCurveToPoint: CGPointMake(34.85, 15.21) controlPoint1: CGPointMake(34, 15.29) controlPoint2: CGPointMake(34.38, 15.19)];
    [bezierPath addCurveToPoint: CGPointMake(34.99, 15.21) controlPoint1: CGPointMake(34.89, 15.21) controlPoint2: CGPointMake(34.94, 15.21)];
    [bezierPath addCurveToPoint: CGPointMake(35.13, 15.21) controlPoint1: CGPointMake(35.04, 15.21) controlPoint2: CGPointMake(35.09, 15.21)];
    [bezierPath addCurveToPoint: CGPointMake(35.37, 15.24) controlPoint1: CGPointMake(35.22, 15.21) controlPoint2: CGPointMake(35.3, 15.22)];
    [bezierPath addCurveToPoint: CGPointMake(35.61, 15.31) controlPoint1: CGPointMake(35.44, 15.27) controlPoint2: CGPointMake(35.52, 15.28)];
    [bezierPath addCurveToPoint: CGPointMake(36.46, 15.64) controlPoint1: CGPointMake(35.9, 15.37) controlPoint2: CGPointMake(36.18, 15.48)];
    [bezierPath addCurveToPoint: CGPointMake(37.15, 16.25) controlPoint1: CGPointMake(36.73, 15.8) controlPoint2: CGPointMake(36.96, 16)];
    [bezierPath addCurveToPoint: CGPointMake(37.8, 17.69) controlPoint1: CGPointMake(37.45, 16.72) controlPoint2: CGPointMake(37.66, 17.2)];
    [bezierPath addCurveToPoint: CGPointMake(38, 19.26) controlPoint1: CGPointMake(37.94, 18.19) controlPoint2: CGPointMake(38, 18.71)];
    [bezierPath addCurveToPoint: CGPointMake(37.97, 19.86) controlPoint1: CGPointMake(38, 19.45) controlPoint2: CGPointMake(37.99, 19.65)];
    [bezierPath addCurveToPoint: CGPointMake(37.88, 20.46) controlPoint1: CGPointMake(37.95, 20.07) controlPoint2: CGPointMake(37.92, 20.27)];
    [bezierPath addCurveToPoint: CGPointMake(37.62, 21.69) controlPoint1: CGPointMake(37.82, 20.88) controlPoint2: CGPointMake(37.73, 21.29)];
    [bezierPath addCurveToPoint: CGPointMake(37.28, 22.86) controlPoint1: CGPointMake(37.52, 22.09) controlPoint2: CGPointMake(37.4, 22.48)];
    [bezierPath addCurveToPoint: CGPointMake(35.03, 27.56) controlPoint1: CGPointMake(36.73, 24.45) controlPoint2: CGPointMake(35.98, 26.02)];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    [color setFill];
    [bezierPath fill];
    
}

- (void)drawRectEffectOpacity:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [self fillColor];
    
    /// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(23.75, 30.25)];
    [bezier2Path addCurveToPoint: CGPointMake(26.39, 24.52) controlPoint1: CGPointMake(23.75, 28.75) controlPoint2: CGPointMake(24.61, 26.87)];
    [bezier2Path addCurveToPoint: CGPointMake(30.09, 21.09) controlPoint1: CGPointMake(28.79, 21.35) controlPoint2: CGPointMake(29.45, 21.1)];
    [bezier2Path addCurveToPoint: CGPointMake(30.1, 20.93) controlPoint1: CGPointMake(30.09, 21.03) controlPoint2: CGPointMake(30.1, 20.98)];
    [bezier2Path addCurveToPoint: CGPointMake(29.14, 18.23) controlPoint1: CGPointMake(30.12, 19.9) controlPoint2: CGPointMake(29.8, 19)];
    [bezier2Path addCurveToPoint: CGPointMake(26.5, 16.51) controlPoint1: CGPointMake(28.48, 17.46) controlPoint2: CGPointMake(27.6, 16.88)];
    [bezier2Path addCurveToPoint: CGPointMake(24.72, 16.05) controlPoint1: CGPointMake(25.95, 16.3) controlPoint2: CGPointMake(25.36, 16.14)];
    [bezier2Path addCurveToPoint: CGPointMake(22.74, 15.91) controlPoint1: CGPointMake(24.07, 15.95) controlPoint2: CGPointMake(23.42, 15.91)];
    [bezier2Path addCurveToPoint: CGPointMake(21.87, 15.94) controlPoint1: CGPointMake(22.45, 15.91) controlPoint2: CGPointMake(22.16, 15.92)];
    [bezier2Path addCurveToPoint: CGPointMake(21.01, 16) controlPoint1: CGPointMake(21.59, 15.96) controlPoint2: CGPointMake(21.3, 15.98)];
    [bezier2Path addCurveToPoint: CGPointMake(15.81, 17.66) controlPoint1: CGPointMake(19.17, 16.23) controlPoint2: CGPointMake(17.44, 16.78)];
    [bezier2Path addCurveToPoint: CGPointMake(12.38, 21.21) controlPoint1: CGPointMake(14.18, 18.53) controlPoint2: CGPointMake(13.04, 19.72)];
    [bezier2Path addCurveToPoint: CGPointMake(12.1, 22.13) controlPoint1: CGPointMake(12.26, 21.53) controlPoint2: CGPointMake(12.16, 21.83)];
    [bezier2Path addCurveToPoint: CGPointMake(12, 22.98) controlPoint1: CGPointMake(12.03, 22.42) controlPoint2: CGPointMake(12, 22.71)];
    [bezier2Path addCurveToPoint: CGPointMake(12.95, 25.4) controlPoint1: CGPointMake(12, 23.95) controlPoint2: CGPointMake(12.32, 24.75)];
    [bezier2Path addCurveToPoint: CGPointMake(15.16, 26.36) controlPoint1: CGPointMake(13.58, 26.04) controlPoint2: CGPointMake(14.32, 26.36)];
    [bezier2Path addCurveToPoint: CGPointMake(15.7, 26.31) controlPoint1: CGPointMake(15.33, 26.36) controlPoint2: CGPointMake(15.51, 26.35)];
    [bezier2Path addCurveToPoint: CGPointMake(16.27, 26.17) controlPoint1: CGPointMake(15.89, 26.28) controlPoint2: CGPointMake(16.08, 26.24)];
    [bezier2Path addCurveToPoint: CGPointMake(17.17, 25.7) controlPoint1: CGPointMake(16.56, 26.07) controlPoint2: CGPointMake(16.86, 25.91)];
    [bezier2Path addCurveToPoint: CGPointMake(18.04, 24.91) controlPoint1: CGPointMake(17.47, 25.49) controlPoint2: CGPointMake(17.76, 25.22)];
    [bezier2Path addCurveToPoint: CGPointMake(18.15, 24.76) controlPoint1: CGPointMake(18.08, 24.87) controlPoint2: CGPointMake(18.12, 24.82)];
    [bezier2Path addCurveToPoint: CGPointMake(18.26, 24.62) controlPoint1: CGPointMake(18.18, 24.71) controlPoint2: CGPointMake(18.21, 24.66)];
    [bezier2Path addCurveToPoint: CGPointMake(18.48, 24.32) controlPoint1: CGPointMake(18.32, 24.52) controlPoint2: CGPointMake(18.39, 24.42)];
    [bezier2Path addCurveToPoint: CGPointMake(18.73, 24.05) controlPoint1: CGPointMake(18.56, 24.23) controlPoint2: CGPointMake(18.65, 24.14)];
    [bezier2Path addCurveToPoint: CGPointMake(18.56, 24.04) controlPoint1: CGPointMake(18.67, 24.05) controlPoint2: CGPointMake(18.61, 24.05)];
    [bezier2Path addCurveToPoint: CGPointMake(18.41, 24.02) controlPoint1: CGPointMake(18.5, 24.03) controlPoint2: CGPointMake(18.46, 24.02)];
    [bezier2Path addCurveToPoint: CGPointMake(16.8, 23.66) controlPoint1: CGPointMake(17.78, 23.96) controlPoint2: CGPointMake(17.25, 23.84)];
    [bezier2Path addCurveToPoint: CGPointMake(16.14, 22.28) controlPoint1: CGPointMake(16.36, 23.48) controlPoint2: CGPointMake(16.14, 23.02)];
    [bezier2Path addCurveToPoint: CGPointMake(16.14, 22.05) controlPoint1: CGPointMake(16.14, 22.2) controlPoint2: CGPointMake(16.14, 22.12)];
    [bezier2Path addCurveToPoint: CGPointMake(16.17, 21.81) controlPoint1: CGPointMake(16.14, 21.97) controlPoint2: CGPointMake(16.15, 21.9)];
    [bezier2Path addCurveToPoint: CGPointMake(17.55, 19.06) controlPoint1: CGPointMake(16.25, 20.72) controlPoint2: CGPointMake(16.71, 19.8)];
    [bezier2Path addCurveToPoint: CGPointMake(20.44, 17.96) controlPoint1: CGPointMake(18.38, 18.32) controlPoint2: CGPointMake(19.34, 17.96)];
    [bezier2Path addCurveToPoint: CGPointMake(21.89, 18.33) controlPoint1: CGPointMake(21.09, 17.96) controlPoint2: CGPointMake(21.57, 18.08)];
    [bezier2Path addCurveToPoint: CGPointMake(22.36, 19.41) controlPoint1: CGPointMake(22.2, 18.59) controlPoint2: CGPointMake(22.36, 18.95)];
    [bezier2Path addCurveToPoint: CGPointMake(22.32, 19.91) controlPoint1: CGPointMake(22.36, 19.56) controlPoint2: CGPointMake(22.35, 19.72)];
    [bezier2Path addCurveToPoint: CGPointMake(22.14, 20.52) controlPoint1: CGPointMake(22.28, 20.1) controlPoint2: CGPointMake(22.23, 20.31)];
    [bezier2Path addCurveToPoint: CGPointMake(21.4, 22.21) controlPoint1: CGPointMake(21.95, 21.06) controlPoint2: CGPointMake(21.71, 21.63)];
    [bezier2Path addCurveToPoint: CGPointMake(20.47, 23.99) controlPoint1: CGPointMake(21.09, 22.78) controlPoint2: CGPointMake(20.78, 23.38)];
    [bezier2Path addCurveToPoint: CGPointMake(19.55, 25.81) controlPoint1: CGPointMake(20.15, 24.58) controlPoint2: CGPointMake(19.85, 25.18)];
    [bezier2Path addCurveToPoint: CGPointMake(18.82, 27.65) controlPoint1: CGPointMake(19.26, 26.42) controlPoint2: CGPointMake(19.01, 27.04)];
    [bezier2Path addCurveToPoint: CGPointMake(18.57, 28.71) controlPoint1: CGPointMake(18.72, 28.01) controlPoint2: CGPointMake(18.64, 28.36)];
    [bezier2Path addCurveToPoint: CGPointMake(18.48, 29.74) controlPoint1: CGPointMake(18.51, 29.06) controlPoint2: CGPointMake(18.48, 29.4)];
    [bezier2Path addCurveToPoint: CGPointMake(18.68, 31.19) controlPoint1: CGPointMake(18.48, 30.22) controlPoint2: CGPointMake(18.55, 30.71)];
    [bezier2Path addCurveToPoint: CGPointMake(19.39, 32.61) controlPoint1: CGPointMake(18.82, 31.67) controlPoint2: CGPointMake(19.06, 32.15)];
    [bezier2Path addCurveToPoint: CGPointMake(21.38, 34.3) controlPoint1: CGPointMake(19.94, 33.41) controlPoint2: CGPointMake(20.6, 33.98)];
    [bezier2Path addCurveToPoint: CGPointMake(23.85, 34.79) controlPoint1: CGPointMake(22.16, 34.63) controlPoint2: CGPointMake(22.98, 34.79)];
    [bezier2Path addCurveToPoint: CGPointMake(24.73, 34.74) controlPoint1: CGPointMake(24.14, 34.79) controlPoint2: CGPointMake(24.44, 34.78)];
    [bezier2Path addCurveToPoint: CGPointMake(25.48, 34.65) controlPoint1: CGPointMake(24.98, 34.72) controlPoint2: CGPointMake(25.23, 34.68)];
    [bezier2Path addCurveToPoint: CGPointMake(23.75, 30.25) controlPoint1: CGPointMake(24.41, 33.49) controlPoint2: CGPointMake(23.75, 31.95)];
    [bezier2Path closePath];
    bezier2Path.miterLimit = 4;
    
    [color setFill];
    [bezier2Path fill];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(37.79, 17.69)];
    [bezier3Path addCurveToPoint: CGPointMake(37.15, 16.25) controlPoint1: CGPointMake(37.66, 17.19) controlPoint2: CGPointMake(37.44, 16.72)];
    [bezier3Path addCurveToPoint: CGPointMake(36.45, 15.64) controlPoint1: CGPointMake(36.96, 16) controlPoint2: CGPointMake(36.73, 15.79)];
    [bezier3Path addCurveToPoint: CGPointMake(35.6, 15.3) controlPoint1: CGPointMake(36.18, 15.48) controlPoint2: CGPointMake(35.89, 15.37)];
    [bezier3Path addCurveToPoint: CGPointMake(35.36, 15.24) controlPoint1: CGPointMake(35.51, 15.28) controlPoint2: CGPointMake(35.44, 15.26)];
    [bezier3Path addCurveToPoint: CGPointMake(35.13, 15.21) controlPoint1: CGPointMake(35.29, 15.22) controlPoint2: CGPointMake(35.21, 15.21)];
    [bezier3Path addCurveToPoint: CGPointMake(34.98, 15.21) controlPoint1: CGPointMake(35.09, 15.21) controlPoint2: CGPointMake(35.04, 15.21)];
    [bezier3Path addCurveToPoint: CGPointMake(34.84, 15.21) controlPoint1: CGPointMake(34.93, 15.21) controlPoint2: CGPointMake(34.88, 15.21)];
    [bezier3Path addCurveToPoint: CGPointMake(33.71, 15.51) controlPoint1: CGPointMake(34.38, 15.19) controlPoint2: CGPointMake(34, 15.29)];
    [bezier3Path addCurveToPoint: CGPointMake(32.88, 16.35) controlPoint1: CGPointMake(33.41, 15.73) controlPoint2: CGPointMake(33.14, 16.01)];
    [bezier3Path addCurveToPoint: CGPointMake(32.72, 16.55) controlPoint1: CGPointMake(32.82, 16.41) controlPoint2: CGPointMake(32.77, 16.48)];
    [bezier3Path addCurveToPoint: CGPointMake(32.57, 16.79) controlPoint1: CGPointMake(32.68, 16.63) controlPoint2: CGPointMake(32.63, 16.7)];
    [bezier3Path addCurveToPoint: CGPointMake(34.12, 18.16) controlPoint1: CGPointMake(33.35, 17.17) controlPoint2: CGPointMake(33.86, 17.62)];
    [bezier3Path addCurveToPoint: CGPointMake(34.49, 20.29) controlPoint1: CGPointMake(34.37, 18.7) controlPoint2: CGPointMake(34.49, 19.41)];
    [bezier3Path addCurveToPoint: CGPointMake(34.26, 22.46) controlPoint1: CGPointMake(34.49, 20.93) controlPoint2: CGPointMake(34.42, 21.65)];
    [bezier3Path addCurveToPoint: CGPointMake(33.81, 24.13) controlPoint1: CGPointMake(34.15, 23.01) controlPoint2: CGPointMake(33.99, 23.57)];
    [bezier3Path addCurveToPoint: CGPointMake(34.12, 24.52) controlPoint1: CGPointMake(33.91, 24.26) controlPoint2: CGPointMake(34.01, 24.38)];
    [bezier3Path addCurveToPoint: CGPointMake(35.55, 26.67) controlPoint1: CGPointMake(34.69, 25.29) controlPoint2: CGPointMake(35.16, 26)];
    [bezier3Path addCurveToPoint: CGPointMake(37.28, 22.86) controlPoint1: CGPointMake(36.26, 25.42) controlPoint2: CGPointMake(36.84, 24.15)];
    [bezier3Path addCurveToPoint: CGPointMake(37.63, 21.69) controlPoint1: CGPointMake(37.4, 22.48) controlPoint2: CGPointMake(37.52, 22.09)];
    [bezier3Path addCurveToPoint: CGPointMake(37.88, 20.45) controlPoint1: CGPointMake(37.73, 21.29) controlPoint2: CGPointMake(37.81, 20.88)];
    [bezier3Path addCurveToPoint: CGPointMake(37.97, 19.85) controlPoint1: CGPointMake(37.92, 20.27) controlPoint2: CGPointMake(37.95, 20.06)];
    [bezier3Path addCurveToPoint: CGPointMake(38.01, 19.25) controlPoint1: CGPointMake(37.99, 19.64) controlPoint2: CGPointMake(38.01, 19.44)];
    [bezier3Path addCurveToPoint: CGPointMake(37.79, 17.69) controlPoint1: CGPointMake(38, 18.7) controlPoint2: CGPointMake(37.93, 18.18)];
    [bezier3Path closePath];
    bezier3Path.miterLimit = 4;
    
    [color setFill];
    [bezier3Path fill];
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(30.25, 23.04)];
    [bezier4Path addCurveToPoint: CGPointMake(25.71, 30.25) controlPoint1: CGPointMake(30.18, 23.04) controlPoint2: CGPointMake(25.71, 27.75)];
    [bezier4Path addCurveToPoint: CGPointMake(30.25, 34.79) controlPoint1: CGPointMake(25.71, 32.76) controlPoint2: CGPointMake(27.74, 34.79)];
    [bezier4Path addCurveToPoint: CGPointMake(34.79, 30.25) controlPoint1: CGPointMake(32.76, 34.79) controlPoint2: CGPointMake(34.79, 32.76)];
    [bezier4Path addCurveToPoint: CGPointMake(30.25, 23.04) controlPoint1: CGPointMake(34.79, 27.75) controlPoint2: CGPointMake(30.32, 23.04)];
    [bezier4Path addLineToPoint: CGPointMake(30.25, 23.04)];
    [bezier4Path closePath];
    bezier4Path.miterLimit = 4;
    
    [color setFill];
    [bezier4Path fill];
    
    
}

- (void)drawRectEffectHistroy:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [self fillColor];
    
    //// Bezier 5 Drawing
    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint: CGPointMake(26.14, 32.7)];
    [bezier5Path addCurveToPoint: CGPointMake(26.16, 32.45) controlPoint1: CGPointMake(26.15, 32.62) controlPoint2: CGPointMake(26.15, 32.54)];
    [bezier5Path addCurveToPoint: CGPointMake(26.14, 32.7) controlPoint1: CGPointMake(26.15, 32.54) controlPoint2: CGPointMake(26.15, 32.62)];
    [bezier5Path closePath];
    bezier5Path.miterLimit = 4;
    
    [color setFill];
    [bezier5Path fill];
    
    
    //// Bezier 6 Drawing
    UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path moveToPoint: CGPointMake(26.12, 33.35)];
    [bezier6Path addCurveToPoint: CGPointMake(26.12, 33.14) controlPoint1: CGPointMake(26.12, 33.29) controlPoint2: CGPointMake(26.12, 33.21)];
    [bezier6Path addCurveToPoint: CGPointMake(26.12, 33.35) controlPoint1: CGPointMake(26.12, 33.21) controlPoint2: CGPointMake(26.12, 33.29)];
    [bezier6Path closePath];
    bezier6Path.miterLimit = 4;
    
    [color setFill];
    [bezier6Path fill];
    
    
    //// Bezier 7 Drawing
    UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
    [bezier7Path moveToPoint: CGPointMake(26.14, 33.86)];
    [bezier7Path addCurveToPoint: CGPointMake(26.14, 33.76) controlPoint1: CGPointMake(26.14, 33.83) controlPoint2: CGPointMake(26.14, 33.79)];
    [bezier7Path addCurveToPoint: CGPointMake(26.14, 33.86) controlPoint1: CGPointMake(26.14, 33.79) controlPoint2: CGPointMake(26.14, 33.83)];
    [bezier7Path closePath];
    bezier7Path.miterLimit = 4;
    
    [color setFill];
    [bezier7Path fill];
    
    
    //// Bezier 8 Drawing
    UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
    [bezier8Path moveToPoint: CGPointMake(26.21, 31.9)];
    [bezier8Path addCurveToPoint: CGPointMake(26.23, 31.65) controlPoint1: CGPointMake(26.22, 31.82) controlPoint2: CGPointMake(26.23, 31.74)];
    [bezier8Path addCurveToPoint: CGPointMake(26.21, 31.9) controlPoint1: CGPointMake(26.23, 31.73) controlPoint2: CGPointMake(26.22, 31.82)];
    [bezier8Path closePath];
    bezier8Path.miterLimit = 4;
    
    [color setFill];
    [bezier8Path fill];
    
    
    //// Bezier 9 Drawing
    UIBezierPath* bezier9Path = [UIBezierPath bezierPath];
    [bezier9Path moveToPoint: CGPointMake(24.29, 31.41)];
    [bezier9Path addCurveToPoint: CGPointMake(22.27, 26.88) controlPoint1: CGPointMake(22.8, 29.81) controlPoint2: CGPointMake(21.76, 28.45)];
    [bezier9Path addCurveToPoint: CGPointMake(26.56, 24.39) controlPoint1: CGPointMake(22.78, 25.3) controlPoint2: CGPointMake(24.42, 24.82)];
    [bezier9Path addCurveToPoint: CGPointMake(30.08, 21.1) controlPoint1: CGPointMake(27.59, 22.55) controlPoint2: CGPointMake(28.54, 21.19)];
    [bezier9Path addCurveToPoint: CGPointMake(30.1, 20.93) controlPoint1: CGPointMake(30.09, 21.04) controlPoint2: CGPointMake(30.1, 20.98)];
    [bezier9Path addCurveToPoint: CGPointMake(29.14, 18.23) controlPoint1: CGPointMake(30.12, 19.89) controlPoint2: CGPointMake(29.8, 18.99)];
    [bezier9Path addCurveToPoint: CGPointMake(26.5, 16.5) controlPoint1: CGPointMake(28.47, 17.46) controlPoint2: CGPointMake(27.59, 16.88)];
    [bezier9Path addCurveToPoint: CGPointMake(24.71, 16.05) controlPoint1: CGPointMake(25.95, 16.29) controlPoint2: CGPointMake(25.36, 16.14)];
    [bezier9Path addCurveToPoint: CGPointMake(22.74, 15.9) controlPoint1: CGPointMake(24.07, 15.95) controlPoint2: CGPointMake(23.41, 15.9)];
    [bezier9Path addCurveToPoint: CGPointMake(21.87, 15.94) controlPoint1: CGPointMake(22.45, 15.9) controlPoint2: CGPointMake(22.16, 15.91)];
    [bezier9Path addCurveToPoint: CGPointMake(21, 16) controlPoint1: CGPointMake(21.59, 15.96) controlPoint2: CGPointMake(21.3, 15.98)];
    [bezier9Path addCurveToPoint: CGPointMake(15.81, 17.66) controlPoint1: CGPointMake(19.17, 16.23) controlPoint2: CGPointMake(17.44, 16.78)];
    [bezier9Path addCurveToPoint: CGPointMake(12.38, 21.21) controlPoint1: CGPointMake(14.17, 18.53) controlPoint2: CGPointMake(13.03, 19.72)];
    [bezier9Path addCurveToPoint: CGPointMake(12.09, 22.13) controlPoint1: CGPointMake(12.25, 21.53) controlPoint2: CGPointMake(12.16, 21.83)];
    [bezier9Path addCurveToPoint: CGPointMake(12, 22.98) controlPoint1: CGPointMake(12.03, 22.42) controlPoint2: CGPointMake(12, 22.71)];
    [bezier9Path addCurveToPoint: CGPointMake(12.95, 25.4) controlPoint1: CGPointMake(12, 23.95) controlPoint2: CGPointMake(12.32, 24.75)];
    [bezier9Path addCurveToPoint: CGPointMake(15.16, 26.36) controlPoint1: CGPointMake(13.58, 26.04) controlPoint2: CGPointMake(14.32, 26.36)];
    [bezier9Path addCurveToPoint: CGPointMake(15.7, 26.31) controlPoint1: CGPointMake(15.33, 26.36) controlPoint2: CGPointMake(15.51, 26.35)];
    [bezier9Path addCurveToPoint: CGPointMake(16.27, 26.17) controlPoint1: CGPointMake(15.89, 26.28) controlPoint2: CGPointMake(16.08, 26.24)];
    [bezier9Path addCurveToPoint: CGPointMake(17.17, 25.7) controlPoint1: CGPointMake(16.56, 26.07) controlPoint2: CGPointMake(16.86, 25.91)];
    [bezier9Path addCurveToPoint: CGPointMake(18.04, 24.91) controlPoint1: CGPointMake(17.47, 25.49) controlPoint2: CGPointMake(17.76, 25.22)];
    [bezier9Path addCurveToPoint: CGPointMake(18.14, 24.76) controlPoint1: CGPointMake(18.08, 24.86) controlPoint2: CGPointMake(18.11, 24.82)];
    [bezier9Path addCurveToPoint: CGPointMake(18.25, 24.62) controlPoint1: CGPointMake(18.18, 24.71) controlPoint2: CGPointMake(18.21, 24.66)];
    [bezier9Path addCurveToPoint: CGPointMake(18.48, 24.32) controlPoint1: CGPointMake(18.32, 24.52) controlPoint2: CGPointMake(18.39, 24.42)];
    [bezier9Path addCurveToPoint: CGPointMake(18.73, 24.05) controlPoint1: CGPointMake(18.56, 24.23) controlPoint2: CGPointMake(18.65, 24.14)];
    [bezier9Path addCurveToPoint: CGPointMake(18.56, 24.03) controlPoint1: CGPointMake(18.67, 24.05) controlPoint2: CGPointMake(18.61, 24.05)];
    [bezier9Path addCurveToPoint: CGPointMake(18.41, 24.02) controlPoint1: CGPointMake(18.5, 24.02) controlPoint2: CGPointMake(18.46, 24.02)];
    [bezier9Path addCurveToPoint: CGPointMake(16.8, 23.66) controlPoint1: CGPointMake(17.78, 23.96) controlPoint2: CGPointMake(17.24, 23.83)];
    [bezier9Path addCurveToPoint: CGPointMake(16.14, 22.28) controlPoint1: CGPointMake(16.36, 23.48) controlPoint2: CGPointMake(16.14, 23.02)];
    [bezier9Path addCurveToPoint: CGPointMake(16.14, 22.05) controlPoint1: CGPointMake(16.14, 22.2) controlPoint2: CGPointMake(16.14, 22.12)];
    [bezier9Path addCurveToPoint: CGPointMake(16.17, 21.81) controlPoint1: CGPointMake(16.14, 21.97) controlPoint2: CGPointMake(16.15, 21.89)];
    [bezier9Path addCurveToPoint: CGPointMake(17.54, 19.06) controlPoint1: CGPointMake(16.25, 20.71) controlPoint2: CGPointMake(16.71, 19.8)];
    [bezier9Path addCurveToPoint: CGPointMake(20.44, 17.96) controlPoint1: CGPointMake(18.38, 18.32) controlPoint2: CGPointMake(19.34, 17.96)];
    [bezier9Path addCurveToPoint: CGPointMake(21.89, 18.33) controlPoint1: CGPointMake(21.09, 17.96) controlPoint2: CGPointMake(21.57, 18.08)];
    [bezier9Path addCurveToPoint: CGPointMake(22.36, 19.41) controlPoint1: CGPointMake(22.2, 18.59) controlPoint2: CGPointMake(22.36, 18.94)];
    [bezier9Path addCurveToPoint: CGPointMake(22.31, 19.91) controlPoint1: CGPointMake(22.36, 19.55) controlPoint2: CGPointMake(22.35, 19.72)];
    [bezier9Path addCurveToPoint: CGPointMake(22.14, 20.51) controlPoint1: CGPointMake(22.28, 20.1) controlPoint2: CGPointMake(22.22, 20.3)];
    [bezier9Path addCurveToPoint: CGPointMake(21.4, 22.2) controlPoint1: CGPointMake(21.95, 21.06) controlPoint2: CGPointMake(21.7, 21.62)];
    [bezier9Path addCurveToPoint: CGPointMake(20.47, 23.99) controlPoint1: CGPointMake(21.09, 22.78) controlPoint2: CGPointMake(20.78, 23.38)];
    [bezier9Path addCurveToPoint: CGPointMake(19.55, 25.8) controlPoint1: CGPointMake(20.15, 24.58) controlPoint2: CGPointMake(19.84, 25.18)];
    [bezier9Path addCurveToPoint: CGPointMake(18.82, 27.65) controlPoint1: CGPointMake(19.25, 26.42) controlPoint2: CGPointMake(19.01, 27.04)];
    [bezier9Path addCurveToPoint: CGPointMake(18.57, 28.71) controlPoint1: CGPointMake(18.72, 28.01) controlPoint2: CGPointMake(18.63, 28.36)];
    [bezier9Path addCurveToPoint: CGPointMake(18.47, 29.74) controlPoint1: CGPointMake(18.51, 29.06) controlPoint2: CGPointMake(18.47, 29.4)];
    [bezier9Path addCurveToPoint: CGPointMake(18.68, 31.19) controlPoint1: CGPointMake(18.47, 30.22) controlPoint2: CGPointMake(18.54, 30.71)];
    [bezier9Path addCurveToPoint: CGPointMake(19.39, 32.61) controlPoint1: CGPointMake(18.82, 31.67) controlPoint2: CGPointMake(19.05, 32.15)];
    [bezier9Path addCurveToPoint: CGPointMake(21.38, 34.3) controlPoint1: CGPointMake(19.94, 33.41) controlPoint2: CGPointMake(20.6, 33.98)];
    [bezier9Path addCurveToPoint: CGPointMake(23.85, 34.79) controlPoint1: CGPointMake(22.16, 34.63) controlPoint2: CGPointMake(22.98, 34.79)];
    [bezier9Path addCurveToPoint: CGPointMake(24.34, 34.77) controlPoint1: CGPointMake(24.01, 34.79) controlPoint2: CGPointMake(24.17, 34.77)];
    [bezier9Path addCurveToPoint: CGPointMake(24.29, 31.41) controlPoint1: CGPointMake(24.09, 33.92) controlPoint2: CGPointMake(24.14, 32.85)];
    [bezier9Path closePath];
    bezier9Path.miterLimit = 4;
    
    [color setFill];
    [bezier9Path fill];
    
    
    //// Bezier 10 Drawing
    UIBezierPath* bezier10Path = [UIBezierPath bezierPath];
    [bezier10Path moveToPoint: CGPointMake(34.12, 18.16)];
    [bezier10Path addCurveToPoint: CGPointMake(34.49, 20.3) controlPoint1: CGPointMake(34.37, 18.7) controlPoint2: CGPointMake(34.49, 19.41)];
    [bezier10Path addCurveToPoint: CGPointMake(34.26, 22.46) controlPoint1: CGPointMake(34.49, 20.93) controlPoint2: CGPointMake(34.42, 21.65)];
    [bezier10Path addCurveToPoint: CGPointMake(33.8, 24.15) controlPoint1: CGPointMake(34.15, 23.02) controlPoint2: CGPointMake(33.99, 23.59)];
    [bezier10Path addCurveToPoint: CGPointMake(33.94, 24.39) controlPoint1: CGPointMake(33.85, 24.23) controlPoint2: CGPointMake(33.89, 24.31)];
    [bezier10Path addCurveToPoint: CGPointMake(36.38, 25.07) controlPoint1: CGPointMake(34.87, 24.57) controlPoint2: CGPointMake(35.69, 24.78)];
    [bezier10Path addCurveToPoint: CGPointMake(37.28, 22.85) controlPoint1: CGPointMake(36.72, 24.33) controlPoint2: CGPointMake(37.02, 23.6)];
    [bezier10Path addCurveToPoint: CGPointMake(37.62, 21.68) controlPoint1: CGPointMake(37.4, 22.48) controlPoint2: CGPointMake(37.52, 22.09)];
    [bezier10Path addCurveToPoint: CGPointMake(37.88, 20.45) controlPoint1: CGPointMake(37.73, 21.29) controlPoint2: CGPointMake(37.81, 20.87)];
    [bezier10Path addCurveToPoint: CGPointMake(37.97, 19.85) controlPoint1: CGPointMake(37.92, 20.26) controlPoint2: CGPointMake(37.95, 20.06)];
    [bezier10Path addCurveToPoint: CGPointMake(38, 19.25) controlPoint1: CGPointMake(37.99, 19.64) controlPoint2: CGPointMake(38, 19.44)];
    [bezier10Path addCurveToPoint: CGPointMake(37.8, 17.69) controlPoint1: CGPointMake(38, 18.7) controlPoint2: CGPointMake(37.93, 18.18)];
    [bezier10Path addCurveToPoint: CGPointMake(37.15, 16.25) controlPoint1: CGPointMake(37.66, 17.19) controlPoint2: CGPointMake(37.44, 16.71)];
    [bezier10Path addCurveToPoint: CGPointMake(36.45, 15.63) controlPoint1: CGPointMake(36.96, 16) controlPoint2: CGPointMake(36.73, 15.79)];
    [bezier10Path addCurveToPoint: CGPointMake(35.6, 15.3) controlPoint1: CGPointMake(36.18, 15.48) controlPoint2: CGPointMake(35.9, 15.36)];
    [bezier10Path addCurveToPoint: CGPointMake(35.36, 15.24) controlPoint1: CGPointMake(35.52, 15.28) controlPoint2: CGPointMake(35.44, 15.26)];
    [bezier10Path addCurveToPoint: CGPointMake(35.13, 15.21) controlPoint1: CGPointMake(35.29, 15.22) controlPoint2: CGPointMake(35.21, 15.21)];
    [bezier10Path addCurveToPoint: CGPointMake(34.98, 15.21) controlPoint1: CGPointMake(35.09, 15.21) controlPoint2: CGPointMake(35.04, 15.21)];
    [bezier10Path addCurveToPoint: CGPointMake(34.84, 15.21) controlPoint1: CGPointMake(34.93, 15.21) controlPoint2: CGPointMake(34.89, 15.21)];
    [bezier10Path addCurveToPoint: CGPointMake(33.71, 15.51) controlPoint1: CGPointMake(34.38, 15.19) controlPoint2: CGPointMake(34, 15.29)];
    [bezier10Path addCurveToPoint: CGPointMake(32.88, 16.34) controlPoint1: CGPointMake(33.41, 15.73) controlPoint2: CGPointMake(33.14, 16.01)];
    [bezier10Path addCurveToPoint: CGPointMake(32.72, 16.55) controlPoint1: CGPointMake(32.82, 16.41) controlPoint2: CGPointMake(32.77, 16.48)];
    [bezier10Path addCurveToPoint: CGPointMake(32.57, 16.79) controlPoint1: CGPointMake(32.69, 16.62) controlPoint2: CGPointMake(32.63, 16.7)];
    [bezier10Path addCurveToPoint: CGPointMake(34.12, 18.16) controlPoint1: CGPointMake(33.35, 17.17) controlPoint2: CGPointMake(33.86, 17.62)];
    [bezier10Path closePath];
    bezier10Path.miterLimit = 4;
    
    [color setFill];
    [bezier10Path fill];
    
    
    //// Bezier 11 Drawing
    UIBezierPath* bezier11Path = [UIBezierPath bezierPath];
    [bezier11Path moveToPoint: CGPointMake(26.26, 34.33)];
    [bezier11Path addCurveToPoint: CGPointMake(26.23, 34.25) controlPoint1: CGPointMake(26.25, 34.3) controlPoint2: CGPointMake(26.24, 34.28)];
    [bezier11Path addCurveToPoint: CGPointMake(26.26, 34.33) controlPoint1: CGPointMake(26.23, 34.28) controlPoint2: CGPointMake(26.25, 34.3)];
    [bezier11Path closePath];
    bezier11Path.miterLimit = 4;
    
    [color setFill];
    [bezier11Path fill];
    
    
    
    //// Bezier 12 Drawing
    UIBezierPath* bezier12Path = [UIBezierPath bezierPath];
    [bezier12Path moveToPoint: CGPointMake(32.67, 26.14)];
    [bezier12Path addCurveToPoint: CGPointMake(34.16, 30.73) controlPoint1: CGPointMake(37.3, 27.02) controlPoint2: CGPointMake(37.4, 27.3)];
    [bezier12Path addCurveToPoint: CGPointMake(30.25, 33.57) controlPoint1: CGPointMake(34.72, 35.34) controlPoint2: CGPointMake(34.48, 35.56)];
    [bezier12Path addCurveToPoint: CGPointMake(26.33, 30.73) controlPoint1: CGPointMake(26.02, 35.56) controlPoint2: CGPointMake(25.78, 35.45)];
    [bezier12Path addCurveToPoint: CGPointMake(27.83, 26.14) controlPoint1: CGPointMake(23.09, 27.3) controlPoint2: CGPointMake(23.2, 27.02)];
    [bezier12Path addCurveToPoint: CGPointMake(32.67, 26.14) controlPoint1: CGPointMake(30.11, 22.01) controlPoint2: CGPointMake(30.4, 22.01)];
    [bezier12Path closePath];
    bezier12Path.miterLimit = 4;
    
    [color setFill];
    [bezier12Path fill];
}

- (void)drawRectBrightness:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [self fillColor];
    //// Bezier 15 Drawing
    UIBezierPath* bezier15Path = [UIBezierPath bezierPath];
    [bezier15Path moveToPoint: CGPointMake(19.86, 25)];
    [bezier15Path addCurveToPoint: CGPointMake(25, 30.14) controlPoint1: CGPointMake(19.86, 27.84) controlPoint2: CGPointMake(22.16, 30.14)];
    [bezier15Path addCurveToPoint: CGPointMake(30.14, 25) controlPoint1: CGPointMake(27.84, 30.14) controlPoint2: CGPointMake(30.14, 27.84)];
    [bezier15Path addCurveToPoint: CGPointMake(25, 19.86) controlPoint1: CGPointMake(30.14, 22.16) controlPoint2: CGPointMake(27.84, 19.86)];
    [bezier15Path addCurveToPoint: CGPointMake(19.86, 25) controlPoint1: CGPointMake(22.16, 19.86) controlPoint2: CGPointMake(19.86, 22.16)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(25, 13)];
    [bezier15Path addCurveToPoint: CGPointMake(23.86, 14.14) controlPoint1: CGPointMake(24.37, 13) controlPoint2: CGPointMake(23.86, 13.51)];
    [bezier15Path addLineToPoint: CGPointMake(23.86, 16.43)];
    [bezier15Path addCurveToPoint: CGPointMake(25, 17.57) controlPoint1: CGPointMake(23.86, 17.06) controlPoint2: CGPointMake(24.37, 17.57)];
    [bezier15Path addCurveToPoint: CGPointMake(26.14, 16.43) controlPoint1: CGPointMake(25.63, 17.57) controlPoint2: CGPointMake(26.14, 17.06)];
    [bezier15Path addLineToPoint: CGPointMake(26.14, 14.14)];
    [bezier15Path addCurveToPoint: CGPointMake(25, 13) controlPoint1: CGPointMake(26.14, 13.51) controlPoint2: CGPointMake(25.63, 13)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(25, 32.43)];
    [bezier15Path addCurveToPoint: CGPointMake(23.86, 33.57) controlPoint1: CGPointMake(24.37, 32.43) controlPoint2: CGPointMake(23.86, 32.94)];
    [bezier15Path addLineToPoint: CGPointMake(23.86, 35.86)];
    [bezier15Path addCurveToPoint: CGPointMake(25, 37) controlPoint1: CGPointMake(23.86, 36.48) controlPoint2: CGPointMake(24.37, 37)];
    [bezier15Path addCurveToPoint: CGPointMake(26.14, 35.86) controlPoint1: CGPointMake(25.63, 37) controlPoint2: CGPointMake(26.14, 36.48)];
    [bezier15Path addLineToPoint: CGPointMake(26.14, 33.57)];
    [bezier15Path addCurveToPoint: CGPointMake(25, 32.43) controlPoint1: CGPointMake(26.14, 32.94) controlPoint2: CGPointMake(25.63, 32.43)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(13, 25)];
    [bezier15Path addCurveToPoint: CGPointMake(14.14, 26.14) controlPoint1: CGPointMake(13, 25.63) controlPoint2: CGPointMake(13.51, 26.14)];
    [bezier15Path addLineToPoint: CGPointMake(16.43, 26.14)];
    [bezier15Path addCurveToPoint: CGPointMake(17.57, 25) controlPoint1: CGPointMake(17.06, 26.14) controlPoint2: CGPointMake(17.57, 25.63)];
    [bezier15Path addCurveToPoint: CGPointMake(16.43, 23.86) controlPoint1: CGPointMake(17.57, 24.37) controlPoint2: CGPointMake(17.06, 23.86)];
    [bezier15Path addLineToPoint: CGPointMake(14.14, 23.86)];
    [bezier15Path addCurveToPoint: CGPointMake(13, 25) controlPoint1: CGPointMake(13.51, 23.86) controlPoint2: CGPointMake(13, 24.37)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(32.43, 25)];
    [bezier15Path addCurveToPoint: CGPointMake(33.57, 26.14) controlPoint1: CGPointMake(32.43, 25.63) controlPoint2: CGPointMake(32.94, 26.14)];
    [bezier15Path addLineToPoint: CGPointMake(35.86, 26.14)];
    [bezier15Path addCurveToPoint: CGPointMake(37, 25) controlPoint1: CGPointMake(36.48, 26.14) controlPoint2: CGPointMake(37, 25.63)];
    [bezier15Path addCurveToPoint: CGPointMake(35.86, 23.86) controlPoint1: CGPointMake(37, 24.37) controlPoint2: CGPointMake(36.48, 23.86)];
    [bezier15Path addLineToPoint: CGPointMake(33.57, 23.86)];
    [bezier15Path addCurveToPoint: CGPointMake(32.43, 25) controlPoint1: CGPointMake(32.94, 23.86) controlPoint2: CGPointMake(32.43, 24.37)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(31, 14.61)];
    [bezier15Path addCurveToPoint: CGPointMake(29.44, 15.03) controlPoint1: CGPointMake(30.45, 14.29) controlPoint2: CGPointMake(29.75, 14.48)];
    [bezier15Path addLineToPoint: CGPointMake(28.3, 17.01)];
    [bezier15Path addCurveToPoint: CGPointMake(28.72, 18.57) controlPoint1: CGPointMake(27.98, 17.56) controlPoint2: CGPointMake(28.17, 18.25)];
    [bezier15Path addCurveToPoint: CGPointMake(30.27, 18.15) controlPoint1: CGPointMake(29.26, 18.88) controlPoint2: CGPointMake(29.96, 18.7)];
    [bezier15Path addLineToPoint: CGPointMake(31.42, 16.17)];
    [bezier15Path addCurveToPoint: CGPointMake(31, 14.61) controlPoint1: CGPointMake(31.73, 15.62) controlPoint2: CGPointMake(31.55, 14.93)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(21.29, 31.43)];
    [bezier15Path addCurveToPoint: CGPointMake(19.73, 31.85) controlPoint1: CGPointMake(20.74, 31.12) controlPoint2: CGPointMake(20.04, 31.3)];
    [bezier15Path addLineToPoint: CGPointMake(18.58, 33.83)];
    [bezier15Path addCurveToPoint: CGPointMake(19, 35.39) controlPoint1: CGPointMake(18.27, 34.38) controlPoint2: CGPointMake(18.45, 35.08)];
    [bezier15Path addCurveToPoint: CGPointMake(20.56, 34.97) controlPoint1: CGPointMake(19.55, 35.71) controlPoint2: CGPointMake(20.25, 35.52)];
    [bezier15Path addLineToPoint: CGPointMake(21.7, 32.99)];
    [bezier15Path addCurveToPoint: CGPointMake(21.29, 31.43) controlPoint1: CGPointMake(22.02, 32.45) controlPoint2: CGPointMake(21.83, 31.75)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(19, 14.61)];
    [bezier15Path addCurveToPoint: CGPointMake(18.58, 16.17) controlPoint1: CGPointMake(18.45, 14.93) controlPoint2: CGPointMake(18.27, 15.62)];
    [bezier15Path addLineToPoint: CGPointMake(19.73, 18.15)];
    [bezier15Path addCurveToPoint: CGPointMake(21.29, 18.57) controlPoint1: CGPointMake(20.04, 18.7) controlPoint2: CGPointMake(20.74, 18.88)];
    [bezier15Path addCurveToPoint: CGPointMake(21.7, 17.01) controlPoint1: CGPointMake(21.83, 18.25) controlPoint2: CGPointMake(22.02, 17.55)];
    [bezier15Path addLineToPoint: CGPointMake(20.56, 15.03)];
    [bezier15Path addCurveToPoint: CGPointMake(19, 14.61) controlPoint1: CGPointMake(20.25, 14.48) controlPoint2: CGPointMake(19.55, 14.29)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(28.71, 31.43)];
    [bezier15Path addCurveToPoint: CGPointMake(28.3, 32.99) controlPoint1: CGPointMake(28.16, 31.75) controlPoint2: CGPointMake(27.98, 32.45)];
    [bezier15Path addLineToPoint: CGPointMake(29.44, 34.97)];
    [bezier15Path addCurveToPoint: CGPointMake(31, 35.39) controlPoint1: CGPointMake(29.75, 35.52) controlPoint2: CGPointMake(30.45, 35.71)];
    [bezier15Path addCurveToPoint: CGPointMake(31.42, 33.83) controlPoint1: CGPointMake(31.55, 35.07) controlPoint2: CGPointMake(31.73, 34.38)];
    [bezier15Path addLineToPoint: CGPointMake(30.27, 31.85)];
    [bezier15Path addCurveToPoint: CGPointMake(28.71, 31.43) controlPoint1: CGPointMake(29.96, 31.3) controlPoint2: CGPointMake(29.26, 31.12)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(14.61, 31)];
    [bezier15Path addCurveToPoint: CGPointMake(16.17, 31.42) controlPoint1: CGPointMake(14.93, 31.55) controlPoint2: CGPointMake(15.62, 31.73)];
    [bezier15Path addLineToPoint: CGPointMake(18.15, 30.27)];
    [bezier15Path addCurveToPoint: CGPointMake(18.57, 28.72) controlPoint1: CGPointMake(18.7, 29.96) controlPoint2: CGPointMake(18.88, 29.26)];
    [bezier15Path addCurveToPoint: CGPointMake(17.01, 28.3) controlPoint1: CGPointMake(18.25, 28.17) controlPoint2: CGPointMake(17.55, 27.98)];
    [bezier15Path addLineToPoint: CGPointMake(15.03, 29.44)];
    [bezier15Path addCurveToPoint: CGPointMake(14.61, 31) controlPoint1: CGPointMake(14.48, 29.75) controlPoint2: CGPointMake(14.29, 30.45)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(31.43, 21.29)];
    [bezier15Path addCurveToPoint: CGPointMake(32.99, 21.7) controlPoint1: CGPointMake(31.75, 21.83) controlPoint2: CGPointMake(32.45, 22.02)];
    [bezier15Path addLineToPoint: CGPointMake(34.97, 20.56)];
    [bezier15Path addCurveToPoint: CGPointMake(35.39, 19) controlPoint1: CGPointMake(35.52, 20.25) controlPoint2: CGPointMake(35.71, 19.55)];
    [bezier15Path addCurveToPoint: CGPointMake(33.83, 18.58) controlPoint1: CGPointMake(35.07, 18.45) controlPoint2: CGPointMake(34.38, 18.27)];
    [bezier15Path addLineToPoint: CGPointMake(31.85, 19.73)];
    [bezier15Path addCurveToPoint: CGPointMake(31.43, 21.29) controlPoint1: CGPointMake(31.3, 20.04) controlPoint2: CGPointMake(31.12, 20.74)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(14.61, 19)];
    [bezier15Path addCurveToPoint: CGPointMake(15.03, 20.56) controlPoint1: CGPointMake(14.29, 19.55) controlPoint2: CGPointMake(14.48, 20.25)];
    [bezier15Path addLineToPoint: CGPointMake(17.01, 21.7)];
    [bezier15Path addCurveToPoint: CGPointMake(18.57, 21.29) controlPoint1: CGPointMake(17.55, 22.02) controlPoint2: CGPointMake(18.25, 21.83)];
    [bezier15Path addCurveToPoint: CGPointMake(18.15, 19.73) controlPoint1: CGPointMake(18.88, 20.74) controlPoint2: CGPointMake(18.7, 20.04)];
    [bezier15Path addLineToPoint: CGPointMake(16.17, 18.58)];
    [bezier15Path addCurveToPoint: CGPointMake(14.61, 19) controlPoint1: CGPointMake(15.62, 18.27) controlPoint2: CGPointMake(14.93, 18.45)];
    [bezier15Path closePath];
    [bezier15Path moveToPoint: CGPointMake(31.43, 28.71)];
    [bezier15Path addCurveToPoint: CGPointMake(31.85, 30.27) controlPoint1: CGPointMake(31.12, 29.26) controlPoint2: CGPointMake(31.3, 29.96)];
    [bezier15Path addLineToPoint: CGPointMake(33.83, 31.42)];
    [bezier15Path addCurveToPoint: CGPointMake(35.39, 31) controlPoint1: CGPointMake(34.38, 31.73) controlPoint2: CGPointMake(35.08, 31.55)];
    [bezier15Path addCurveToPoint: CGPointMake(34.97, 29.44) controlPoint1: CGPointMake(35.71, 30.45) controlPoint2: CGPointMake(35.52, 29.75)];
    [bezier15Path addLineToPoint: CGPointMake(32.99, 28.3)];
    [bezier15Path addCurveToPoint: CGPointMake(31.43, 28.71) controlPoint1: CGPointMake(32.45, 27.98) controlPoint2: CGPointMake(31.75, 28.17)];
    [bezier15Path closePath];
    bezier15Path.miterLimit = 4;
    
    bezier15Path.usesEvenOddFillRule = YES;
    
    [color setFill];
    [bezier15Path fill];
}

- (void)drawRectLevels:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [self fillColor];
    
    
    //// Bezier 14 Drawing
    UIBezierPath* bezier14Path = [UIBezierPath bezierPath];
    [bezier14Path moveToPoint: CGPointMake(25, 16.59)];
    [bezier14Path addLineToPoint: CGPointMake(23.36, 18.9)];
    [bezier14Path addLineToPoint: CGPointMake(20.79, 17.72)];
    [bezier14Path addLineToPoint: CGPointMake(20.53, 20.53)];
    [bezier14Path addLineToPoint: CGPointMake(17.71, 20.79)];
    [bezier14Path addLineToPoint: CGPointMake(18.9, 23.37)];
    [bezier14Path addLineToPoint: CGPointMake(16.59, 25)];
    [bezier14Path addLineToPoint: CGPointMake(18.9, 26.64)];
    [bezier14Path addLineToPoint: CGPointMake(17.71, 29.21)];
    [bezier14Path addLineToPoint: CGPointMake(20.53, 29.47)];
    [bezier14Path addLineToPoint: CGPointMake(20.79, 32.29)];
    [bezier14Path addLineToPoint: CGPointMake(23.37, 31.1)];
    [bezier14Path addLineToPoint: CGPointMake(25, 33.41)];
    [bezier14Path addLineToPoint: CGPointMake(26.64, 31.1)];
    [bezier14Path addLineToPoint: CGPointMake(29.21, 32.29)];
    [bezier14Path addLineToPoint: CGPointMake(29.47, 29.47)];
    [bezier14Path addLineToPoint: CGPointMake(32.29, 29.21)];
    [bezier14Path addLineToPoint: CGPointMake(31.1, 26.63)];
    [bezier14Path addLineToPoint: CGPointMake(33.41, 25)];
    [bezier14Path addLineToPoint: CGPointMake(31.1, 23.36)];
    [bezier14Path addLineToPoint: CGPointMake(32.29, 20.79)];
    [bezier14Path addLineToPoint: CGPointMake(29.47, 20.53)];
    [bezier14Path addLineToPoint: CGPointMake(29.21, 17.71)];
    [bezier14Path addLineToPoint: CGPointMake(26.63, 18.9)];
    [bezier14Path addLineToPoint: CGPointMake(25, 16.59)];
    [bezier14Path closePath];
    [bezier14Path moveToPoint: CGPointMake(25, 12)];
    [bezier14Path addLineToPoint: CGPointMake(22.48, 15.57)];
    [bezier14Path addLineToPoint: CGPointMake(18.5, 13.74)];
    [bezier14Path addLineToPoint: CGPointMake(18.09, 18.09)];
    [bezier14Path addLineToPoint: CGPointMake(13.74, 18.5)];
    [bezier14Path addLineToPoint: CGPointMake(15.57, 22.48)];
    [bezier14Path addLineToPoint: CGPointMake(12, 25)];
    [bezier14Path addLineToPoint: CGPointMake(15.57, 27.52)];
    [bezier14Path addLineToPoint: CGPointMake(13.74, 31.5)];
    [bezier14Path addLineToPoint: CGPointMake(18.09, 31.91)];
    [bezier14Path addLineToPoint: CGPointMake(18.5, 36.26)];
    [bezier14Path addLineToPoint: CGPointMake(22.48, 34.43)];
    [bezier14Path addLineToPoint: CGPointMake(25, 38)];
    [bezier14Path addLineToPoint: CGPointMake(27.52, 34.43)];
    [bezier14Path addLineToPoint: CGPointMake(31.5, 36.26)];
    [bezier14Path addLineToPoint: CGPointMake(31.91, 31.91)];
    [bezier14Path addLineToPoint: CGPointMake(36.26, 31.5)];
    [bezier14Path addLineToPoint: CGPointMake(34.43, 27.53)];
    [bezier14Path addLineToPoint: CGPointMake(38, 25)];
    [bezier14Path addLineToPoint: CGPointMake(34.43, 22.48)];
    [bezier14Path addLineToPoint: CGPointMake(36.26, 18.5)];
    [bezier14Path addLineToPoint: CGPointMake(31.91, 18.09)];
    [bezier14Path addLineToPoint: CGPointMake(31.5, 13.74)];
    [bezier14Path addLineToPoint: CGPointMake(27.52, 15.57)];
    [bezier14Path addLineToPoint: CGPointMake(25, 12)];
    [bezier14Path closePath];
    [bezier14Path moveToPoint: CGPointMake(25, 14.04)];
    [bezier14Path addLineToPoint: CGPointMake(27.13, 17.05)];
    [bezier14Path addLineToPoint: CGPointMake(30.48, 15.51)];
    [bezier14Path addLineToPoint: CGPointMake(30.83, 19.17)];
    [bezier14Path addLineToPoint: CGPointMake(34.49, 19.52)];
    [bezier14Path addLineToPoint: CGPointMake(32.95, 22.87)];
    [bezier14Path addLineToPoint: CGPointMake(35.96, 25)];
    [bezier14Path addLineToPoint: CGPointMake(32.95, 27.13)];
    [bezier14Path addLineToPoint: CGPointMake(34.49, 30.48)];
    [bezier14Path addLineToPoint: CGPointMake(30.82, 30.83)];
    [bezier14Path addLineToPoint: CGPointMake(30.48, 34.49)];
    [bezier14Path addLineToPoint: CGPointMake(27.13, 32.95)];
    [bezier14Path addLineToPoint: CGPointMake(25, 35.96)];
    [bezier14Path addLineToPoint: CGPointMake(22.87, 32.95)];
    [bezier14Path addLineToPoint: CGPointMake(19.52, 34.49)];
    [bezier14Path addLineToPoint: CGPointMake(19.18, 30.82)];
    [bezier14Path addLineToPoint: CGPointMake(15.51, 30.48)];
    [bezier14Path addLineToPoint: CGPointMake(17.05, 27.13)];
    [bezier14Path addLineToPoint: CGPointMake(14.04, 25)];
    [bezier14Path addLineToPoint: CGPointMake(17.05, 22.87)];
    [bezier14Path addLineToPoint: CGPointMake(15.51, 19.52)];
    [bezier14Path addLineToPoint: CGPointMake(19.18, 19.18)];
    [bezier14Path addLineToPoint: CGPointMake(19.52, 15.51)];
    [bezier14Path addLineToPoint: CGPointMake(22.87, 17.05)];
    [bezier14Path addLineToPoint: CGPointMake(25, 14.04)];
    [bezier14Path closePath];
    bezier14Path.miterLimit = 4;
    
    bezier14Path.usesEvenOddFillRule = YES;
    
    [color setFill];
    [bezier14Path fill];
    
}

@end
