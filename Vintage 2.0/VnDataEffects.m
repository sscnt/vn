//
//  VnDataEffects.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnDataEffects.h"

@implementation VnDataEffects

static VnDataEffects* sharedVnDataEffects = nil;

+ (VnDataEffects*)instance {
	@synchronized(self) {
		if (sharedVnDataEffects == nil) {
			sharedVnDataEffects = [[self alloc] init];
		}
	}
	return sharedVnDataEffects;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnDataEffects == nil) {
			sharedVnDataEffects = [super allocWithZone:zone];
			return sharedVnDataEffects;
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
        [self initEffectsList];
    }
    return self;
}

- (void)initEffectsList
{
    _effectsList = [NSMutableArray array];
    VnObjectEffect* effect;
    
    //// None
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdNone;
    effect.name = NSLocalizedString(@"None", nil);
    [_effectsList addObject:effect];
    
    //// Autumn Vintage
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdAutumnVintage;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Beach Vintage
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdBeachVintage;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Bokehile Vintage
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdBokehileVintage;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Cavalleria Rusticana
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdCavalleriaRusticana;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Creamy Noon
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdCreamyNoon;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Dreamy Creamy
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdDreamyCreamy;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Dreamy Vintage
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdDreamyVintage;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Faerie Vintage
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdFaerieVintage;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Gentle Memories
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdGentleMemories;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Haze 3 Pink
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdHaze3Pink;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Hazelnut
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdHazelnut;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Hazelnut Pink
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdHazelnutPink;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
}

+ (int)effectsCount
{
    return (int)[[VnDataEffects instance].effectsList count];
}

+ (VnObjectEffect *)effectAtIndex:(int)index
{
    if (index < [VnDataEffects effectsCount]) {
        return (VnObjectEffect*)[[VnDataEffects instance].effectsList objectAtIndex:index];
    }
    return nil;
}

@end
