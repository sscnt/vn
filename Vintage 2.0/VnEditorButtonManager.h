//
//  VnEditorButtonManager.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VnViewEditorToolBarButton.h"

@interface VnEditorButtonManager : NSObject <VnViewEditorToolBarButtonDelegate>

+ (VnEditorButtonManager*)instance;

@end
