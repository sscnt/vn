//
//  Processor.m
//  Winterpix
//
//  Created by SSC on 2014/04/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//


#import "VnProcessor.h"

float absf(float v){
    if (v < 0.0f) {
        return -v;
    }
    return v;
}

@implementation VnProcessor

static VnProcessor* sharedVnProcessor = nil;

+ (VnProcessor*)instance {
	@synchronized(self) {
		if (sharedVnProcessor == nil) {
			sharedVnProcessor = [[self alloc] init];
		}
	}
	return sharedVnProcessor;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnProcessor == nil) {
			sharedVnProcessor = [super allocWithZone:zone];
			return sharedVnProcessor;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (id)init
{
    self = [super init];
    if (self) {
        [self reset];
    }
    return self;
}

+ (void)reset
{
    [[VnProcessor instance] reset];
}

- (void)reset
{
    
}

#pragma mark execution

+ (UIImage *)executeWithCurrentOriginalImage
{
    return [self executeWithCurrentOriginalImage];
}

- (UIImage *)executeWithCurrentOriginalImage
{
    return nil;
}

+ (UIImage *)executeWithImage:(UIImage *)image
{
    return [[VnProcessor instance] executeWithImage:image];
}

- (UIImage *)executeWithImage:(UIImage *)image
{
    return nil;
}

#pragma mark apply
#pragma mark apply effects

+ (UIImage *)applyEffect:(UIImage *)image
{
    return [[VnProcessor instance] applyEffect:image];
}

- (UIImage *)applyEffect:(UIImage *)image
{
    return [self applyEffect:_effectId ToImage:image];
}

+ (UIImage *)applyEffect:(VnEffectId)effectId ToImage:(UIImage *)image
{
    return [[VnProcessor instance] applyEffect:effectId ToImage:image];
}

- (UIImage *)applyEffect:(VnEffectId)effectId ToImage:(UIImage *)image
{
    if (image == nil) {
        return nil;
    }
    if (effectId == VnEffectIdNone) {
        return image;
    }
    if(effectId == VnEffectIdAutumnVintage) {
        VnEffectAutumnVintage* effect = [[VnEffectAutumnVintage alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdBeachVintage) {
        VnEffectBeachVintage* effect = [[VnEffectBeachVintage alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdBokehileVintage) {
        VnEffectBokehileVintage* effect = [[VnEffectBokehileVintage alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdCavalleriaRusticana) {
        VnEffectCavalleriaRusticana* effect = [[VnEffectCavalleriaRusticana alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdCreamyNoon) {
        VnEffectCreamyNoon* effect = [[VnEffectCreamyNoon alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdDreamyCreamy) {
        VnEffectDreamyCreamy* effect = [[VnEffectDreamyCreamy alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdDreamyVintage) {
        VnEffectDreamyVintage* effect = [[VnEffectDreamyVintage alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdFaerieVintage) {
        VnEffectFaerieVintage* effect = [[VnEffectFaerieVintage alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdGentleMemories) {
        VnEffectGentleMemories* effect = [[VnEffectGentleMemories alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdGoodMorning) {
        VnEffectGoodMorning* effect = [[VnEffectGoodMorning alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdGirder) {
        VnEffectGirder* effect = [[VnEffectGirder alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdHaze3Pink) {
        VnEffectHaze3Pink* effect = [[VnEffectHaze3Pink alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdHazelnut) {
        VnEffectHazelnut* effect = [[VnEffectHazelnut alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdHazelnutPink) {
        VnEffectHazelnutPink* effect = [[VnEffectHazelnutPink alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdJoyful) {
        VnEffectJoyful* effect = [[VnEffectJoyful alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdMiami) {
        VnEffectMiami* effect = [[VnEffectMiami alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdOldTone) {
        VnEffectOldTone* effect = [[VnEffectOldTone alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdPinkBubbleTea) {
        VnEffectPinkBubbleTea* effect = [[VnEffectPinkBubbleTea alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdSummers) {
        VnEffectSummers* effect = [[VnEffectSummers alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdSunsetCarnevale) {
        VnEffectSunsetCarnevale* effect = [[VnEffectSunsetCarnevale alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdVampire) {
        VnEffectVampire* effect = [[VnEffectVampire alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    if(effectId == VnEffectIdVintage2) {
        VnEffectVintage2* effect = [[VnEffectVintage2 alloc] init];
        effect.imageToProcess = image;
        return [effect process];
    }
    return nil;
}

+ (UIImage*)mergeBaseImage:(UIImage *)baseImage overlayImage:(UIImage *)overlayImage opacity:(CGFloat)opacity blendingMode:(VnBlendingMode)blendingMode
{
    GPUImagePicture* overlayPicture = [[GPUImagePicture alloc] initWithImage:overlayImage];
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = opacity;
    [overlayPicture addTarget:opacityFilter];
    
    GPUImagePicture* basePicture = [[GPUImagePicture alloc] initWithImage:baseImage];
    
    id blending = [VnProcessor effectByBlendMode:blendingMode];
    [opacityFilter addTarget:blending atTextureLocation:1];
    
    [basePicture addTarget:blending];
    [basePicture processImage];
    [overlayPicture processImage];
    return [blending imageFromCurrentlyProcessedOutput];
    
}

+ (UIImage*)mergeBaseImage:(UIImage *)baseImage overlayFilter:(GPUImageFilter *)overlayFilter opacity:(CGFloat)opacity blendingMode:(VnBlendingMode)blendingMode
{
    if (opacity == 1.0f) {
        
        GPUImagePicture* picture = [[GPUImagePicture alloc] initWithImage:baseImage];
        [picture addTarget:overlayFilter];
        
        id blending = [VnProcessor effectByBlendMode:blendingMode];
        [overlayFilter addTarget:blending atTextureLocation:1];
        
        [picture addTarget:blending];
        [picture processImage];
        UIImage* mergedImage = [blending imageFromCurrentlyProcessedOutput];
        [picture removeAllTargets];
        [overlayFilter removeAllTargets];
        return mergedImage;
        
    }else{
        
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = opacity;
        [overlayFilter addTarget:opacityFilter];
        
        GPUImagePicture* picture = [[GPUImagePicture alloc] initWithImage:baseImage];
        [picture addTarget:overlayFilter];
        
        id blending = [VnProcessor effectByBlendMode:blendingMode];
        [opacityFilter addTarget:blending atTextureLocation:1];
        
        [picture addTarget:blending];
        [picture processImage];
        UIImage* mergedImage = [blending imageFromCurrentlyProcessedOutput];
        [picture removeAllTargets];
        [overlayFilter removeAllTargets];
        [opacityFilter removeAllTargets];
        return mergedImage;
        
    }
    
}

+ (id)effectByBlendMode:(VnBlendingMode)mode
{
    id blending;
    if(mode == VnBlendingModeNormal){
        blending = [[VnBlendingNormal alloc] init];
    }
    if(mode == VnBlendingModeDarken){
        blending = [[VnBlendingDarken alloc] init];
    }
    if(mode == VnBlendingModeMultiply){
        blending = [[VnBlendingMultiply alloc] init];
    }
    if(mode == VnBlendingModeScreen){
        blending = [[VnBlendingScreen alloc] init];
    }
    if(mode == VnBlendingModeSoftLight){
        blending = [[VnBlendingSoftLight alloc] init];
    }
    if(mode == VnBlendingModeLighten){
        blending = [[VnBlendingLighten alloc] init];
    }
    if(mode == VnBlendingModeHardLight){
        blending = [[VnBlendingHardLight alloc] init];
    }
    if(mode == VnBlendingModeVividLight){
        blending = [[VnBlendingVividLight alloc] init];
    }
    if(mode == VnBlendingModeOverlay){
        blending = [[VnBlendingOverlay alloc] init];
    }
    if(mode == VnBlendingModeColorDodge){
        blending = [[VnBlendingColorDodge alloc] init];
    }
    if(mode == VnBlendingModeLinearDodge){
        blending = [[VnBlendingLinearDodge alloc] init];
    }
    if(mode == VnBlendingModeDarkerColor){
        blending = [[VnBlendingDarkerColor alloc] init];
    }
    if(mode == VnBlendingModeExclusion){
        blending = [[VnBlendingExclusion alloc] init];
    }
    if(mode == VnBlendingModeColor){
        blending = [[VnBlendingColor alloc] init];
    }
    if(mode == VnBlendingModeHue){
        blending = [[VnBlendingHue alloc] init];
    }
    if(mode == VnBlendingModeColorBurn){
        blending = [[VnBlendingColorBurn alloc] init];
    }
    if(mode == VnBlendingModeSaturation){
        blending = [[VnBlendingSaturation alloc] init];
    }
    if(mode == VnBlendingModeDifference){
        blending = [[VnBlendingDifference alloc] init];
    }
    if(mode == VnBlendingModeLinearLight){
        blending = [[VnBlendingLinearLight alloc] init];
    }
    return blending;
}

@end
