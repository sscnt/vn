//
//  UISaveToVIew.h
//  Vintage
//
//  Created by SSC on 2014/03/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SaveTo){
    SaveToCameraRoll = 1,
    SaveToTwitter,
    SaveToInstagram,
    SaveToFacebook
};

@class UISaveToDialogView;
@class UISaveToButton;

@protocol UISaveToDialogViewDelegate
- (void)saveToView:(UISaveToDialogView*)view DidSelectSaveTo:(SaveTo)saveTo;
@end


@interface UISaveToDialogView : UIView
{
    UISaveToButton* _buttonCameraRoll;
}

@property (nonatomic, assign) id<UISaveToDialogViewDelegate> delegate;

- (void)didPressButton:(UISaveToButton*)button;
- (void)clearSelected;

@end
