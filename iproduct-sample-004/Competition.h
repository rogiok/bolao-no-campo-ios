//
//  Competition.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Competition : NSObject

@property (nonatomic) NSUInteger cid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;

- (id)initWithId:(NSUInteger)cid name:(NSString *)name imageUrl:(NSString *)imageUrl;

@end
