//
//  EquipAddDataViewController.m
//  MFMHO
//
//  Created by 梁文辉 on 16/5/14.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "EquipAddDataViewController.h"
#import "EquipAddDataTableViewCell.h"
#import "EquipAddDataModel.h"
#import "MFMHOSkillStonePickerView.h"

#define Title @"title"
#define Value @"table"


@interface EquipAddDataViewController ()<UITextFieldDelegate,UITableViewDelegate,UIPickerViewDataSource
,UIPickerViewDelegate>

@property (strong, nonatomic) MFMHOSkillStonePickerView *pickerView;

@property (strong,nonatomic)NSArray *equipTypes;

@property (strong, nonatomic) IBOutletCollection(EquipAddDataTableViewCell) NSArray *cells;

@property (strong ,nonatomic)NSArray *datas;
@end

@implementation EquipAddDataViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.pickerView =[[MFMHOSkillStonePickerView alloc] init];
    
    self.pickerView.pickerView.delegate =self;
    
    self.pickerView.pickerView.dataSource =self;
    
    self.equipTypes =@[@{Title :@"头" ,Value:@"Equip_Head" },@{Title :@"身" ,Value:@"Equip_Body" },@{Title :@"手" ,Value:@"Equip_Arm" },@{Title :@"腰" ,Value:@"Equip_Wst" },@{Title :@"腿" ,Value:@"Equip_Leg" }    ];
    
    
    self.datas =@[  @[ [EquipAddDataModel equipAddDataModelwithTitle:@"表名" withPlaceholder:@"Table" withType:self.equipTypes withIsTable:YES] ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"名字" withPlaceholder:@"Name" withType:@"String"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"等级" withPlaceholder:@"Table" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"孔数" withPlaceholder:@"SlotNum" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"防御" withPlaceholder:@"OriginDef" withType:@"int"]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"火耐性" withPlaceholder:@"ResFire" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"水耐性" withPlaceholder:@"ResWater" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"雷耐性" withPlaceholder:@"ResBold" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"冰耐性" withPlaceholder:@"ResIce" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"龙耐性" withPlaceholder:@"ResDragon" withType:@"int"]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"一技能名字" withPlaceholder:@"SkillRankID1" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"一技能点数" withPlaceholder:@"SkillRankPoint1" withType:@"int"]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"二技能名字" withPlaceholder:@"SkillRankID2" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"二技能点数" withPlaceholder:@"SkillRankPoint2" withType:@"int"]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"三技能名字" withPlaceholder:@"SkillRankID3" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"三技能点数" withPlaceholder:@"SkillRankPoint3" withType:@"int"]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"四技能名字" withPlaceholder:@"SkillRankID4" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"四技能点数" withPlaceholder:@"SkillRankPoint4" withType:@"int"]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"五技能名字" withPlaceholder:@"SkillRankID5" withType:@"int"],
                        [EquipAddDataModel equipAddDataModelwithTitle:@"五技能点数" withPlaceholder:@"SkillRankPoint5" withType:@"int"]
                        ],
                    @[
                        [EquipAddDataModel equipAddDataModelwithTitle:@"类型" withPlaceholder:@"Occupatant" withType:@[ @{Title: @"近战", Value:@0},@{Title: @"远程", Value:@1} ] ]
                        ]
                  
                  
                  
                  ];
    
}
- (IBAction)complete:(id)sender {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        
        [_pickerView show:^(MFMHOSkillStonePickerView * pickerView, BOOL isDone) {
           
            
        }];
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
    return self.self.equipTypes.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.equipTypes[row][Title];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    
}
            
@end
