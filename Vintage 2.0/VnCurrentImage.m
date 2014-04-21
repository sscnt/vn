//
//  CurrentImage.m
//  Vintage
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnCurrentImage.h"

@implementation VnCurrentImage

static VnCurrentImage* sharedCurrentImage = nil;
NSString* const pathForOriginalImage = @"tmp/original_image";
NSString* const pathForEditorImage = @"tmp/editor_image";
NSString* const pathForEditorBlurredImage = @"tmp/editor_blurred_image";
NSString* const pathForEditorProcessedImage = @"tmp/editor_processed_image";
NSString* const pathForLastSavedImage = @"tmp/last_saved_image";
NSString* const pathForDialogBgImage = @"tmp/dialog_bg_image";

+ (VnCurrentImage*)instance {
	@synchronized(self) {
		if (sharedCurrentImage == nil) {
			sharedCurrentImage = [[self alloc] init];
		}
	}
	return sharedCurrentImage;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedCurrentImage == nil) {
			sharedCurrentImage = [super allocWithZone:zone];
			return sharedCurrentImage;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

+ (UIImage*)imageAtPath:(NSString *)path
{
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if( [filemgr fileExistsAtPath:path] ){
        NSData *data = [NSData dataWithContentsOfURL:fileURL];
        UIImage *img = [[UIImage alloc] initWithData:data];
        return img;
    }
    
    return nil;
}

+ (UIImage*)resizedImageForEditor
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForEditorImage];
    return [self imageAtPath:filePath];
}

+ (UIImage*)originalImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    return [self imageAtPath:filePath];
}

+ (UIImage*)lastSavedImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForLastSavedImage];
    return [self imageAtPath:filePath];
}

+ (UIImage*)dialogBgImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForDialogBgImage];
    return [self imageAtPath:filePath];
}

+ (UIImage *)resizedBlurredImageForEditor
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForEditorBlurredImage];
    return [self imageAtPath:filePath];
}

+ (UIImage *)resizedProcessedImageForEditor
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForEditorProcessedImage];
    return [self imageAtPath:filePath];
}

+ (BOOL)saveOriginalImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveResizedEditorImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForEditorImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveLastSavedImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForLastSavedImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveDialogBgImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForDialogBgImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveResizedBlurredEditorImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForEditorBlurredImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveResizedProcessedEditorImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForEditorProcessedImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (CGSize)originalImageSize
{
    return [self instance].originalImageSize;
}

+ (CGSize)editorImageSize
{
    CGSize size = [VnCurrentImage editorImageViewSize];
    return CGSizeMake(size.width * [[UIScreen mainScreen] scale], size.height * [[UIScreen mainScreen] scale]);
}

+ (CGSize)editorImageViewSize
{
    CGRect bounds = [VnEditorViewManager previewBounds];
    CGSize originalImageSize = [VnCurrentImage originalImageSize];
    float width, height;
    if (originalImageSize.width > originalImageSize.height) {
        height = bounds.size.height;
        width = originalImageSize.width * height / originalImageSize.height;
    } else {
        width = bounds.size.width;
        height = originalImageSize.height * width / originalImageSize.width;
    }
    return CGSizeMake(width, height);
}

+ (BOOL)lastSavedImageExists
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForLastSavedImage];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if( [filemgr fileExistsAtPath:filePath] ){
        return YES;
    }
    return NO;
}

+ (BOOL)originalImageExists
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if([filemgr fileExistsAtPath:filePath]){
        return YES;
    }
    return NO;
}

+ (BOOL)deleteImageAtPath:(NSString *)path
{
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSURL *pathurl = [NSURL fileURLWithPath:path];
    
    if( [filemgr fileExistsAtPath:path] ){
        LOG(@"deleting the image at %@" ,path);
        return [filemgr removeItemAtURL:pathurl error:nil];
    }
    return YES;
}

+ (BOOL)deleteLastSavedImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForLastSavedImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteOriginalImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteResizedForEditorImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForEditorImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteDialogBgImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForDialogBgImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteResizedBlurredForEditorImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForEditorBlurredImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteResizedProcessedForEditorImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForEditorProcessedImage];
    return [self deleteImageAtPath:filePath];
}

+ (void)clean
{
    [VnCurrentImage deleteResizedForEditorImage];
    [VnCurrentImage deleteOriginalImage];
    [VnCurrentImage deleteLastSavedImage];
    [VnCurrentImage deleteDialogBgImage];
    [VnCurrentImage deleteResizedBlurredForEditorImage];
    [VnCurrentImage deleteResizedProcessedForEditorImage];
}

@end
