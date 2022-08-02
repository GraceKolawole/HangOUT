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
{
    NSMutableArray *cellSelected;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) UITableViewCellAccessoryType accessoryType;
@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    cellSelected = [NSMutableArray array];
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
@end
