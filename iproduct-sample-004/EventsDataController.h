//
//  EventsDataController.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Event;

@interface EventsDataController : NSObject

@property (nonatomic, copy) NSMutableArray *events;

- (NSUInteger)count;
- (Event *)get:(NSUInteger)index;
- (void)add:(Event *)event;

@end
