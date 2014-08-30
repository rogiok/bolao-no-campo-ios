//
//  MainViewController.m
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "Session.h"

@interface MainViewController() {
    BOOL editMode;
    NSMutableData *receiveData;
//    NSOperationQueue *operationQueue;
}

- (void)resizeTable;
- (void)startLoadingAnimation;

@end

@implementation MainViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    editMode = NO;
    
    // Settings for rounded corners's button
    self.sendButton.layer.cornerRadius = 8;
    self.sendButton.clipsToBounds = YES;
    
//    operationQueue = [[NSOperationQueue alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat result = 0;
    
    if (indexPath.row == 0) {
        if (editMode)
            result = 50;
        else
            result = 200;
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        result = 40;
    } else if (indexPath.row == 3) {
        result = 100;
    }
    
    return result;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ((textField == self.usernameText || textField == self.passwordText) && editMode == NO) {
        editMode = YES;

        [self resizeTable];
    }
}

// Treatment for return key in keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if (theTextField == self.usernameText) {
        [self.passwordText becomeFirstResponder];
        
    } else if (theTextField == self.passwordText) {

        // Hide the keyboard
        [theTextField resignFirstResponder];
        
        editMode = NO;
        
        [self resizeTable];
        
        [self login:nil];
    }
    
    return YES;
}

- (IBAction)login:(id)sender {

//    NSInvocationOperation *startAnimation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(startLoadingAnimation) object:nil];
//    [operationQueue addOperation:startAnimation];
    
    NSLog(@"login...");
    
    [NSThread detachNewThreadSelector:@selector(startLoading) toTarget:self withObject:nil];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://acesso.uol.com.br/login.html?skin=forum-esporte"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSString *data = [[[[@"user=" stringByAppendingString:self.usernameText.text] stringByAppendingString:@"&pass="] stringByAppendingString:self.passwordText.text] stringByAppendingString:@"&skin=babelconteudo&dest=REDIR|http%3A%2F%2Fservice.bolao.esporte.uol.com.br%2Fsystem%2Fservice%2Fsession%2Fauthenticate%3Faccept%3Dapplication%2Fjson%26_=phn"];

    [request setHTTPBody:[NSMutableData dataWithBytes:[data UTF8String] length:data.length]];
    [request setHTTPMethod:@"POST"];

    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn) {
        receiveData = [[NSMutableData alloc] init];
        
        NSLog(@"Connected");
    } else {
        NSLog(@"Error");
    }
    
    // To cancel a connection
    //    [conn cancel];

//    [NSThread sleepForTimeInterval:15];
    
}

- (void)startLoading {
    @autoreleasepool {
        [self.progressIndicator startAnimating];
        
        self.errorLabel.hidden = YES;
    }
}

- (void)resizeTable {
    NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
    
    NSArray *paths = [NSArray arrayWithObject:firstRow];
    
    [self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    NSLog(@"Response %d", [httpResponse statusCode]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"Receive: %d", [data length]);
    
    [receiveData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // ARC does not permit explicit release, so comment it
//    [connection release];
    
    [self.progressIndicator stopAnimating];
    self.errorLabel.hidden = NO;
    
    NSLog(@"Fail %i", error.code);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // ARC does not permit explicit release, so comment it
//    [connection release];
    
    unsigned char content[receiveData.length];
    
    [receiveData getBytes:content length:receiveData.length];
    

    NSString *data = [[NSString alloc] initWithBytes:content length:receiveData.length encoding:NSUTF8StringEncoding];

    NSLog(@"data: %d", [receiveData length]);
    NSLog(@"content: %@", data);
    NSLog(@"position: %d", [data rangeOfString:@"tk_bl"].location);

    if (data == nil || [data rangeOfString:@"tk_bl"].location == NSNotFound) {
        [self.progressIndicator stopAnimating];
        self.errorLabel.hidden = NO;
    } else {
        
        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingMutableLeaves error:&error];
        
        //    for (id key in json) {
        //        id value = [json objectForKey:key];
        //
        //        NSString *keyAsString = (NSString *)key;
        //        NSString *valueAsString = (NSString *)value;
        //
        //        NSLog(@"key: %@", keyAsString);
        //        NSLog(@"value: %@", valueAsString);
        //    }
        
        NSArray *messages = [json objectForKey:@"message"];
        
        for (NSDictionary *message in messages) {
            NSString *token = (NSString *)[message objectForKey:@"tk_bl"];
            
            Session *session = [Session sharedInstance];
            
            session.sessionToken = token;
            
            NSLog(@"token: %@", token);
        }

        [self performSegueWithIdentifier:@"ShowCompetitions" sender:self];
    }
    
    NSLog(@"Finish");
}

- (IBAction)logout:(UIStoryboardSegue *)segue {
    
    [self.progressIndicator stopAnimating];
    self.usernameText.text = @"";
    self.passwordText.text = @"";
    
}


//- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL {
//    NSLog(@"Finish Download");
//}

@end
