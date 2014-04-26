//
//  Processor.h
//  Winterpix
//
//  Created by SSC on 2014/04/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"


@protocol VnProcessorDelegate <NSObject>
@optional
- (void)processorDidFinishProcessing:(UIImage*)image;
@end

@interface VnProcessor : NSObject

@property (nonatomic, assign) VnEffectId effectId;
@property (nonatomic, assign) BOOL faceDetected;
@property (nonatomic, assign) float opacity;
@property (nonatomic, assign) float temp;
@property (nonatomic, assign) float tint;
@property (nonatomic, assign) float brightness;
@property (nonatomic, assign) float levels;
@property (nonatomic, assign) float softfocus;
@property (nonatomic, assign) float contrast;
@property (nonatomic, assign) float localContrast;
@property (nonatomic, assign) float localContrastRadius;
@property (nonatomic, assign) float sharpness;
@property (nonatomic, assign) float saturation;
@property (nonatomic, assign) float vibrance;

@property (nonatomic, assign) float photoFilterOpacity;

@property (nonatomic, assign) float textureOpacity;

@property (nonatomic, assign) float shadows;
@property (nonatomic, assign) float highlights;
@property (nonatomic, assign) float whites;
@property (nonatomic, assign) float blacks;

@property (nonatomic, assign) float saturationRed;
@property (nonatomic, assign) float saturationOrange;
@property (nonatomic, assign) float saturationYellow;
@property (nonatomic, assign) float saturationGreen;
@property (nonatomic, assign) float saturationCyan;
@property (nonatomic, assign) float saturationBlue;
@property (nonatomic, assign) float saturationPurple;
@property (nonatomic, assign) float saturationMagenta;

@property (nonatomic, assign) float luminanceRed;
@property (nonatomic, assign) float luminanceOrange;
@property (nonatomic, assign) float luminanceYellow;
@property (nonatomic, assign) float luminanceGreen;
@property (nonatomic, assign) float luminanceCyan;
@property (nonatomic, assign) float luminanceBlue;
@property (nonatomic, assign) float luminancePurple;
@property (nonatomic, assign) float luminanceMagenta;

@property (nonatomic, assign) float selectiveColorRedsCyan;
@property (nonatomic, assign) float selectiveColorRedsMagenta;
@property (nonatomic, assign) float selectiveColorRedsYellow;
@property (nonatomic, assign) float selectiveColorRedsBlack;
@property (nonatomic, assign) float selectiveColorYellowsCyan;
@property (nonatomic, assign) float selectiveColorYellowsMagenta;
@property (nonatomic, assign) float selectiveColorYellowsYellow;
@property (nonatomic, assign) float selectiveColorYellowsBlack;
@property (nonatomic, assign) float selectiveColorGreensCyan;
@property (nonatomic, assign) float selectiveColorGreensMagenta;
@property (nonatomic, assign) float selectiveColorGreensYellow;
@property (nonatomic, assign) float selectiveColorGreensBlack;
@property (nonatomic, assign) float selectiveColorCyansCyan;
@property (nonatomic, assign) float selectiveColorCyansMagenta;
@property (nonatomic, assign) float selectiveColorCyansYellow;
@property (nonatomic, assign) float selectiveColorCyansBlack;
@property (nonatomic, assign) float selectiveColorBluesCyan;
@property (nonatomic, assign) float selectiveColorBluesMagenta;
@property (nonatomic, assign) float selectiveColorBluesYellow;
@property (nonatomic, assign) float selectiveColorBluesBlack;
@property (nonatomic, assign) float selectiveColorMagentasCyan;
@property (nonatomic, assign) float selectiveColorMagentasMagenta;
@property (nonatomic, assign) float selectiveColorMagentasYellow;
@property (nonatomic, assign) float selectiveColorMagentasBlack;
@property (nonatomic, assign) float selectiveColorWhitesCyan;
@property (nonatomic, assign) float selectiveColorWhitesMagenta;
@property (nonatomic, assign) float selectiveColorWhitesYellow;
@property (nonatomic, assign) float selectiveColorWhitesBlack;
@property (nonatomic, assign) float selectiveColorNeutralsCyan;
@property (nonatomic, assign) float selectiveColorNeutralsMagenta;
@property (nonatomic, assign) float selectiveColorNeutralsYellow;
@property (nonatomic, assign) float selectiveColorNeutralsBlack;
@property (nonatomic, assign) float selectiveColorBlacksCyan;
@property (nonatomic, assign) float selectiveColorBlacksMagenta;
@property (nonatomic, assign) float selectiveColorBlacksYellow;
@property (nonatomic, assign) float selectiveColorBlacksBlack;

+ (VnProcessor*)instance;
+ (void)reset;
- (void)reset;

+ (UIImage*)executeWithImage:(UIImage*)image;
- (UIImage*)executeWithImage:(UIImage*)image;

+ (UIImage*)applyEffect:(UIImage*)image;
- (UIImage*)applyEffect:(UIImage*)image;

+ (UIImage*)applyEffect:(VnEffectId)effectId ToImage:(UIImage*)image;
- (UIImage*)applyEffect:(VnEffectId)effectId ToImage:(UIImage*)image;

+ (UIImage*)executeWithCurrentOriginalImage;
- (UIImage*)executeWithCurrentOriginalImage;


+ (UIImage*)mergeBaseImage:(UIImage*)baseImage overlayImage:(UIImage*)overlayImage opacity:(CGFloat)opacity blendingMode:(VnBlendingMode)blendingMode;
+ (UIImage*)mergeBaseImage:(UIImage*)baseImage overlayFilter:(GPUImageFilter*)overlayFilter opacity:(CGFloat)opacity blendingMode:(VnBlendingMode)blendingMode;
+ (id)effectByBlendMode:(VnBlendingMode)mode;

@end