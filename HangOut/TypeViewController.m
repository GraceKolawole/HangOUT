//
//  TypeViewController.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 8/1/22.
//
#import "SceneDelegate.h"
#import "TypeViewController.h"
#import "TypeCell.h"
#import "Parse/Parse.h"

@protocol EventTypeFilterDelegate <NSObject>
@end
@interface TypeViewController () < UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) BOOL allowsMultipleSelection;
@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

-(NSInteger)numberofsectionsInTableView:(UITableView *)tableview{
    return 1;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self delegate] numberOfTypesAvailable];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.delegate typeNameForRow:indexPath.row];
    
    if ([self.delegate cellTypeSelected:indexPath.row]){
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
    
    if ([self.delegate cellTypeSelected:indexPath.row]){
        [self.delegate typeFilterDisabledForRow:indexPath.row];
    }
    else{
        [self.delegate typeFilterEnabledForRow:indexPath.row];
    }
    [tableView reloadData];
}
@end
