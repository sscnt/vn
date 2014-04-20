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
        _viewManager = [[VnEditorViewManager alloc] init];
        _viewManager.view = self.view;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_viewManager layout];
}

- (void)didFinishResizing
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
