//
//  XBJAddDrugRecordViewController.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/14.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJAddDrugRecordViewController.h"
#import "XBJAddRecordCalendarCell.h"
#import "XBJAddDurgRecordCell.h"
#import "XBJAddRecordDescribeCell.h"
#import "XBJAddRecordMoreCell.h"
#import "XBJNetWork.h"
#import "MJExtension.h"
#import "UUDatePicker.h"
#import "XBJDrugChooseViewController.h"

@interface XBJAddDrugRecordViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic  ) IBOutlet UITableView  *tableView;
@property (weak, nonatomic) IBOutlet UIView *clearView;
@property (weak, nonatomic) IBOutlet UUDatePicker *datePicker;

@property (nonatomic, strong) NSMutableArray      *drugs;
@property (nonatomic, strong) NSMutableArray      *images;
@property (nonatomic, assign) NSInteger            drug_num;

@end

@implementation XBJAddDrugRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordCalendarCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordCalendarCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddDurgRecordCell" bundle:nil] forCellReuseIdentifier:@"XBJAddDurgRecordCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordDescribeCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordDescribeCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordMoreCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordMoreCell"];
    
    _tableView.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9373 blue:0.9490 alpha:1.0];
    
    
    NSMutableDictionary *drugDic = [[NSMutableDictionary alloc] init];
    [_drugs addObject:drugDic];
    
    if(self.model){
        self.isEdit = YES;
        self.title = @"编辑用药记录";
        _drug_num = self.model.medicineInfos.count;
        _drugs    = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in self.model.medicineInfos){
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:dic];
            [_drugs addObject:dict];
        }
        [self addRightBarButtonWithTitle:@"完成" color:[UIColor whiteColor] normal:nil highLight:nil action:@selector(addAction) target:self];
    }else{
        self.isEdit = NO;
        self.title = @"添加用药记录";
        _drug_num = 1;
        _drugs    = [[NSMutableArray alloc] init];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [_drugs addObject:dic];
        self.model = [[XBJDrugRecordModel alloc] init];
        [self addRightBarButtonWithTitle:@"添加" color:[UIColor whiteColor] normal:nil highLight:nil action:@selector(addAction) target:self];
    }
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearViewHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    //将触摸事件添加到当前tableView
    [self.clearView addGestureRecognizer:tapGestureRecognizer];
    
    [self.datePicker setDatePickerStyle:UUDateStyle_YearMonthDayHourMinute];
    [self.datePicker setFinishBlock:^(NSString *year,
                                      NSString *month,
                                      NSString *day,
                                      NSString *hour,
                                      NSString *minute,
                                      NSString *weekDay) {
        NSString *date = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
        
        XBJAddRecordCalendarCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.dateLabel.text = date;
        _model.createTime = date;
    }];
}

- (void)clearViewHide{
    self.clearView.hidden  = YES;
    self.datePicker.hidden = YES;
}

