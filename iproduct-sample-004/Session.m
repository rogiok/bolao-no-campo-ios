//
//  Session.m
//  iproduct-sample-004
//
//  Created by Rogerio on 6/27/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import "Session.h"

@implementation Session

// Using GCD (Grand Central Dispatch)
+ (id)sharedInstance {
    static dispatch_once_t pred = 0;
    
    __strong static id _shareObject = nil;
    
    dispatch_once(&pred, ^{
        _shareObject = [[self alloc] init];
    });
    
    return _shareObject;
}

//+ (id)shareInstance2 {
//    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
//        return [[self alloc] init];
//    });
//}

@end
