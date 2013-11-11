//
//  UmpayInstance.m
//  UmpaySDK-Iphone
//
//  Created by haijun wang on 12-7-6.
//  Copyright (c) 2012年 Umpay. All rights reserved.
//

#import "SharedInstance.h"

@implementation SharedInstance

@synthesize ggid,mobileId;

static SharedInstance* _instance;

+ (SharedInstance*)instance{
    
    if (_instance == nil) {
        _instance = [[SharedInstance alloc] init];
    }
    
    return _instance;

}

@end
