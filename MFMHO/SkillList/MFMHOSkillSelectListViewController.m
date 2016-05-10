//
//  SkillSelectListViewController.m
//  MHO
//
//  Created by feiquanqiu on 16/2/3.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOSkillSelectListViewController.h"

@interface MFMHOSkillSelectListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray <MFMHOSkillModel *> *datas;

@property (strong, nonatomic) NSMutableArray <MFMHOSkillModel *> *searchDatas;


@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) UISearchDisplayController *searchController;
@end

@implementation MFMHOSkillSelectListViewController

+ (MFMHOSkillSelectListViewController*)instantiateViewController{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SkillSelectListViewController"];

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
    
    [db executeStatements:@"SELECT * FROM Skill where SkillRankPoint > 0" withResultBlock:^int(NSDictionary *resultsDictionary) {
        
        MFMHOSkillModel * skillModel =[MFMHOSkillModel objectWithKeyValues:resultsDictionary];

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
    
    if (self.callBackBlock) {
        if (tableView == self.searchController.searchResultsTableView) {
            self.callBackBlock(self.searchDatas[indexPath.row]);
        }else
        self.callBackBlock(self.datas[indexPath.row]);
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
