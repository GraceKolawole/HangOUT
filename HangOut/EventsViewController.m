////
////  EventsViewController.m
////  HangOut
////
////  Created by Oluwanifemi Kolawole on 7/8/22.
////
//
#import "EventsViewController.h"
#import "EventCell.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"


//
@interface EventsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


//
@end
//
@implementation EventsViewController
//
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.indicator startAnimating];
    [self fetchEvents];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchEvents) forControlEvents:UIControlEventValueChanged];

    [self.tableView addSubview:self.refreshControl];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.refreshControl endRefreshing];
}
-(void) fetchEvents{
    NSURL *url= [NSURL URLWithString:@"https://api.seatgeek.com/2/events?client_id=Mjc3NjgxNTV8MTY1NzU1NDk5MC4zNjM1OTU3&client_secret=84710cd42677f14b657b6203e088a97a1bdc67637e7b9468ee2f53eb2a5ea894"
                ];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               [self displayAlertMessages];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               self.events = dataDictionary[@"events"];
               
            
               [self.tableView reloadData];
               
           }
        [self.refreshControl endRefreshing];
        [self.indicator stopAnimating];
        
    }];
    [task resume];
}
- (void)didReceiveMemoryWarning{[super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    NSDictionary *event = self.events[indexPath.row];
    NSDictionary *venue = event[@"venue"];
    NSArray *performers = event[@"performers"];

    
    
    cell.addressLabel.text = venue[@"address"];
    cell.cityLabel.text = venue[@"city"];
    cell.eventType.text = event[@"type"];
    cell.locationLabel.text = venue[@"display_location"];
    cell.dateTimeLabel.text = event[@"datetime_utc"];
    if (performers && performers.count > 0) {
        NSString *performerName = performers.firstObject[@"name"];
        cell.titleLabel.text = performerName;
        NSString *ticLink = performers.firstObject[@"url"];
        cell.linkTextView.text = ticLink;
        CGFloat fixedWidth = cell.linkTextView.frame.size.width;
        CGSize newSize = [cell.linkTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = cell.linkTextView.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        cell.linkTextView.frame = newFrame;
        [cell.linkTextView setNeedsUpdateConstraints];
        [cell.linkTextView layoutIfNeeded];

        NSString *posterURLString = performers.firstObject[@"image"];
        
        if (![posterURLString isKindOfClass:[NSNull class]]) {
        NSURL *posterURL = [NSURL URLWithString:posterURLString];
    [NSData dataWithContentsOfURL:posterURL];
    NSData *posterImageData = [NSData dataWithContentsOfURL:posterURL];
    cell.posterView.image = [UIImage imageWithData:posterImageData];
        }
        
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Disable selecting row until implemented
  return nil;
}

-(void) displayAlertMessages{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Poor Connection" message:@"Check your internet connectiom and try again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"OK");
        [self.indicator startAnimating];
        [self fetchEvents];
    }];

    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

    @end
