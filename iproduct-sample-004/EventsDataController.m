//
//  EventsDataController.m
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import "EventsDataController.h"
#import "Event.h"
#import "Competitor.h"

@interface EventsDataController()

- (void)loadData;

@end

@implementation EventsDataController

- (id)init {
    if (self = [super init]) {
        [self loadData];
        
        return self;
    }
    
    return nil;
}

- (void)loadData {
    
    self.events = [[NSMutableArray alloc] init];
    
//    Competitor *competitor1 = [[Competitor alloc] initWithId:100 name:@"Brasil" imageUrl:@"http://e.imguol.com/futebol/brasoes/40x40/brasil.png"];
//    Competitor *competitor2 = [[Competitor alloc] initWithId:200 name:@"Espanha" imageUrl:@"http://e.imguol.com/futebol/brasoes/40x40/espanha.png"];
    
//    Event *event = [[Event alloc] initWithId:123 location:@"São Paulo" date:[NSDate date] competitor1:competitor1 competitor2:competitor2];
    
//    [self add:event];
}

- (NSUInteger)count {
    return [self.events count];
}

- (Event *)get:(NSUInteger)index {
    return [self.events objectAtIndex:index];
}

- (void)add:(Event *)event {
    
    NSMutableArray *newList = [self.events mutableCopy];
    
    [newList addObject:event];
    
    self.events = newList;
}

@end
