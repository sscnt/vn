//
//  VnModelProcessingQueue.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnObjectProcessingQueue.h"

@implementation VnObjectProcessingQueue

- (id)init
{
    self = [super init];
    if (self) {
        _toolId = 0;
        _effectId = 0;
    }
    return self;
}

@end
