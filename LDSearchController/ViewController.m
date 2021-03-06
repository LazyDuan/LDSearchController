//
//  ViewController.m
//  LDSearchController
//
//  Created by WeTime on 2017/9/5.
//  Copyright © 2017年 WeTime. All rights reserved.
//

#import "ViewController.h"
#import "LDSearchBar.h"
#import "LDSearchController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong)UITableView    *tableView;
@property (nonatomic, strong)LDSearchBar    *searchBar;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UISearchController *searchController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.titleView = self.searchBar;
    //self.navigationItem.titleView = self.searchController.searchBar;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UItableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}
#pragma mark - SearchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    LDSearchController *vc = [[LDSearchController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}
#pragma mark - Getters
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[LDSearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        
        _searchBar.delegate = self;
        _searchBar.hasCentredPlaceholder = NO;
        _searchBar.placeholderColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
        _searchBar.placeholder = @"搜索";
    }
    return _searchBar;
}
- (UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//_searchController.searchResultsUpdater = self;
        //_searchController.definesPresentationContext = true;
    }
    return _searchController;
}
@end
