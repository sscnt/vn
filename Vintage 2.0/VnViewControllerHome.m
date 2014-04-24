//
//  ViewController.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewControllerHome.h"

@interface VnViewControllerHome ()

@end

@implementation VnViewControllerHome

- (void)viewDidAppear:(BOOL)animated
{
    LOG(@"Cleaned images.");
    [VnCurrentImage clean];
    [VnEditorViewManager clean];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize screenSize = [UIScreen screenSize];
    
    //// Background Image
    _bgView = [[VnViewHomeBg alloc] initWithFrame:self.view.bounds];
    _bgView.type = VnViewHomeBgTypeGeneral;
    [self.view addSubview:_bgView];
    
    //// Button
    CGFloat x = (screenSize.width - 240.0f) / 2.0f;
    CGFloat padding = (screenSize.height - 568.0f) / 2.0f + 176.0f;

    CGFloat buttonDiam = 100.0f;
    _photosButton = [[VnButtonHomeSource alloc] initWithFrame:CGRectMake(x, [UIScreen height] - padding, buttonDiam, buttonDiam)];
    _photosButton.iconType = VnButtonHomeSourceIconTypePhotos;
    [_photosButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_photosButton];
    _cameraButton = [[VnButtonHomeSource alloc] initWithFrame:CGRectMake([_photosButton right] + 40.0f, [UIScreen height] - padding, buttonDiam, buttonDiam)];
    _cameraButton.iconType = VnButtonHomeSourceIconTypeCamera;
    [_cameraButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cameraButton];
    
    
    //// Splash Image
    _splashView = [[VnViewHomeBg alloc] initWithFrame:self.view.bounds];
    _splashView.type = VnViewHomeBgTypeSplash;
    [self.view addSubview:_splashView];;
    
    
    //// Animate
    __block VnViewHomeBg* _s = _splashView;
    [UIView animateWithDuration:0.30f delay:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        _s.alpha = 0.0f;
    } completion:^(BOOL finished){
        [_s removeFromSuperview];
        _s = nil;
    }];

}


#pragma mark button events

- (void)didPressButton:(VnButtonHomeSource *)sender
{
    
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
    
    switch (sender.iconType) {
        case VnButtonHomeSourceIconTypeCamera:
            [self didPressCameraButton];
            break;
        case VnButtonHomeSourceIconTypePhotos:
            [self didPressPhotosButton];
            break;
        default:
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


#pragma mark  delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(imageOriginal){
        if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
            UIImageWriteToSavedPhotosAlbum(imageOriginal, nil, nil, nil);
        }
        [self goToEditorViewControllerWithImage:imageOriginal];
    } else {
        __weak VnViewControllerHome* _self = self;
        NSURL* imageurl = [info objectForKey:UIImagePickerControllerReferenceURL];
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:imageurl
                 resultBlock: ^(ALAsset *asset)
         {
             ALAssetRepresentation *representation;
             representation = [asset defaultRepresentation];
             UIImage* imageOriginal = [[UIImage alloc] initWithCGImage:representation.fullResolutionImage];
             [_self goToEditorViewControllerWithImage:imageOriginal];
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


- (void)goToEditorViewControllerWithImage:(UIImage *)image
{
    [VnProcessor reset];
    [VnCurrentImage clean];
    if (image.imageOrientation == UIImageOrientationUp){
        
    }else{
        CGAffineTransform transform = CGAffineTransformIdentity;
        switch (image.imageOrientation) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
                
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.width, 0);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
                
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, 0, image.size.height);
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                break;
            case UIImageOrientationUp:
            case UIImageOrientationUpMirrored:
                break;
        }
        switch (image.imageOrientation) {
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.width, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
                
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.height, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
            case UIImageOrientationUp:
            case UIImageOrientationDown:
            case UIImageOrientationLeft:
            case UIImageOrientationRight:
                break;
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage), 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
        CGContextConcatCTM(ctx, transform);
        switch (image.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                // Grr...
                CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
                break;
                
            default:
                CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
                break;
        }
        
        // And now we just create a new UIImage from the drawing context
        CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
        image = [UIImage imageWithCGImage:cgimg];
        CGContextRelease(ctx);
        CGImageRelease(cgimg);
    }
    
    
    CGFloat maxLength = MAX_IMAGE_LENGTH;
    if([UIDevice isiPad]){
        
    }else{
        UIDeviceMachineType machine = [UIDevice machineType];
        switch (machine) {
            case UIDeviceMachineType_iPhone4:
                maxLength = MAX_IMAGE_LENGTH_FOR_IPHONE_4;
                break;
            case UIDeviceMachineType_iPhone4s:
                maxLength = MAX_IMAGE_LENGTH_FOR_IPHONE_4S;
                break;
            case UIDeviceMachineType_iPhone5:
                maxLength = MAX_IMAGE_LENGTH_FOR_IPHONE_5;
                break;
            case UIDeviceMachineType_iPhone5s:
                maxLength = MAX_IMAGE_LENGTH_FOR_IPHONE_5S;
                break;
            default:
                break;
        }
    }
    
    if(image.size.width > maxLength){
        @autoreleasepool {
            CGFloat height = maxLength / image.size.width * image.size.height;
            image = [image resizedImage:CGSizeMake(maxLength, height) interpolationQuality:kCGInterpolationHigh];
        }
    }
    if(image.size.height > maxLength){
        @autoreleasepool {
            CGFloat width = maxLength / image.size.height * image.size.width;
            image = [image resizedImage:CGSizeMake(width, maxLength) interpolationQuality:kCGInterpolationHigh];
        }
    }
    
    [VnCurrentImage instance].originalImageSize = image.size;
    
    
    //// Present
    __block VnViewControllerHome* _self = self;
    __block VnViewControllerEditor* controller = [[VnViewControllerEditor alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
    __block UIImage* originalImage = image;
    
    __block NSInteger errorCode = 1;
    
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            
            //// Save to home dir
            if([VnCurrentImage saveOriginalImage:originalImage]){
                
                //// Progress
                [_self dispatchResizingProgress:0.20f];
                
                //// for editor image
                UIImage* imageForEditor = [originalImage resizedImage:[VnCurrentImage previewImageSize] interpolationQuality:kCGInterpolationHigh];
                if([VnCurrentImage saveOriginalPreviewImage:imageForEditor]){
                    
                    //// Progress
                    [_self dispatchResizingProgress:0.40f];
                    
                    //// Detect faces
                    NSDictionary *options = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
                    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
                    CIImage *ciImage = [[CIImage alloc] initWithCGImage:imageForEditor.CGImage];
                    NSDictionary *imageOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:CIDetectorImageOrientation];
                    NSArray *array = [detector featuresInImage:ciImage options:imageOptions];
                    
                    if([array count] > 0){
                        LOG(@"Face detected!");
                        [VnProcessor instance].faceDetected = YES;
                    }
                    
                    //// Progress
                    [_self dispatchResizingProgress:0.80f];
                    
                    errorCode = 0;
                }
            }
        }
        dispatch_async(q_main, ^{
            if (errorCode == 0) {
                [controller didFinishResizing];
            }else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Storage is full.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Close", nil) otherButtonTitles:nil];
                [alert show];
            }
        });
    });
}

- (void)dispatchResizingProgress:(float)progress
{
    __block float _progress = progress;
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_main, ^{
        [VnEditorProgressManager setResizingProgress:_progress];
    });
}


#pragma mark Util

- (void)showErrorAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                    message:NSLocalizedString(message, nil)
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
