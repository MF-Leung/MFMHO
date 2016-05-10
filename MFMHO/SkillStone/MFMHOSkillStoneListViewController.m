//
//  SkillStoneListViewController.m
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOSkillStoneListViewController.h"

@interface MFMHOSkillStoneListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;
@property (strong, nonatomic) MFMHOSkillStoneModel *selectedModel;
@end

@implementation MFMHOSkillStoneListViewController

+ (MFMHOSkillStoneListViewController*)instantiateViewControllerWithSelectedSkillStone:(MFMHOSkillStoneModel*)model{
    MFMHOSkillStoneListViewController * vc=  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SkillStoneListViewController"];
    
    vc.selectedModel =model;
    
    return vc;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas =[NSMutableArray array];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.selectedModel? 1: 0;
    }else
    return self.datas.count+1;
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//  
//}

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
