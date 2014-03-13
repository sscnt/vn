//
//  UISaveToVIew.h
//  Vintage
//
//  Created by SSC on 2014/03/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISaveToButton.h"

typedef NS_ENUM(NSInteger, SaveTo){
    SaveToCameraRoll = 1,
    SaveToTwitter,
    SaveToInstagram,
    SaveToFacebook
};

@class UISaveToView;

@protocol UISaveToViewDelegate
- (void)saveToView:(UISaveToView*)view DidSelectSaveTo:(SaveTo)saveTo;
@end


@interface UISaveToView : UIView
{
    UISaveToButton* _buttonCameraRoll;
}

@property (nonatomic, assign) id<UISaveToViewDelegate> delegate;

- (void)didPressButton:(UISaveToButton*)button;
- (void)clearSelected;

@end
