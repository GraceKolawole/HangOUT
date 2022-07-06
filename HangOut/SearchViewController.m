////
////  SearchViewController.m
////  HangOut
////
////  Created by Oluwanifemi Kolawole on 7/5/22.
////
//
//#import "SearchViewController.h"
//
//@interface SearchViewController ()
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) UISearchController *searchController;
//@property (strong, nonatomic) NSArray *data;
//@property (strong, nonatomic) NSArray *filteredData;
//
//@end
//
//@implementation SearchViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.tableView.delegate = self;
//       self.tableView.dataSource = self;
//
//       self.data = @[];
//       self.filteredData = self.data;
//
//       // Initializing with searchResultsController set to nil means that
//       // searchController will use this view controller to display the search results
//       self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//       self.searchController.searchResultsUpdater = self;
//
//       // If we are using this same view controller to present the results
//       // dimming it out wouldn't make sense. Should probably only set
//       // this to yes if using another controller to display the search results.
//       self.searchController.dimsBackgroundDuringPresentation = NO;
//
//       [self.searchController.searchBar sizeToFit];
//       self.tableView.tableHeaderView = self.searchController.searchBar;
//
//       // Sets this view controller as presenting view controller for the search interface
//       self.definesPresentationContext = YES;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.filteredData.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableCell"
//                                                                 forIndexPath:indexPath];
//    cell.textLabel.text = self.filteredData[indexPath.row];
//    return cell;
//}
//
//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//
//    NSString *searchText = searchController.searchBar.text;
//    if (searchText) {
//
//        if (searchText.length != 0) {
//            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
//                return [evaluatedObject containsString:searchText];
//            }];
//            self.filteredData = [self.data filteredArrayUsingPredicate:predicate];
//        }
//        else {
//            self.filteredData = self.data;
//        }
//
//        [self.tableView reloadData];
//
//    }
//
//}
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
