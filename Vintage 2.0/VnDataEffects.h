//
//  VnDataEffects.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VnDataEffects : NSObject

@property (nonatomic, strong) NSMutableArray* effectsList;

+ (VnDataEffects*)instance;
+ (int)effectsCount;
+ (VnObjectEffect*)effectAtIndex:(int)index;


- (void)initEffectsList;
@end
