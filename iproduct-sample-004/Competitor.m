//
//  Competitor.m
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import "Competitor.h"

@implementation Competitor

- (id)initWithId:(NSUInteger)pId name:(NSString *)pName imageUrl:(NSString *)pImageUrl {
    self = [super init];
    
    _cid = pId;
    _name = pName;
    _imageUrl = pImageUrl;
    
    return self;
}
@end
