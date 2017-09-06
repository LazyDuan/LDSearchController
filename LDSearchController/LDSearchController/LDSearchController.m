//
//  LDSearchController.m
//  LDSearchController
//
//  Created by LazyDuan on 2017/9/5.
//  Copyright © 2017年 WeTime. All rights reserved.
//

#import "LDSearchController.h"
#import "LDTagFlowLayout.h"
#import "TagCell.h"
#define kScreenWidth             ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight            ([[UIScreen mainScreen] bounds].size.height)
@interface LDSearchController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation LDSearchController

static NSString * const reuseIdentifier = @"tagListItem";
static NSString * const searchKey = @"searchHitory";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:searchKey]) {
        self.dataSource = [userDefaults objectForKey:searchKey];
    }else{
        self.dataSource = [NSMutableArray array];
    }
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.collectionView];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 弹出键盘
    [self.searchBar becomeFirstResponder];
}

- (void)leftButton_click{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)deleteHistory{
    self.dataSource = [NSMutableArray array];
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDTagFlowLayout *layout = (LDTagFlowLayout *)collectionView.collectionViewLayout;
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    
    CGRect frame = [self.dataSource[indexPath.item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]} context:nil];
    
    return CGSizeMake(frame.size.width + 20.0f, layout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.contentLabel.text = self.dataSource[indexPath.item];
    cell.contentLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.000];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - SearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // searchBar.text;
    [self.navigationController popViewControllerAnimated:NO];
    
}
#pragma mark - Getter
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _searchBar.placeholder = @"请输入搜索关键字";
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
    }
    return _searchBar;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 50)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 10, 80, 30);
        [button setTitle:@"最近搜索" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateNormal];
        [_headerView addSubview:button];
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(kScreenWidth-40, 10, 30, 30);
        [deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteHistory) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:deleteButton];
    }
    return _headerView;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        LDTagFlowLayout *layout = [[LDTagFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 114, kScreenWidth, self.view.bounds.size.height-50) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[TagCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