- (void)addAction{
    [self.view endEditing:YES];
    
    NSDictionary *drugDic = self.drugs.count?self.drugs[0]:nil;
    if(drugDic.count==0){
        [self showToastWith:@"请填写药品信息"];
        return;
    }
    
    for(NSDictionary *dic in self.drugs){
        NSString *med = dic[@"medicineName"];
        if(med.length==0){
            [self showToastWith:@"请填写药品名称"];
            return;
        }
        NSString *mea = dic[@"measure"];
        if(mea.length==0){
            [self showToastWith:@"请填写药品计量"];
            return;
        }
        
        NSArray *measures = @[@"片",@"粒",@"袋",@"支",@"喷",@"克",@"毫克",@"微克",@"毫升"];
        NSInteger index = 0;
        for(NSString *measure in measures){
            NSRange range = [dic[@"measure"] rangeOfString:measure];
            if(range.location!= NSNotFound){
                break;
            }
            index++;
        }
        if(index==9){
            [self showToastWith:@"请选择正确的计量单位"];
            return;
        }
    }
    
    if(!self.model.remark){
        self.model.remark = @"";
    }
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    
    XBJAddRecordDescribeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:cell.images];
    [arr removeLastObject];
    self.images = arr;
    if(!_isEdit){
        
        [[XBJNetWork sharedInstance] addDrugRecordWithBabyID:babyId createTime:self.model.createTime drugs:self.drugs remark:self.model.remark images:self.images block:^(id result, NSError *error) {
            if(error){
                [self showToastWith:error.description];
            }else{
                if([result integerValue]==1){
                    
                    [self showToastWith:@"添加成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self showToastWith:@"添加失败"];
                }
            }
        }];
    }else{
        [[XBJNetWork sharedInstance] editMedicineRecordWithBabyID:babyId medicineId:_model.medicineId createTime:_model.createTime remark:_model.remark drugs:self.drugs images:self.images block:^(id result, NSString *msg, NSError *error) {
            if(error){
                [self showToastWith:error.description];
            }else{
                if([result integerValue]==1){
                    [self showToastWith:@"修改成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self showToastWith:@"修改失败"];
                }
            }
        }];
    }
}

#pragma mark - tableView delegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section==0){
        return _drug_num+1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        if(indexPath.row!=0){
            return 88;
        }
    }
    
    if(indexPath.section==2){
        return 180;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(indexPath.section==0){
        if(indexPath.row==0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordCalendarCell"];
            XBJAddRecordCalendarCell *newCell = (XBJAddRecordCalendarCell *)cell;
            if(self.isEdit){
                newCell.dateLabel.text = self.model.createTime;
            }else{
                NSDate * date = [NSDate date];
                NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSString * dateString = [dateFormatter stringFromDate:date];
                newCell.dateLabel.text = dateString;
                _model.createTime = dateString;
            }
            [newCell.calendarBtn setImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];
            __weak __typeof__(self) weakSelf = self;
            [newCell setBlock:^(){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                [strongSelf.view endEditing:YES];
                strongSelf.clearView.hidden = NO;
                strongSelf.datePicker.hidden = NO;
            }];
            
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddDurgRecordCell"];
            XBJAddDurgRecordCell *newCell = (XBJAddDurgRecordCell *)cell;
            newCell.drugDic = self.drugs[indexPath.row-1];
            //begin 2016.10.18 时攀 用药剂量弹框 选择药品
            __weak __typeof__(self) weakSelf = self;
            
            __weak __typeof__(newCell) weakCell = newCell;
            [newCell setNameBlock:^(){
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                __strong __typeof__(newCell) strongCell= weakCell;
                XBJDrugChooseViewController * ChooseView = [[ XBJDrugChooseViewController alloc]init];
                ChooseView.hidesBottomBarWhenPushed=YES;

                 [ChooseView setBlook:^(NSString *searchResult)
                {
                    [strongCell.drugDic setValue:searchResult forKey:@"medicineName"];
                    strongCell.textField1.text = searchResult;
                }];
                [strongSelf.navigationController pushViewController:ChooseView animated:YES];
               
            }];
            
            [newCell setCountBlock:^()
            {
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                strongSelf.drugCountIndexPath= indexPath;
                [strongSelf creatDrugArrData];
                strongSelf.index1=0;
                strongSelf.index2=0;
                strongSelf.index3=0;
                strongSelf.customPicker = [[ActionSheetCustomPicker alloc] initWithTitle:@"用药剂量" delegate:strongSelf showCancelButton:YES origin:tableView initialSelections:nil];
                
                [strongSelf.customPicker showActionSheetPicker];
           
            }];
            //end 2016.10.18 时攀 用药剂量弹框
        }
    }else if(indexPath.section==1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordMoreCell"];
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordDescribeCell"];
        XBJAddRecordDescribeCell *newCell = (XBJAddRecordDescribeCell *)cell;
        newCell.drugModel = self.model;
        
        __weak __typeof(self)weakSelf = self;
        [newCell setAddImageBlock:^(){
            [weakSelf addImage];
        }];
        
    }
    return cell;
}
//begin 2016.10.18 时攀 用药剂量弹框
-(void)creatDrugArrData
{
    
    NSMutableArray * arr1 = [NSMutableArray new];
    NSMutableArray * arr2 = [NSMutableArray new];
    NSString * str;
    for (int i=0; i<=150; i++) {
        str = [NSString stringWithFormat:@"%d",i];
        if (i == 0) {
            str = @"--";
        }
        [arr1 addObject:str];
    }
    for (int i=5; i>=2; i--) {
        str = [NSString stringWithFormat:@"1/%d",i];
        if (i == 5) {
            str = @"--";
        }
        [arr2 addObject:str];
    }
    self.intArr = arr1;
    self.smallArr = arr2;
    self.drugUnitArr = [NSMutableArray arrayWithObjects:@"片",@"粒",@"支",@"喷",@"袋",@"克",@"毫克",@"微克",@"毫升", nil];
}
#pragma mark - UIPickerViewDataSource Implementation
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    switch (component)
    {
        case 0: return self.intArr.count;
        case 1: return self.smallArr.count;
        case 2:return self.drugUnitArr.count;
        default:break;
    }
    return 0;

}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.intArr[row];
        case 1: return self.smallArr[row];
        case 2:return self.drugUnitArr[row];
        default:break;
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:self.index1=row;
            break;
        case 1:self.index2=row;
            break;
        case 2:self.index3=row;
            break;
        default:break;
    }
}
- (void)actionSheetPickerDidSucceed:(ActionSheetCustomPicker *)actionSheetPicker origin:(id)origin
{
   XBJAddDurgRecordCell *cell =(XBJAddDurgRecordCell *) [self.tableView cellForRowAtIndexPath:self.drugCountIndexPath];
   NSString *str;
    if (self.index1==0&&self.index2==0) {
        return;
    }
    if (self.index1==0) {
        str = [NSString stringWithFormat:@"%@%@",self.smallArr[self.index2],self.drugUnitArr[self.index3]];
    }
    else
    {
        str = [NSString stringWithFormat:@"%@+%@%@",self.intArr[self.index1],self.smallArr[self.index2],self.drugUnitArr[self.index3]];
        if (self.index2==0) {
            str = [NSString stringWithFormat:@"%@%@",self.intArr[self.index1],self.drugUnitArr[self.index3]];
        }
    }
    [cell.drugDic setValue:str forKey:@"measure"];
    cell.textField2.text = str;

}

