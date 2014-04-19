//
//  VnBlendingScreen.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingScreen.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kVnBlendingScreenFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 base = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     base.r = (1.0 - ((1.0 - base.r) * (1.0 - overlay.r))) * overlay.a + base.r * (1.0 - overlay.a);
     base.g = (1.0 - ((1.0 - base.g) * (1.0 - overlay.g))) * overlay.a + base.g * (1.0 - overlay.a);
     base.b = (1.0 - ((1.0 - base.b) * (1.0 - overlay.b))) * overlay.a + base.b * (1.0 - overlay.a);
     gl_FragColor = base;
 }
 );
#else
NSString *const kVnBlendingScreenFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 varying vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec4 base = texture2D(inputImageTexture, textureCoordinate);
     vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     base.r = (1.0 - ((1.0 - base.r) * (1.0 - overlay.r))) * overlay.a + base.r * (1.0 - overlay.a);
     base.g = (1.0 - ((1.0 - base.g) * (1.0 - overlay.g))) * overlay.a + base.g * (1.0 - overlay.a);
     base.b = (1.0 - ((1.0 - base.b) * (1.0 - overlay.b))) * overlay.a + base.b * (1.0 - overlay.a);
     gl_FragColor = base;
 }
 );
#endif

@implementation VnBlendingScreen

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingScreenFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
