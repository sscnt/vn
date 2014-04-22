//
//  VnProcessingQueue.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnProcessingQueueManager.h"

@implementation VnProcessingQueueManager

static VnProcessingQueueManager* sharedVnProcessingQueue = nil;

+ (VnProcessingQueueManager*)instance {
	@synchronized(self) {
		if (sharedVnProcessingQueue == nil) {
			sharedVnProcessingQueue = [[self alloc] init];
		}
	}
	return sharedVnProcessingQueue;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnProcessingQueue == nil) {
			sharedVnProcessingQueue = [super allocWithZone:zone];
			return sharedVnProcessingQueue;
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
        
    }
    return self;
}

+ (NSString *)generateQueueId
{
    UInt64 milisec = (UInt64)floor((CFAbsoluteTimeGetCurrent() + kCFAbsoluteTimeIntervalSince1970) * 1000.0);
    uint32_t rand = arc4random_uniform(9999);
    NSString* seed = [NSString stringWithFormat:@"%llu.%d", milisec, rand];
    seed = [VnProcessingQueueManager makeQueueIdFromSeeds:seed];
    return seed;
}

+ (NSString *)makeQueueIdFromSeeds:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
