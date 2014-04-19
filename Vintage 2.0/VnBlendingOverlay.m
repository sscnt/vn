//
//  VnBlendingOverlay.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingOverlay.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kVnBlendingOverlayFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 base = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     mediump float ra;
     if(base.r < 0.5){
         ra = (base.r * overlay.r * 2.0) * overlay.a + (1.0 - overlay.a) * base.r;
     } else{
         ra = (2.0 * (base.r + overlay.r - base.r * overlay.r) - 1.0) * overlay.a + (1.0 - overlay.a) * base.r;
     }
     mediump float ga;
     if(base.g < 0.5){
         ga = (base.g * overlay.g * 2.0) * overlay.a + (1.0 - overlay.a) * base.g;
     } else{
         ga = (2.0 * (base.g + overlay.g - base.g * overlay.g) - 1.0) * overlay.a + (1.0 - overlay.a) * base.g;
     }
     mediump float ba;
     if(base.b < 0.5){
         ba = (base.b * overlay.b * 2.0) * overlay.a + (1.0 - overlay.a) * base.b;
     } else{
         ba = (2.0 * (base.b + overlay.b - base.b * overlay.b) - 1.0) * overlay.a + (1.0 - overlay.a) * base.b;
     }
     
     gl_FragColor = vec4(ra, ga, ba, 1.0);
 }
 );
#else
NSString *const kVnBlendingOverlayFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 varying vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec4 base = texture2D(inputImageTexture, textureCoordinate);
     vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     float ra;
     if(base.r < 0.5){
         ra = (base.r * overlay.r * 2.0) * overlay.a + (1.0 - overlay.a) * base.r;
     } else{
         ra = (2.0 * (base.r + overlay.r - base.r * overlay.r) - 1.0) * overlay.a + (1.0 - overlay.a) * base.r;
     }
     float ga;
     if(base.g < 0.5){
         ga = (base.g * overlay.g * 2.0) * overlay.a + (1.0 - overlay.a) * base.g;
     } else{
         ga = (2.0 * (base.g + overlay.g - base.g * overlay.g) - 1.0) * overlay.a + (1.0 - overlay.a) * base.g;
     }
     float ba;
     if(base.b < 0.5){
         ba = (base.b * overlay.b * 2.0) * overlay.a + (1.0 - overlay.a) * base.b;
     } else{
         ba = (2.0 * (base.b + overlay.b - base.b * overlay.b) - 1.0) * overlay.a + (1.0 - overlay.a) * base.b;
     }
     
     gl_FragColor = vec4(ra, ga, ba, 1.0);
 }
 );
#endif


@implementation VnBlendingOverlay

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingOverlayFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}


@end
