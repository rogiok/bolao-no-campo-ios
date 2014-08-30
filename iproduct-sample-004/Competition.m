//
//  Competition.m
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import "Competition.h"

@implementation Competition

- (id)initWithId:(NSUInteger)cid name:(NSString *)name imageUrl:(NSString *)pImageUrl {
    self = [self init];
    
    _cid = cid;
    _name = name;
    _imageUrl = pImageUrl;
    
    return self;
}

@end
