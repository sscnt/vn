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
    
    //// Haze 3
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdHaze3;
    effect.name = [NSString stringWithFormat:@"#%02d", (int)effect.effectId];
    [_effectsList addObject:effect];
    
    //// Haze 3 Pink
    effect = [[VnObjectEffect alloc] init];
    effect.effectId = VnEffectIdHaze3Pink;
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
