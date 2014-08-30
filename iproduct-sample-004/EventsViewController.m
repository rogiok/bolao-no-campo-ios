//
//  EventsViewController.m
//  iproduct-sample-004
//
//  Created by Rogerio on 6/22/13.
//  Copyright (c) 2013 Rogerio. All rights reserved.
//

#import "HtmlConverter.h"
#import "EventsViewController.h"
#import "EventsDataController.h"
#import "Event.h"
#import "Competitor.h"
#import "Competition.h"
#import "Session.h"

@interface EventsViewController () {
    NSMutableData *receiveData;
    NSMutableArray *points;
    NSUInteger selectedIndex;
    UITextField *currentField;
}

- (void)loadEvents;
- (void)showPicker:(id)sender;

@end

@implementation EventsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = 120;
    
    [self loadEvents];
    
    points = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 100; i++) {
        [points addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
//    points = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dataController = [[EventsDataController alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataController count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Event *event = [self.dataController get:indexPath.row];
    
    UIImageView *competitor1Image = (UIImageView *)[cell viewWithTag:1];
    NSURL *url1 = [NSURL URLWithString:event.competitor1.imageUrl];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    competitor1Image.image = [[UIImage alloc] initWithData:data1];
    
    UILabel *competitor1Name = (UILabel *)[cell viewWithTag:3];
    competitor1Name.text = event.competitor1.name;
    
    UIImageView *competitor2Image = (UIImageView *)[cell viewWithTag:2];
    NSURL *url2 = [NSURL URLWithString:event.competitor2.imageUrl];
    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    competitor2Image.image = [[UIImage alloc] initWithData:data2];

    UILabel *competition1Name = (UILabel *)[cell viewWithTag:4];
    competition1Name.text = event.competitor2.name;

    UILabel *location = (UILabel *)[cell viewWithTag:5];
    location.text = event.location;

    UILabel *date = (UILabel *)[cell viewWithTag:6];
    date.text = event.date;
    
    UITextField *score1 = (UITextField *)[cell viewWithTag:7];
    score1.text = [NSString stringWithFormat:@"%d", event.score1];
    
    UITextField *score2 = (UITextField *)[cell viewWithTag:8];
    score2.text = [NSString stringWithFormat:@"%d", event.score2];

    return cell;
}

- (void)loadEvents {
    
    NSLog(@"Loading events...");
    
    Session *session = [Session sharedInstance];
    
    NSTimeInterval start = [[[NSDate alloc] init] timeIntervalSince1970] * 1000;
    
    NSTimeInterval end = start + (1000 * 60 * 60 * 24 * 3);
    
    NSString *url = [[[[[[[@"http://service.bolao.esporte.uol.com.br/system/service/event-bet/" stringByAppendingFormat:@"%d", self.competition.cid] stringByAppendingString:@"/list?startDate="] stringByAppendingFormat:@"%.0f", start] stringByAppendingString:@"&endDate="] stringByAppendingFormat:@"%.0f", end] stringByAppendingString:@"&page=1&size=50&resultType=2&accept=application%2Fjson&_=phn&tk_bl="] stringByAppendingString:session.sessionToken];
    
    NSLog(@"URL: %@", url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn) {
        receiveData = [[NSMutableData alloc] init];
        
        NSLog(@"Connected");
    } else {
        NSLog(@"Error");
    }
    
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
    NSLog(@"Fail %i", error.code);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    unsigned char content[receiveData.length];
    
    [receiveData getBytes:content length:receiveData.length];
    
    NSString *data = [[NSString alloc] initWithBytes:content length:receiveData.length encoding:NSUTF8StringEncoding];
    
    NSLog(@"data: %d", [receiveData length]);
    NSLog(@"content: %@", data);
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingMutableLeaves error:&error];

    NSArray *messages = [json objectForKey:@"message"];
    
    for (NSDictionary *message in messages) {

        NSArray *events = [message objectForKey:@"events"];
    
        for (NSDictionary *event in events) {
            
            NSDictionary *betBody = [(NSDictionary *)event objectForKey:@"bet"];
            
            NSUInteger score1 = [(NSString *)[betBody objectForKey:@"score1"] integerValue];
            NSUInteger score2 = [(NSString *)[betBody objectForKey:@"score2"] integerValue];
            
            NSDictionary *eventBody = (NSDictionary *)[event objectForKey:@"event"];
        
            NSString *eventId = (NSString *)[eventBody objectForKey:@"eventId"];
            NSString *date = (NSString *)[eventBody objectForKey:@"date"];
            NSString *competitorName1 = [[[HtmlConverter alloc] init] decodeHtmlEntities:(NSString *)[eventBody objectForKey:@"competitor1"]];
            NSString *competitorName2 = [[[HtmlConverter alloc] init] decodeHtmlEntities:(NSString *)[eventBody objectForKey:@"competitor2"]];
            NSString *urlCompetitor1 = (NSString *)[eventBody objectForKey:@"urlCompetitor1"];
            NSString *urlCompetitor2 = (NSString *)[eventBody objectForKey:@"urlCompetitor2"];
            NSString *location = [[[HtmlConverter alloc] init] decodeHtmlEntities:(NSString *)[eventBody objectForKey:@"location"]];
            location = [location stringByAppendingString:@" - "];
            location = [[[HtmlConverter alloc] init] decodeHtmlEntities:[location stringByAppendingString:(NSString *)[eventBody objectForKey:@"city"]]];
            
//            CFStringRef *r = CFXMLCreateStringByEscapingEntities(
        
            Competitor *competitor1 = [[Competitor alloc] initWithId:100 name:competitorName1 imageUrl:urlCompetitor1];
            Competitor *competitor2 = [[Competitor alloc] initWithId:200 name:competitorName2 imageUrl:urlCompetitor2];
            
            Event *event = [[Event alloc] initWithId:[eventId integerValue] location:location date:date competitor1:competitor1 competitor2:competitor2];

            event.score1 = score1;
            event.score2 = score2;
            
            [self.dataController add:event];
            
//            NSLog(@"token: %@", eventId);
        }
    }

    [self.tableView reloadData];
    
    NSLog(@"Finish");
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [points objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [points count];
}

- (void)showPicker:(id)sender {
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"abc" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 185, 0,0)];
    
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    
    if (![sender isEqual:@""]) {
//        NSLog(@"%d", [points indexOfObject:sender]);
        selectedIndex = [points indexOfObject:sender];
    } else
        selectedIndex = 0;

    [pickerView selectRow:selectedIndex inComponent:0 animated:YES];

//    NSLog(self.tabBarController.tabBar);
    
    [menu addSubview:pickerView];
//    [menu showInView:self.view];
    [menu showFromTabBar:self.tabBarController.tabBar];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        currentField.text = [points objectAtIndex:selectedIndex];        
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    selectedIndex = row;
    
//    NSLog(@"%d", row);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    currentField = textField;
    
    [textField resignFirstResponder];

    [self showPicker:textField.text];
    
    
//    if ((textField == self.usernameText || textField == self.passwordText) && editMode == NO) {
//        editMode = YES;
    
//        [self resizeTable];
//    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
