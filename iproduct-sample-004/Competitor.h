//
//  Competitor.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Competitor : NSObject

@property (nonatomic) NSUInteger cid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;

- (id)initWithId:(NSUInteger)pId name:(NSString *)pName imageUrl:(NSString *)pImageUrl;

@end
