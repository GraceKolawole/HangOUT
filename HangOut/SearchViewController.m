////
////  SearchViewController.m
////  HangOut
////
////  Created by Oluwanifemi Kolawole on 7/5/22.
////
//
#import "SearchViewController.h"
#import "Parse/Parse.h"
#import "EventCell.h"
//
@interface SearchViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSMutableArray *filteredData;
@property BOOL isFiltered;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isFiltered = false;
    self.searchBar.delegate = self;
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;

//
//    self.data =@[ ];
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    self.searchController.searchResultsUpdater = self;
//    self.searchController.searchBar.autocapitalizationType = nil;
//
//       self.searchController.dimsBackgroundDuringPresentation = NO;
//
//       [self.searchController.searchBar sizeToFit];
//       self.tableView.tableHeaderView = self.searchController.searchBar;
//
//       self.definesPresentationContext = YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredData.count;
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableCell"
                                                                 forIndexPath:indexPath];
    cell.textLabel.text = self.filteredData[indexPath.row];
    return cell;
}
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
- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    <#code#>
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    <#code#>
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    <#code#>
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    <#code#>
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    <#code#>
}

- (void)setNeedsFocusUpdate {
    <#code#>
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    <#code#>
}

- (void)updateFocusIfNeeded {
    <#code#>
}

@end
