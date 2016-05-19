//
//  EquipAddDataViewController.m
//  MFMHO
//
//  Created by 梁文辉 on 16/5/14.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipAddDataViewController.h"
#import "MFMHOEquipAddDataTableViewCell.h"
#import "MFMHOEquipAddDataModel.h"
#import "MFMHOSkillStonePickerView.h"



@interface MFMHOEquipAddDataViewController ()<UITextFieldDelegate,UITableViewDelegate,UIPickerViewDataSource
,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) MFMHOSkillStonePickerView *pickerView;

@property (strong,nonatomic)NSArray *equipTypes;

@property (strong, nonatomic) IBOutletCollection(MFMHOEquipAddDataTableViewCell) NSArray *cells;

@property (strong ,nonatomic)NSArray <NSArray<MFMHOEquipAddDataModel*> * > *datas;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic)CGFloat tableViewContentInsetBottom;
@end

@implementation EquipAddDataViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.delegate =self;
    
    self.tableView.dataSource =self;
    
    self.equipTypes =@[@{Title :@"头" ,Value:@"Equip_Head" },@{Title :@"身" ,Value:@"Equip_Body" },@{Title :@"手" ,Value:@"Equip_Arm" },@{Title :@"腰" ,Value:@"Equip_Wst" },@{Title :@"腿" ,Value:@"Equip_Leg" }    ];
    
    self.datas =@[  @[ [EquipAddDataModel equipAddDataModelwithTitle:@"表名" withPlaceholder:@"Table" withType:self.equipTypes withIsTable:YES withKeyboardType:UIKeyboardTypeDefault] ],
                    
                    @[ [EquipAddDataModel equipAddDataModelwithTitle:@"主键" withPlaceholder:@"ID" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad] ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"名字" withPlaceholder:@"Name" withType:@"string" withKeyboardType:UIKeyboardTypeDefault],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"等级" withPlaceholder:@"RareLevel" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"孔数" withPlaceholder:@"SlotNum" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"防御" withPlaceholder:@"OriginDef" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"火耐性" withPlaceholder:@"ResFire" withType:@"int" withKeyboardType:UIKeyboardTypeNumbersAndPunctuation],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"水耐性" withPlaceholder:@"ResWater" withType:@"int" withKeyboardType:UIKeyboardTypeNumbersAndPunctuation],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"雷耐性" withPlaceholder:@"ResBold" withType:@"int" withKeyboardType:UIKeyboardTypeNumbersAndPunctuation],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"冰耐性" withPlaceholder:@"ResIce" withType:@"int" withKeyboardType:UIKeyboardTypeNumbersAndPunctuation],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"龙耐性" withPlaceholder:@"ResDragon" withType:@"int" withKeyboardType:UIKeyboardTypeNumbersAndPunctuation]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"一技能名字" withPlaceholder:@"SkillRankID1" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"一技能点数" withPlaceholder:@"SkillRankPoint1" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"二技能名字" withPlaceholder:@"SkillRankID2" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"二技能点数" withPlaceholder:@"SkillRankPoint2" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"三技能名字" withPlaceholder:@"SkillRankID3" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"三技能点数" withPlaceholder:@"SkillRankPoint3" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"四技能名字" withPlaceholder:@"SkillRankID4" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"四技能点数" withPlaceholder:@"SkillRankPoint4" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"五技能名字" withPlaceholder:@"SkillRankID5" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"五技能点数" withPlaceholder:@"SkillRankPoint5" withType:@"int" withKeyboardType:UIKeyboardTypeNumberPad]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"类型" withPlaceholder:@"Occupatant" withType:@[ @{Title: @"近战", Value:@"0"},@{Title: @"远程", Value:@"1"} ]withKeyboardType:0 ]
                        ]
                  
                  
                  
                  ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];

}

- (void)keyboardWillShow:(NSNotification *)sender{

  _tableViewContentInsetBottom =[sender.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    
    self.tableView.contentInset =UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, [sender.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height,self.tableView.contentInset.right);
    
}

- (void)keyboardWillHide:(NSNotification *)sender{
    self.tableView.contentInset =UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, _tableViewContentInsetBottom,self.tableView.contentInset.right);

}
- (IBAction)complete:(id)sender {
    
    
    __block BOOL b;
    
    [self.datas enumerateObjectsUsingBlock:^(NSArray<EquipAddDataModel *> * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        
        [obj1 enumerateObjectsUsingBlock:^(EquipAddDataModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
            
            if (obj2.text.length ==0) {
                
                
                b =YES;
                return ;
            }
        }];
        
    }];
    if (b) {
        [SVProgressHUD showErrorWithStatus:@"请填写完整信息"];
        return;
    }
    
    if ([EquipAddDataModel addModelsToDatabase:self.datas]) {
        [SVProgressHUD showSuccessWithStatus:@"数据插入成功"];
        
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"数据插入失败"];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MFMHOEquipAddDataTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setup:self.datas[indexPath.section][indexPath.row]];
    
    
   // cell.tfContent.delegate =self;

    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.view endEditing:YES];
    
    if ([ [self.datas[indexPath.section][indexPath.row] type] isKindOfClass:[NSArray class] ]) {
        MFMHOSkillStonePickerView *pickerView =[[MFMHOSkillStonePickerView alloc] init];
        
        pickerView.pickerView.delegate =self;
        
        pickerView.pickerView.dataSource =self;
        
        [pickerView show:^(MFMHOSkillStonePickerView * pickerView, BOOL isDone) {
            
            if (isDone) {
                
                NSInteger  selectedRow =[pickerView.pickerView selectedRowInComponent:0];

                MFMHOEquipAddDataTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
                
                MFMHOEquipAddDataModel *obj =self.datas[indexPath.section][indexPath.row];
                
                cell.tfContent.text =[obj type][selectedRow][Title];
                
                obj.text =cell.tfContent.text;
                
                
            }
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return NO;
}


#pragma mark UIPickerViewDataSource,UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];
    
if ([ [self.datas[indexPath.section][indexPath.row] type] isKindOfClass:[NSArray class] ]) {
    
    return [[self.datas[indexPath.section][indexPath.row] type] count];
}
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
     NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];
    
    if ([ [self.datas[indexPath.section][indexPath.row] type] isKindOfClass:[NSArray class] ]) {
        
        return [self.datas[indexPath.section][indexPath.row] type][row][Title];
    }
    return nil;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
 
    
}

- (void)textFieldTextDidChange:(NSNotification *)sender{
    
    UITextField *textField =sender.object;
    
    
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof EquipAddDataTableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj.tfContent isEqual:textField]) {
            
            NSIndexPath *indexPath =[self.tableView indexPathForCell:obj];
            
            EquipAddDataModel *model =self.datas[indexPath.section][indexPath.row];
            
            model.text =textField.text;
            
        }
        
    }];
    
    //
    //
    //    obj.text =self.tfContent.text;
    
}


@end
