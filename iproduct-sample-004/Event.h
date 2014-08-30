//
//  Event.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Competitor;

@interface Event : NSObject

@property (nonatomic) NSUInteger cid;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) Competitor *competitor1;
@property (nonatomic, strong) Competitor *competitor2;
@property (nonatomic) NSUInteger score1;
@property (nonatomic) NSUInteger score2;

- (id)initWithId:(NSUInteger)pId location:(NSString *)pLocation date:(NSString *)pDate competitor1:(Competitor *)pCompetitor1 competitor2:(Competitor *)pCompetitor2;

@end
