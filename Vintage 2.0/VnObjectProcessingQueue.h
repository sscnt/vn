//
//  VnModelProcessingQueue.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, VnObjectProcessingQueueType){
    VnObjectProcessingQueueTypePreset = 1,
    VnObjectProcessingQueueTypePreview
};

@interface VnObjectProcessingQueue : NSObject

@property (nonatomic, assign) VnObjectProcessingQueueType type;
@property (nonatomic, strong) NSString* queueId;
@property (nonatomic, assign) VnAdjustmentToolId toolId;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, assign) VnEffectId effectId;

@end
