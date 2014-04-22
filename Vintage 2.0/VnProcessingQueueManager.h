//
//  VnProcessingQueue.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "VnModelProcessingQueue.h"

@interface VnProcessingQueueManager : NSObject
{
    NSMutableArray* _queue;
}

+ (VnProcessingQueueManager*)instance;
+ (NSString*)generateQueueId;
+ (NSString*)makeQueueIdFromSeeds:(NSString*)input;

@end
