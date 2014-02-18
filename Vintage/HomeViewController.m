//
//  ViewController.m
//  Vintage
//
//  Created by SSC on 2014/02/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //// Background Image
    UIImage* imageBg;
    if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
        imageBg = [UIImage imageNamed:@"home.jpg"];
    }else if([UIDevice resolution] == UIDeviceResolution_iPhoneRetina5){
        imageBg = [UIImage imageNamed:@"home-568h.jpg"];
    }
    bgImageView = [[UIImageView alloc] initWithImage:imageBg];
    [self.view addSubview:bgImageView];
    
    //// Action Button
    CGFloat top = [UIScreen screenSize].height - 160+.0f;
    buttonCamera = [[UIBlurredButton alloc] initWithFrame:CGRectMake(15.0f, top, [UIScreen screenSize].width - 30.0f, 50.0) Type:BlurredButtonIconTypeCamera];
    buttonCamera.tag = UIBlurredButtonIdCamera;
    [buttonCamera setTitle:NSLocalizedString(@"CAMERA", nil) forState:UIControlStateNormal];
    [buttonCamera addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    buttonCamera.delegate = self;
    [self.view addSubview:buttonCamera];
    
    top = buttonCamera.bottom + 15.0f;
    buttonPhotos = [[UIBlurredButton alloc] initWithFrame:CGRectMake(15.0f, top, [UIScreen screenSize].width - 30.0f, 50.0) Type:BlurredButtonIconTypePhotos];
    buttonPhotos.tag = UIBlurredButtonIdPhotos;
    [buttonPhotos setTitle:NSLocalizedString(@"PHOTOS", nil) forState:UIControlStateNormal];
    [buttonPhotos addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    buttonPhotos.delegate = self;
    [self.view addSubview:buttonPhotos];
    
    //// Splash
    UIImage* imageSplash;
    if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
        imageSplash = [UIImage imageNamed:@"splash.png"];
    }else if([UIDevice resolution] == UIDeviceResolution_iPhoneRetina5){
        imageSplash = [UIImage imageNamed:@"splash-568h.png"];
    }
    splashImageView = [[UIImageView alloc] initWithImage:imageSplash];
    [self.view addSubview:splashImageView];

    
    //// Gaussian Blur
    [self generateBlurredImage];
    

    
}

- (void)generateBlurredImage
{
    UIImage* imageCaptured;
    
    //// Camera
    imageCaptured = [bgImageView imageByRenderingViewWithRect:buttonCamera.frame];
    [buttonCamera generateBackgroundImageByCaputuredImage:imageCaptured];
}

#pragma mark alert

- (void)showErrorAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                    message:NSLocalizedString(message, nil)
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}


#pragma mark button events

- (void)didPressButton:(UIBlurredButton *)sender
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f){;
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusNotDetermined){
            
        } else if (status == ALAuthorizationStatusRestricted){
            [self showErrorAlertWithMessage:@"no_access_due_to_parental_controls"];
            return;
        } else if (status == ALAuthorizationStatusDenied){
            [self showErrorAlertWithMessage:@"no_access_to_your_photos"];
            return;
        } else if (status == ALAuthorizationStatusAuthorized){
            
        }
    }
    
    switch (sender.tag) {
        case UIBlurredButtonIdCamera:
            [self didPressCameraButton];
            break;
        case UIBlurredButtonIdPhotos:
            [self didPressPhotosButton];
            break;
    }
}

- (void)didPressCameraButton
{
    BOOL isCameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if(!isCameraAvailable){
        [self showErrorAlertWithMessage:@"Camera is not available."];
        return;
    }    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    pickerController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)didPressPhotosButton
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    pickerController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:pickerController animated:YES completion:nil];
}


#pragma mark delegates

- (void)buttonDidCreateBgImage:(UIBlurredButton *)button
{
    if (button.tag == UIBlurredButtonIdCamera) {
        //// Photos
        UIImage* imageCaptured = [bgImageView imageByRenderingViewWithRect:buttonPhotos.frame];
        [buttonPhotos generateBackgroundImageByCaputuredImage:imageCaptured];
        return;
    }
    if (button.tag == UIBlurredButtonIdPhotos) {
        splashImageView.alpha = 1.0f;
        [UIView animateWithDuration:0.30f animations:^{
            splashImageView.alpha = 0.0f;
        } completion:^(BOOL finished){
            [splashImageView removeFromSuperview];
            splashImageView = nil;
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(imageOriginal){
        if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
            UIImageWriteToSavedPhotosAlbum(imageOriginal, nil, nil, nil);
        }
        [self goToEffectsViewControllerWithImage:imageOriginal];
    } else {
        __weak HomeViewController* _self = self;
        NSURL* imageurl = [info objectForKey:UIImagePickerControllerReferenceURL];
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:imageurl
                 resultBlock: ^(ALAsset *asset)
         {
             ALAssetRepresentation *representation;
             representation = [asset defaultRepresentation];
             UIImage* imageOriginal = [[UIImage alloc] initWithCGImage:representation.fullResolutionImage];
             [_self goToEffectsViewControllerWithImage:imageOriginal];
         }
                failureBlock:^(NSError *error)
         {
         }
         ];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}


- (void)goToEffectsViewControllerWithImage:(UIImage *)image
{
    SelectionViewController* controller = [[SelectionViewController alloc] initWithImage:image];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:controller animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
