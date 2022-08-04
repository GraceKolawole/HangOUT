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
#import "FilterViewController.h"

#define BASE_EVENT_URL @"https://api.seatgeek.com/2/events?client_id=Mjc3NjgxNTV8MTY1NzU1NDk5MC4zNjM1OTU3&client_secret=84710cd42677f14b657b6203e088a97a1bdc67637e7b9468ee2f53eb2a5ea894&per_page=15"
@protocol EventTypeFilterDelegate <NSObject>
@end

@interface EventsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchResultsUpdating, UISearchBarDelegate, FilterStateDelegate, FilterTypeDelegate, UINavigationControllerDelegate>
{
    int pageId;
    NSString *searchText;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UISearchBar *searchEventForText;
@property (nonatomic, strong) NSArray *filteredEvents;
@property (nonatomic, strong) NSArray *eventsStates;
@property (nonatomic, strong) NSArray *eventsTypes;
@property (nonatomic, strong) NSMutableSet *selectedStateEvents;
@property (nonatomic, strong) NSMutableSet *selectedTypeEvents;

@end

@implementation EventsViewController

- (void)viewDidLoad {
    pageId = 1;
    searchText = nil;
    [super viewDidLoad];

    [self.searchEventForText becomeFirstResponder];
    self.searchEventForText.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.selectedStateEvents = [NSMutableSet new];
    self.selectedTypeEvents = [NSMutableSet new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.indicator startAnimating];
    [self fetchEvents];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchEvents) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.refreshControl endRefreshing];
    
}

- (void) fetchEvents{
    NSURL *url = [NSURL URLWithString:BASE_EVENT_URL];
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
               self.filteredEvents = dataDictionary[@"events"];
               
               [self populateAvailableStates];
               [self populateAvailableTypes];

               [self.tableView reloadData];
           }
        [self.refreshControl endRefreshing];
        [self.indicator stopAnimating];
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning{[super didReceiveMemoryWarning];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    NSDictionary *event = self.filteredEvents[indexPath.row];
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

- (void)fetchMoreEvents{
    
    pageId += 1;
    NSString *urlString = [NSString stringWithFormat:@"%@&page=%i", BASE_EVENT_URL, pageId];
    NSURL *url= [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               [self displayAlertMessages];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSMutableArray *newEvents = [self.events mutableCopy];
               [newEvents addObjectsFromArray:dataDictionary[@"events"]];
               self.events = newEvents;
               self.filteredEvents = newEvents;
               
               [self.tableView reloadData];
           }
    }];
    [task resume];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == self.events.count - 4) {
    [self fetchMoreEvents];
  }
}

- (void) searchBar:(UISearchBar *)searchEventForText textDidChange:(NSString *)searchText {
    searchText=[searchText stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlString = [NSString stringWithFormat:@"%@&page=%i&q=%@", BASE_EVENT_URL, pageId, searchText];
    NSURL *url= [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               [self displayAlertMessages];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              self.filteredEvents = dataDictionary[@"events"];

               [self.tableView reloadData];

               }
        [self.refreshControl endRefreshing];
        [self.indicator stopAnimating];
    }];
    [task resume];
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return self.filteredEvents.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

- (void) displayAlertMessages{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Poor Connection" message:@"Check your internet connectiom and try again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"OK");
        [self.indicator startAnimating];
        [self fetchEvents];
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchEventForText.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchEventForText.showsCancelButton = NO;
    self.searchEventForText.text = @"";
    [self.searchEventForText resignFirstResponder];
    self.filteredEvents = self.events;
    [self.tableView reloadData];
}

