//
//  VnViewEditorToolBarButton.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VnViewEditorToolBarButton;

@protocol VnViewEditorToolBarButtonDelegate
- (void)didToolBarButtonTouchUpInside:(VnViewEditorToolBarButton*)button;
@end


typedef NS_ENUM(NSInteger, VnViewEditorToolBarButtonType){
    VnViewEditorToolBarButtonTypeEffect = 1
};

@interface VnViewEditorToolBarButton : UIButton

@property (nonatomic, assign) VnViewEditorToolBarButtonType type;
@property (nonatomic, strong) NSMutableArray* childButtons;
@property (nonatomic, weak) id<VnViewEditorToolBarButtonDelegate> delegate;

- (void)didTouchUpInside;

@end
