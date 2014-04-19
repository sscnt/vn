//
//  VnBlendingDifference.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingDifference.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kVnBlendingDifferenceFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 textureColor2 = texture2D(inputImageTexture2, textureCoordinate2);
     mediump vec4 result = vec4(abs((textureColor2.rgb - textureColor.rgb) * textureColor2.a) + textureColor.rgb * (1.0 - textureColor2.a), textureColor.a);
     gl_FragColor = vec4(result.rgb * textureColor2.a + textureColor.rgb * (1.0 - textureColor2.a), textureColor.a);
 }
 );
#else
NSString *const kVnBlendingDifferenceFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 varying vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     vec4 textureColor2 = texture2D(inputImageTexture2, textureCoordinate2);
     vec4 result = vec4(abs((textureColor2.rgb - textureColor.rgb) * textureColor2.a) + textureColor.rgb * (1.0 - textureColor2.a), textureColor.a);
     gl_FragColor = vec4(result.rgb * textureColor2.a + textureColor.rgb * (1.0 - textureColor2.a), textureColor.a);
 }
 );
#endif

@implementation VnBlendingDifference

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingDifferenceFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
