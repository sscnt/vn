//
//  VnViewControllerEditor.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VnEditorViewManager.h"

@interface VnViewControllerEditor : UIViewController <VnProcessingQueueManagerDelegate, VnEditorViewManagerDelegate>

- (void)didFinishResizing;

@end
