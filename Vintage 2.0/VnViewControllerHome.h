//
//  ViewController.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "VnViewHomeBg.h"
#import "VnButtonHomeSource.h"
#import "VnViewControllerEditor.h"

@interface VnViewControllerHome : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    VnViewHomeBg* _bgView;
    VnViewHomeBg* _splashView;
    VnButtonHomeSource* _photosButton;
    VnButtonHomeSource* _cameraButton;
}

- (void)didPressButton:(VnButtonHomeSource*)sender;

- (void)didPressCameraButton;
- (void)didPressPhotosButton;

- (void)showErrorAlertWithMessage:(NSString*)message;

- (void)goToEditorViewControllerWithImage:(UIImage*)image;

@end