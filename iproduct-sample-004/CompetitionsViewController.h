//
//  CompetiitionsViewController.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CompetitionsDataController;

@interface CompetitionsViewController : UITableViewController

@property (strong, nonatomic) CompetitionsDataController *dataController;

@end
