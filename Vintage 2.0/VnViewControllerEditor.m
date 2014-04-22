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
    VnEditorViewManager* manager = [VnEditorViewManager instance];
    manager.view = self.view;
    [manager layout];
}

- (void)didFinishResizing
{
    [VnEditorProgressManager setResizingProgress:1.0f];
    VnEditorViewManager* manager = [VnEditorViewManager instance];
    [manager setPreviewImage:[VnCurrentImage resizedImageForEditor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