- (void) populateAvailableStates {
    NSMutableSet *availableStates = [NSMutableSet new];
    for (int i = 0; i < self.filteredEvents.count; i++) {
        [availableStates addObject:self.filteredEvents[i][@"venue"][@"display_location"]];
    }
    self.eventsStates = [availableStates allObjects];
}
- (void) populateAvailableTypes {
    NSMutableSet *availableTypes = [NSMutableSet new];
    for (int a = 0; a < self.filteredEvents.count; a++) {
        [availableTypes addObject:self.filteredEvents[a][@"type"]];
    }
    self.eventsTypes = [availableTypes allObjects];
}
- (void) filterSelectedStateEvents{
    NSMutableArray *filteredEvent = [NSMutableArray new];
    for (int e = 0; e< self.events.count; e++){
        NSString * state = self.events[e][@"venue"][@"display_location"];
        NSString * type = self.events[e][@"type"];
        if (self.selectedStateEvents.count == 0||[self.selectedStateEvents containsObject:state]){
            [filteredEvent addObject:self.events[e]];
        }
        if (self.selectedTypeEvents.count == 0||[self.selectedTypeEvents containsObject:type]){
            [filteredEvent addObject:self.events[e]];
        }
    }
    self.filteredEvents = filteredEvent;
    [self.tableView reloadData];
}
//- (void) filterSelectedTypeEvents{
//    NSMutableArray *filteredEvent = [NSMutableArray new];
//    for (int t = 0; t< self.events.count; t++){
//        NSString * type = self.events[t][@"type"];
//
//        if (self.selectedTypeEvents.count == 0||[self.selectedTypeEvents containsObject:type]){
//            [filteredEvent addObject:self.events[t]];
//        }
//    }
//    self.filteredEvents = filteredEvent;
//    [self.tableView reloadData];
//}
- (NSUInteger)numberOfStatesAvailable{
    return self.eventsStates.count;
}

- (NSUInteger)numberOfTypesAvailable{
    return self.eventsTypes.count;
}

- (NSString *)stateNameForRow:(NSUInteger)row{
    return self.eventsStates[row];
}

- (NSString *)typeNameForRow:(NSUInteger)row{
    return self.eventsTypes[row];
}

- (BOOL)cellSelected:(NSUInteger)row{
    NSString *nameForRow = [self stateNameForRow:row];
    return [self.selectedStateEvents containsObject:nameForRow];
}

- (BOOL)cellTypeSelected:(NSUInteger)row{
    NSString *nameForTypeRow = [self typeNameForRow:row];
    return [self.selectedTypeEvents containsObject:nameForTypeRow];
}

- (IBAction)didTapFilter:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *vc = [storyboard instantiateViewControllerWithIdentifier: @"FilterViewController"];
    FilterViewController *filterView = (FilterViewController *)[vc topViewController];
    filterView.stateFilterdelegate = self;
    filterView.typeFilterdelegate = self;
    vc.modalPresentationStyle = UIModalPresentationPageSheet;
    UISheetPresentationController *sheet = [vc sheetPresentationController];
    sheet.detents = @[[UISheetPresentationControllerDetent mediumDetent], [UISheetPresentationControllerDetent largeDetent]];
    sheet.largestUndimmedDetentIdentifier = UISheetPresentationControllerDetentIdentifierMedium;
    sheet.prefersScrollingExpandsWhenScrolledToEdge = NO;
    sheet.prefersEdgeAttachedInCompactHeight = YES;
    sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = YES;
    [self presentViewController:vc animated:NO completion:nil];
    
}

- (void)stateFilterEnabledForRow:(NSUInteger)row{
    NSString *nameForRow = [self stateNameForRow:row];
    [self.selectedStateEvents addObject:nameForRow];
    [self filterSelectedStateEvents];
}

- (void)stateFilterDisabledForRow:(NSUInteger)row{
    NSString *nameForRow = [self stateNameForRow:row];
    [self.selectedStateEvents removeObject:nameForRow];
    [self filterSelectedStateEvents];
}
- (void)typeFilterEnabledForRow:(NSUInteger)row{
    NSString *nameForTypeRow = [self typeNameForRow:row];
    [self.selectedTypeEvents addObject:nameForTypeRow];
//    [self filterSelectedTypeEvents];
    [self filterSelectedStateEvents];
}
- (void)typeFilterDisabledForRow:(NSUInteger)row{
    NSString *nameForTypeRow = [self typeNameForRow:row];
    [self.selectedTypeEvents removeObject:nameForTypeRow];
//    [self filterSelectedTypeEvents];
    [self filterSelectedStateEvents];
}
- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender: (id)string {
    if ([segue.identifier isEqualToString:@"PresentViewController"]) {
        FilterViewController *vc = [segue destinationViewController];
        vc.stateFilterdelegate = self;
    }
}
@end
