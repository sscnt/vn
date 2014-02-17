//
//  UIEditorSliderView.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISliderView.h"

@class UIEditorSliderView;

@protocol UIEditorSliderViewDelegate
- (void)slider:(UIEditorSliderView*)slider DidValueChange:(CGFloat)value;
- (void)touchesBeganWithSlider:(UIEditorSliderView*)slider;
- (void)touchesEndedWithSlider:(UIEditorSliderView*)slider;
@end

typedef NS_ENUM(NSInteger, EditorSliderIconType){
    EditorSliderIconTypeOpacity = 1
};

@interface UIEditorSliderView : UIView <UISliderViewDelegate>
{
    UISliderView* _slider;
    UIImageView* _iconImageView;
}

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, weak) id<UIEditorSliderViewDelegate> delegate;
@property (nonatomic, assign) EditorSliderIconType iconType;
@property (nonatomic, strong) NSString* title;

@end
