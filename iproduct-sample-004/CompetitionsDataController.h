//
//  CompetitionsDataController.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Competition;

@interface CompetitionsDataController : NSObject

@property (nonatomic, copy) NSMutableArray *competitions;

- (NSUInteger)count;
- (Competition *)get:(NSUInteger)index;
- (void)add:(Competition *)competition;

@end
