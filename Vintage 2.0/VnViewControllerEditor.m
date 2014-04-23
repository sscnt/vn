//
//  VnViewControllerEditor.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewControllerEditor.h"

@implementation VnViewControllerEditor

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    VnEditorViewManager* vm = [VnEditorViewManager instance];
    vm.view = self.view;
    [vm layout];
    
    VnProcessingQueueManager* qm = [VnProcessingQueueManager instance];
    qm.delegate = self;
}

- (void)didFinishResizing
{
    [VnEditorProgressManager setResizingProgress:1.0f];
    VnEditorViewManager* vm = [VnEditorViewManager instance];
    [vm setPreviewImage:[VnCurrentImage originalPreviewImage]];
}

#pragma mark delegate

- (void)queueDidFinished:(VnModelProcessingQueue *)queue
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
