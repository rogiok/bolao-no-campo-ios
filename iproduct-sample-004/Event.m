//
//  Event.m
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id)initWithId:(NSUInteger)pid location:(NSString *)pLocation date:(NSString *)pDate competitor1:(Competitor *)pCompetitor1 competitor2:(Competitor *)pCompetitor2 {
    self = [super init];
    
    _cid = pid;
    _location = pLocation;
    _date = pDate;
    _competitor1 = pCompetitor1;
    _competitor2 = pCompetitor2;
    
    return self;
}

@end
