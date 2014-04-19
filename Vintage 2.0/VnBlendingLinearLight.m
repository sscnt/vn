//
//  VnBlendingLinearLight.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingLinearLight.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kVnBlendingLinearLightFilterFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;

 
 void main()
 {
     mediump vec4 base = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     
     mediump vec3 result = base.rgb + 2.0 * overlay.rgb - 1.0;
     result.r = max(0.0, min(result.r, 1.0));
     result.g = max(0.0, min(result.g, 1.0));
     result.b = max(0.0, min(result.b, 1.0));
     
     gl_FragColor = vec4(result * overlay.a + base.rgb * (1.0 - overlay.a), 1.0);
 }
 );
#else
NSString *const kVnBlendingLinearLightFilterFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec4 base = texture2D(inputImageTexture, textureCoordinate);
     vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     
     vec3 result = base.rgb + 2.0 * overlay.rgb - 1.0;
     result.r = max(0.0, min(result.r, 1.0));
     result.g = max(0.0, min(result.g, 1.0));
     result.b = max(0.0, min(result.b, 1.0));
     
     gl_FragColor = vec4(result * overlay.a + base.rgb * (1.0 - overlay.a), 1.0);
 }
 );
#endif

@implementation VnBlendingLinearLight

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingLinearLightFilterFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
