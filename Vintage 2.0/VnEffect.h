//
//  VnEffect.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

typedef NS_ENUM(NSInteger, VnEffectId){
    VnEffectIdHaze3 = 1,
    VnEffectIdHaze3Pink,
    VnEffectIdHazelnut,
    VnEffectIdHazelnutPink,
    VnEffectIdVintageFilm,
    VnEffectIdVintage2,
    VnEffectIdVintage1,
    VnEffectIdOldTone,
    VnEffectIdWeekend,
    VnEffectIdWarmAutumn,
    VnEffectIdJoyful,
    VnEffectIdWarmSpringLight,
    VnEffectIdGentleMemories,
    VnEffectIdCreamyNoon,
    VnEffectIdVividVintage,
    VnEffectIdCavalleriaRusticana,
    VnEffectIdDreamyVintage,
    VnEffectIdSunsetCarnevale,
    VnEffectIdBeachVintage,
    VnEffectIdPinkBubbleTea,
    VnEffectIdFaerieVintage,
    VnEffectIdGirder,
    VnEffectIdSummers,
    VnEffectIdMiami,
    VnEffectIdVampire,
    VnEffectIdAutumnVintage,
    VnEffectIdBokehileVintage,
    VnEffectIdBokehileVintage2,
    VnEffectIdGoodMorning,
    VnEffectIdVintageBaby,
    VnEffectIdDreamyCreamy
};

typedef NS_ENUM(NSInteger, VnBlendingMode){
    VnBlendingModeNormal = 1,
    VnBlendingModeDarken,
    VnBlendingModeScreen,
    VnBlendingModeMultiply,
    VnBlendingModeDarkerColor,
    VnBlendingModeLighten,
    VnBlendingModeSoftLight,
    VnBlendingModeHardLight,
    VnBlendingModeVividLight,
    VnBlendingModeOverlay,
    VnBlendingModeExclusion,
    VnBlendingModeColorBurn,
    VnBlendingModeColor,
    VnBlendingModeColorDodge,
    VnBlendingModeLinearDodge,
    VnBlendingModeLinearLight,
    VnBlendingModeHue,
    VnBlendingModeSaturation,
    VnBlendingModeDifference
};


@interface VnEffect : NSObject


@property (nonatomic, weak) UIImage* imageToProcess;
@property (nonatomic, assign) VnEffectId effectId;
@property (nonatomic, assign) CGFloat defaultOpacity;
@property (nonatomic, assign) CGFloat faceOpacity;

- (UIImage*)process;
- (UIImage*)mergeBaseImage:(UIImage*)baseImage overlayImage:(UIImage*)overlayImage opacity:(CGFloat)opacity blendingMode:(VnBlendingMode)blendingMode;
- (UIImage*)mergeBaseImage:(UIImage*)baseImage overlayFilter:(GPUImageFilter*)overlayFilter opacity:(CGFloat)opacity blendingMode:(VnBlendingMode)blendingMode;
+ (id)effectByBlendMode:(VnBlendingMode)mode;

@end
