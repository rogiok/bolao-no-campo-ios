//
//  MainViewController.h
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITableViewController <UITextFieldDelegate,NSURLConnectionDataDelegate, NSURLConnectionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

- (IBAction)logout:(UIStoryboardSegue *)segue;

@end
