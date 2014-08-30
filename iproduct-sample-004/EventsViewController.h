//
//  EventsViewController.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventsDataController;
@class Competition;

@interface EventsViewController : UITableViewController <NSURLConnectionDataDelegate, NSURLConnectionDownloadDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, UITextFieldDelegate>

@property (nonatomic, strong) EventsDataController *dataController;
@property (nonatomic, strong) Competition *competition;

- (void)setCompetition:(Competition *)competition;

@end
