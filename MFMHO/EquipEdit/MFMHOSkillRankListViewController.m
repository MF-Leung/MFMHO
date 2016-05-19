//
//  MFMHOSkillRankListViewController.m
//  MFMHO
//
//  Created by 梁文辉 on 16/5/19.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOSkillRankListViewController.h"

@interface MFMHOSkillRankListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray <MFMHOSkillRankModel *> *datas;

@property (strong, nonatomic) NSMutableArray <MFMHOSkillRankModel *> *searchDatas;


@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) UISearchDisplayController *searchController;

@end

@implementation MFMHOSkillRankListViewController
+ (MFMHOSkillRankListViewController*)instantiateViewController{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MFMHOSkillRankListViewController"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate =self;
    
    self.tableView.dataSource =self;
    
    self.datas =[NSMutableArray array];
    
    self.searchDatas =[NSMutableArray array];
    
    self.searchBar.delegate =self;
    
    self.searchBar.returnKeyType =UIReturnKeyDone;
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    self.searchController.searchResultsDataSource=self;
    
    self.searchController.searchResultsDelegate=self;
    
    self.tableView.tableHeaderView =self.searchBar;
    
    [self setupData];
    // Do any additional setup after loading the view.
}

- (void)setupData{
    FMDatabase *db =[MFMHODatabase instance].db;
    
    [self.datas removeAllObjects];
    
    [db executeStatements:@"SELECT * FROM SkillRank " withResultBlock:^int(NSDictionary *resultsDictionary) {
        
        MFMHOSkillRankModel * skillModel =[MFMHOSkillRankModel objectWithKeyValues:resultsDictionary];
        
        [self.datas addObject:skillModel];
        
        return 0;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchController.searchResultsTableView) {
        return self.searchDatas.count;
    }else
        return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier =@"Cell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
    }
    
    NSString *name =@"";
    
    if (tableView == self.searchController.searchResultsTableView) {
        name =self.searchDatas[indexPath.row].Name;
        
    }else name =self.datas[indexPath.row].Name;
    
    cell.textLabel.text =name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchDatas =[NSMutableArray arrayWithArray:[self searchDatasWithKey:searchBar.text]];
    [self.searchController.searchResultsTableView reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
}


- (NSArray *)searchDatasWithKey:(NSString *)key{
    if (key.length == 0) {
        return self.datas;
    }
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"Name CONTAINS[cd] %@ OR KeyWord CONTAINS[cd] %@",key,key];
    
    return [self.datas filteredArrayUsingPredicate:predicate];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
