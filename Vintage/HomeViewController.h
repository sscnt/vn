//
//  ViewController.h
//  Vintage
//
//  Created by SSC on 2014/02/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "GPUImage.h"
#import "UIBlurredButton.h"
#import "SelectionViewController.h"
#import "UIImagePickerController+extend.h"

typedef NS_ENUM(NSInteger, UIBlurredButtonId){
    UIBlurredButtonIdCamera = 1,
    UIBlurredButtonIdPhotos
};

@interface HomeViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIBlurredButton* buttonCamera;
    UIBlurredButton* buttonPhotos;
}

- (void)generateBlurredImage;

- (void)didPressButton:(UIBlurredButton*)sender;
- (void)didPressCameraButton;
- (void)didPressPhotosButton;
- (void)showErrorAlertWithMessage:(NSString*)message;

- (void)goToEffectsViewControllerWithImage:(UIImage*)image;

@end
