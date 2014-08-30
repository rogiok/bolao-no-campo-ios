//
//  Session.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/27/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

@property (nonatomic, copy) NSString *sessionToken;

+ (id)sharedInstance;

@end
