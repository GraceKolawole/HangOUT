//////
//////  SearchViewController.m
//////  HangOut
//////
//////  Created by Oluwanifemi Kolawole on 7/5/22.
//////
////
//#import "SearchViewController.h"
//#import "Parse/Parse.h"
//#import "EventCell.h"
//#import "SearchCell.h"
//#import "EventsViewController.h"
////
//@interface SearchViewController ()
//
//@property (strong, nonatomic) UISearchController *searchController;
//@property (nonatomic, strong) NSArray *events;
//
//@end
//
//@implementation SearchViewController
//NSArray *data;
//NSArray *filteredData;
//NSString *CellIdentifier = @"EventCell";
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    data = @[@"New York, NY", @"Los Angeles, CA", @"Baton Rouge, LA", @"Houston, TX",
//                  @"Oslo, Norway", @"Phoenix, AZ", @"Albuquerque, NM", @"San Antonio, TX",
//                  @"Dallas, TX", @"Cincinnati, OH", @"San Jose, CA", @"Indianapolis, IN",
//                  @"JLas Vegas, NV", @"San Francisco, CA", @"Columbus, OH", @"Austin, TX",
//                  @"Memphis, TN", @"Baltimore, MD", @"Charlotte, ND", @"Nashville, TN", @"Shipshewana, IN", @"Hermosa Beach, CA"];
//
//    self.tableView.dataSource = self;
//    self.searchBar.delegate = self;
//    self.tableView.delegate = self;
//
//    filteredData = data;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return filteredData.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.textLabel.text =  filteredData[indexPath.row];
////    cell.locationLabel.text = venue[@"display_location"];
//       return  cell;
//
//}
//
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//
//    if (searchText.length != 0) {
//
//        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
            
//            return [evaluatedObject containsString:searchText];
//        }];
//        filteredData = [data filteredArrayUsingPredicate:predicate];
//
//        NSLog(@"%@", filteredData);
//
//    }
//    else {
//        filteredData = data;
//    }
//
//    [self.tableView reloadData];
//
//}
//- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
//}
//
//- (void)encodeWithCoder:(nonnull NSCoder *)coder {
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//}
//- (void)setNeedsFocusUpdate {
//}
//
//- (void)updateFocusIfNeeded {
//}
//
//@end
