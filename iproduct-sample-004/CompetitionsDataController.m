//
//  CompetitionsDataController.m
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import "CompetitionsDataController.h"
#import "Competition.h"

@interface CompetitionsDataController()

- (void)loadData;

@end

@implementation CompetitionsDataController

- (id)init {
    if (self = [super init]) {
        [self loadData];
        
        return self;
    }
    
    return nil;
}

- (void)loadData {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    self.competitions = list;
    
    Competition *competition = [[Competition alloc] initWithId:367 name:@"Copa das Confederações" imageUrl:@"http://bolao.imguol.com/skins/basic/selos/367.png"];
    
    [self add:competition];
}

- (NSUInteger)count {
    return [self.competitions count];
}

- (Competition *)get:(NSUInteger)index {
    return [self.competitions objectAtIndex:index];
}

- (void)add:(Competition *)competition {
    
    NSMutableArray *newList = [self.competitions mutableCopy];

    [newList addObject:competition];
    
    self.competitions = newList;
}

@end
