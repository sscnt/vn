//
//  GPUImageAllAdjustmentsInOneFilter.h
//  Vintage
//
//  Created by SSC on 2014/03/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "GPUImageFilterGroup.h"

@class GPUImageGaussianBlurFilter;


@interface GPUImageAllAdjustmentsInOneFilter : GPUImageFilterGroup
{
    //// Clarity
    GPUImageGaussianBlurFilter *blurFilter;
    GPUImageFilter *unsharpMaskFilter;
    
    //// Levels
    GPUVector3 levelsMinVector, levelsMidVector, levelsMaxVector, levelsMinOutputVector, levlesMaxOutputVector;
}

@property (nonatomic, assign) CGFloat brightness;

@property (nonatomic, assign) CGFloat clarityBlurRadiusInPixels;
@property (nonatomic, assign) CGFloat clarityIntensity;

@property(readwrite, nonatomic) CGFloat contrast;

@property (nonatomic, assign) float kelvin;
@property (nonatomic, assign) float kelvinStrength;

#pragma mark Levels
- (void)setLevelsRedMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max minOut:(CGFloat)minOut maxOut:(CGFloat)maxOut;
- (void)setLevelsRedMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max;
- (void)setLevelsGreenMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max minOut:(CGFloat)minOut maxOut:(CGFloat)maxOut;
- (void)setLevelsGreenMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max;
- (void)setLevelsBlueMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max minOut:(CGFloat)minOut maxOut:(CGFloat)maxOut;
- (void)setLevelsBlueMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max;
- (void)setLevelsMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max minOut:(CGFloat)minOut maxOut:(CGFloat)maxOut;
- (void)setLevelsMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max;


@end
