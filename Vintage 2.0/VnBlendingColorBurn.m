//
//  VnBlendingColorBurn.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingColorBurn.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kVnBlendingColorBurnFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 textureColor2 = texture2D(inputImageTexture2, textureCoordinate2);
     mediump vec4 whiteColor = vec4(1.0);
     mediump vec4 rgba = whiteColor - (whiteColor - textureColor) / textureColor2;
     gl_FragColor = vec4(rgba.rgb * textureColor2.a + textureColor.rgb * (1.0 - textureColor2.a), 1.0);
 }
 );
#else
NSString *const kVnBlendingColorBurnFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 varying vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     vec4 textureColor2 = texture2D(inputImageTexture2, textureCoordinate2);
     vec4 whiteColor = vec4(1.0);
     vec4 rgba = whiteColor - (whiteColor - textureColor) / textureColor2;
     gl_FragColor = vec4(rgba.rgb * textureColor2.a + textureColor.rgb * (1.0 - textureColor2.a), 1.0);
 }
 );
#endif

@implementation VnBlendingColorBurn

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingColorBurnFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
