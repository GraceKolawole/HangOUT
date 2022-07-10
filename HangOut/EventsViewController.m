////
////  EventsViewController.m
////  HangOut
////
////  Created by Oluwanifemi Kolawole on 7/8/22.
////
//
//#import "EventsViewController.h"
//
//@interface EventsViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet UILabel *tableView;
//@property (nonatomic, strong) NSArray *events;
//@property (nonatomic, strong) UIRefreshControl *refreshControl;
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
//
//
//@end
//
//@implementation EventsViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    //self.
//
//    [self.indicator startAnimating];
//
//    [self fetchEvents];
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
//
//    [self.tableView addSubview:self.refreshControl];
//    [self.tableView insertSubview:self.refreshControl atIndex:0];
//}
//
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
