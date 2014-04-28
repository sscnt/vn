//
//  VnProcessingQueue.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "VnObjectProcessingQueue.h"

@protocol VnProcessingQueueManagerDelegate
- (void)queueDidFinished:(VnObjectProcessingQueue*)queue;
@end

@interface VnProcessingQueueManager : NSObject
{
    NSMutableArray* _queueList;
}

@property (nonatomic, weak) id<VnProcessingQueueManagerDelegate> delegate;
@property (nonatomic, assign) BOOL processing;
@property (nonatomic, strong) NSMutableArray* effectsPresetQueueList;

+ (VnProcessingQueueManager*)instance;
+ (NSString*)generateQueueId;
+ (NSString*)makeQueueIdFromSeeds:(NSString*)input;
+ (VnObjectProcessingQueue*)shiftQueue;
- (VnObjectProcessingQueue*)shiftQueue;
+ (VnObjectProcessingQueue*)shiftEffectQueue;
- (VnObjectProcessingQueue*)shiftEffectQueue;
+ (void)addQueue:(VnObjectProcessingQueue*)queue;
- (void)addQueue:(VnObjectProcessingQueue*)queue;

+ (int)numberOfEffectsInPreset;

- (void)processQueue;
- (void)processQueueTypePreset:(VnObjectProcessingQueue*)queue;
- (void)processQueueTypePreview:(VnObjectProcessingQueue*)queue;

- (void)didFinishProcessingQueue:(VnObjectProcessingQueue*)queue;

- (void)commonInit;
- (void)reset;

@end