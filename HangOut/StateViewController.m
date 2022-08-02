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

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic) BOOL allowsMultipleSelection;
@property(nonatomic, readonly, nullable) NSArray<NSIndexPath *> *indexPathsForSelectedRows;

@end

@implementation StateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    if ([self.delegate cellSelected:indexPath.row]){
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
    
    if ([self.delegate cellSelected:indexPath.row]){
        [self.delegate stateFilterDisabledForRow:indexPath.row];
    }
    else{
        [self.delegate stateFilterEnabledForRow:indexPath.row];
    }
    [tableView reloadData];
}
- (IBAction)didTapDone:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
