//
//  VnViewEditorToolBarButton.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VnViewEditorToolBarButtonBgView.h"

@class VnViewEditorToolBarButton;

@protocol VnViewEditorToolBarButtonDelegate
- (void)didToolBarButtonTouchUpInside:(VnViewEditorToolBarButton*)button;
@end

@interface VnViewEditorToolBarButton : UIButton

@property (nonatomic, assign) VnAdjustmentToolId toolId;
@property (nonatomic, strong) NSMutableArray* childButtons;
@property (nonatomic, weak) id<VnViewEditorToolBarButtonDelegate> delegate;
@property (nonatomic, assign) BOOL colored;
@property (nonatomic, assign) BOOL childButtonsHidden;
@property (nonatomic, assign) BOOL isChild;
@property (nonatomic, strong) VnViewEditorToolBarButtonBgView* view;
@property (nonatomic, assign) int stage;

- (void)didTouchUpInside:(VnViewEditorToolBarButton*)sender;
- (void)addChildButton:(VnViewEditorToolBarButton*)button;
- (int)childButtonsCount;
- (void)layoutChildButtons;

@end
