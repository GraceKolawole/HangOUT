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
    NSMutableArray *filteredStates;
    NSMutableArray *cellSelected;
    BOOL isFiltered;
    NSString *state;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *states;
@property(nonatomic) UITableViewCellAccessoryType accessoryType;
@property(nonatomic) BOOL allowsMultipleSelection;
@property(nonatomic, readonly, nullable) NSArray<NSIndexPath *> *indexPathsForSelectedRows;

@end

@implementation StateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    state = nil;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    cellSelected = [NSMutableArray array];
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
    
    if ([cellSelected containsObject:indexPath]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([cellSelected containsObject:indexPath]){
        [cellSelected removeObject:indexPath];
    }
    else{
        [cellSelected addObject:indexPath];
    }
    [tableView reloadData];
}
- (IBAction)didTapDone:(id)sender {
    
}
@end
