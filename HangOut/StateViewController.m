//
//  StateViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/28/22.
//

#import "SceneDelegate.h"
#import "StateViewController.h"
#import "StateCell.h"
#import "Parse/Parse.h"

@protocol EventTypeFilterDelegate <NSObject>
@end
@interface StateViewController () < UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSDictionary *dict;
    NSMutableArray *filteredStates;
    BOOL isFiltered;
    NSString *state;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *states;


@end

@implementation StateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered= false;
    state = nil;
    self.searchBar.delegate=self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

-(NSInteger)numberofsectionsInTableView:(UITableView *)tableview{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self delegate] numberOfStatesAvailable];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StateCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.delegate stateNameForRow:indexPath.row];
    return cell;
}


@end
