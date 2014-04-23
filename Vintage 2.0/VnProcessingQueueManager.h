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

@protocol VnProcessingQueueManagerDelegate
- (void)queueDidFinished:(VnModelProcessingQueue*)queue;
@end

@interface VnProcessingQueueManager : NSObject
{
    NSMutableArray* _queue;
}

@property (nonatomic, weak) id<VnProcessingQueueManagerDelegate> delegate;

+ (VnProcessingQueueManager*)instance;
+ (NSString*)generateQueueId;
+ (NSString*)makeQueueIdFromSeeds:(NSString*)input;

@end