//end 2016.10.18 时攀 用药剂量弹框
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        //begin 2016.10.14 时攀 用药添加控制
        NSDictionary *dic= self.drugs.count?self.drugs[ _drug_num-1]:nil;
        if(dic.count==0){
            [self showToastWith:@"请填写药品信息"];
            return;
        }
        NSString *med = dic[@"medicineName"];
        if(med.length==0){
            [self showToastWith:@"请填写药品名称"];
            return;
        }
        NSString *mea = dic[@"measure"];
        if(mea.length==0){
            [self showToastWith:@"请填写药品计量"];
            return;
        }
        //end 2016.10.14 时攀 用药添加控制
        _drug_num ++;
        NSMutableDictionary *drugDic = [[NSMutableDictionary alloc] init];
        [self.drugs addObject:drugDic];
        
        NSArray *array = @[[NSIndexPath indexPathForRow:_drug_num inSection:0]];
        [self.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 拍照或者打开相册
- (void)addImage{
    [self.view endEditing:YES];
    //    if(self.isEdit){
    //        [self showToastWith:@"图片暂不支持编辑"];
    //        return;
    //    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中取", nil];
    [actionSheet showInView:self.view];
}

- (void)showImagePickerControllerWithIndex:(NSInteger )index{
    if(index!=2){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        if (index == 0)
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                //设置类型，我们打开的是照相的页面
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.mediaTypes = [[NSArray alloc] initWithObjects:@"public.image", nil];
                //即可拍照又可录像用下面的赋值方式
                picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            }
        } else if(index == 1) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        }
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark -UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSData *data    =   UIImageJPEGRepresentation(image, 0.1);
    image =   [UIImage imageWithData:data];
    
    {
        XBJAddRecordDescribeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:cell.images];
        [arr removeLastObject];
        [arr addObject:image];
        self.images = arr;
        [cell setImagesWith:arr];
    }
    
    //    [self.commentImages removeLastObject];
    //    [self.commentImages addObject:image]; // 吧图片添加到数组
    //    [self.commentImages addObject:self.removeImage];
    //
    //    [self updateCommentImage];            // 刷新界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self showImagePickerControllerWithIndex:buttonIndex];
}

#pragma mark goBack

- (void)goBack{
    
    NSDictionary *dic  = [self.model keyValues];
    NSDictionary *drugDic = self.drugs.count?self.drugs[0]:nil;
    if(dic.count>1||drugDic.count||self.images.count){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否退出编辑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
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
