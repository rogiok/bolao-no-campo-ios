//
//  CompetitionViewController.m
//  iproduct-sample-004
//
//  Created by Rogerio on 6/26/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import "CompetitionViewController.h"
#import "Competition.h"
#import "EventsViewController.h"

@interface CompetitionViewController ()

@end

@implementation CompetitionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    EventsViewController *eventsViewController = (EventsViewController *)[self.viewControllers objectAtIndex:0];
    
    eventsViewController.competition = self.competition;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setCompetition:(Competition *)competition {
//    if (_competition != competition)
//        _competition = competition;
//}

@end
