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

@interface StateViewController () < UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSArray *states;
    NSMutableArray *filteredStates;
    BOOL isFiltered;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation StateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered= false;
    self.searchBar.delegate=self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    states = @[@"Alabama, AI", @"Alaska, AK", @"Arizona, AZ", @"Arkansas, AR", @"Califonia, CA", @"Colorado, CO", @"Connecticut, CT", @"Delaware, DE", @"District of Columbia, DC", @"Florida, FL", @"Georgia, GA", @"Hawaii, HI", @"Idaho, ID", @"Illinois, IL", @"Indiana, IN", @"Iowa, IA", @"Kansa, KS", @"Kentucky, KY", @"Louisiana, LA", @"Maine, ME", @"Maryland, MD", @"Massachusetts, MA", @"Michigan, MI", @"Minnesots, MN", @"Mississippi, MS", @"Missouri, MO", @"Montana, MT", @"Nebraska, NE", @"Nevada, NV", @"New Hampshire, NH", @"New Jersey, NJ", @"New Mexico", @"New York, NY", @"North Carolina, NC", @"North Dachota, ND", @"Ohio, OH", @"Oklahome, OK", @"Oregon, OR", @"Pennsylvania, PA", @"Puerto Rico, PR", @"Rhoda Island", @"South Carolina, SC", @"South Dakota, SD", @"Tennessee, TN", @"Texas, Tx", @"Utah, UT", @"Vermont, VT", @"Virginia, VT", @"Virgin Islands, VI", @"Washington, WA", @"West Virginia, WV", @"Wisconsin, WI", @"Wyomimg, WY"];
    // Do any additional setup after loading the view.
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText{
    if (searchText.length == 0){
        isFiltered = false;
    }
    else{
        isFiltered=true;
        filteredStates=[[NSMutableArray alloc]init];
    }
    for (NSString *state in states){
        NSRange nameRange = [state rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if(nameRange.location != NSNotFound){
            [filteredStates addObject:state];
        }
    }
    [self.tableView reloadData];
}
-(NSInteger)numberofsectionsInTableView:(UITableView *)tableview{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(isFiltered){
        return  filteredStates.count;
    }
    return states.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StateCell" forIndexPath:indexPath];
    if (isFiltered){
        cell.textLabel.text = filteredStates[indexPath.row];
    }
    else{
        cell.textLabel.text= states[indexPath.row];
    }
    return cell;
}


@end
