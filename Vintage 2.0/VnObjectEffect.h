//
//  VnModelEffect.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VnObjectEffect : NSObject

@property (nonatomic, assign) VnEffectId effectId;
@property (nonatomic, strong) UIImage* previewImage;
@property (nonatomic, strong) NSString* name;

@end
