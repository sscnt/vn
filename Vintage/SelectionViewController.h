//
//  EffectsViewController.h
//  Vintage
//
//  Created by SSC on 2014/02/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISelectionPreviewImageView.h"
#import "GPUImageEffectsImport.h"
#import "EditorViewController.h"
#import "UINavigationBarView.h"
#import "UICloseButton.h"
#import "CurrentImage.h"

@interface SelectionViewController : UIViewController <UINavigationControllerDelegate>
{
    BOOL _paused;
    BOOL _isProcessing;
    BOOL _forceRestart;
    BOOL _viewDidOnceAppear;
    int _currentProcessingIndex;
    int _numberOfEffects;
    NSMutableArray* _arrayPreviews;
    NSMutableArray* _arrayEffects;
    UIScrollView* _scrollView;
    __weak EditorViewController* _editorViewController;
}

@property (nonatomic, assign) BOOL faceDetected;
@property (nonatomic, strong) UIImage* imageResized;

- (void)startApplying;
- (void)applyEffectAtIndex:(int)index;

- (void)didSelectPreview:(UISelectionPreviewImageView*)preview;
- (void)didPressCloseButton;

- (void)reset;

@end
