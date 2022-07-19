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
#import "SearchCell.h"
//
@interface SearchViewController ()

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic)  NSArray *filteredData;

@end

@implementation SearchViewController
NSArray *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = @[@"New York, NY", @"Los Angeles, CA", @"Baton Rouge, LA", @"Houston, TX",
                  @"Oslo, Norway", @"Phoenix, AZ", @"Albuquerque, NM", @"San Antonio, TX",
                  @"Dallas, TX", @"Cincinnati, OH", @"San Jose, CA", @"Indianapolis, IN",
                  @"JLas Vegas, NV", @"San Francisco, CA", @"Columbus, OH", @"Austin, TX",
                  @"Memphis, TN", @"Baltimore, MD", @"Charlotte, ND", @"Nashville, TN", @"Shipshewana, IN", @"Hermosa Beach, CA"];
    
    self.tableView.dataSource = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
       cell.textLabel.text = data[indexPath.row];
       return  cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
}
- (void)setNeedsFocusUpdate {
}

- (void)updateFocusIfNeeded {
}

@end
