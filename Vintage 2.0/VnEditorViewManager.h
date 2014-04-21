//
//  VnEditorViewManager.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VnEditorSliderManager.h"
#import "VnViewEditorToolBarButton.h"
#import "VnVIewEditorToolBar.h"


@interface VnEditorViewManager : NSObject

@property (nonatomic, weak) UIView* view;
@property (nonatomic, strong) VnVIewEditorToolBar* toolBar;
@property (nonatomic, strong) NSMutableDictionary* toolBarButtons;
@property (nonatomic, strong) NSMutableDictionary* adjustmentToolViwes;

+ (VnEditorViewManager*)instance;

- (void)layout;
- (void)layoutToolBar;

- (void)registerButton:(VnViewEditorToolBarButton*)button;

@end
