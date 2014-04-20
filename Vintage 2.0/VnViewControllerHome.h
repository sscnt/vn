//
//  ViewController.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIHomeBgView.h"
#import "UIHomeSourceButton.h"
#import "VnViewControllerEditor.h"

@interface VnViewControllerHome : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIHomeBgView* _bgView;
    UIHomeBgView* _splashView;
    UIHomeSourceButton* _photosButton;
    UIHomeSourceButton* _cameraButton;
}

- (void)didPressButton:(UIHomeSourceButton*)sender;

- (void)didPressCameraButton;
- (void)didPressPhotosButton;

- (void)showErrorAlertWithMessage:(NSString*)message;

- (void)goToEditorViewControllerWithImage:(UIImage*)image;

@end