//
//  XBJAddShitRecordViewController.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/14.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJAddShitRecordViewController.h"
#import "XBJAddRecordCalendarCell.h"
#import "XBJAddRecordEditCell.h"
#import "XBJAddRecordDescribeCell.h"
#import "XBJNetWork.h"
#import "XBJAppHelper.h"
#import "MJExtension.h"
#import "UUDatePicker.h"
#import "IMBSampleInformation.h"
#import"XBJProtocolViewController.h"
#import "XBJSubmitSuccessViewController.h"
#import "CyUserDefaults.h"
#import"BindHeadFlow.h"

@interface XBJAddShitRecordViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(weak ,nonatomic)IMBSampleInformation *sampleInformationV;


@property (weak, nonatomic  ) IBOutlet UITableView  *tableView;
@property (weak, nonatomic  ) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic  ) IBOutlet UIView       *clearView;
@property (weak, nonatomic) IBOutlet UUDatePicker *datePicker;

@property (strong, nonatomic) NSArray             *colorArray;
@property (strong, nonatomic) NSArray             *traitArray;
@property (assign, nonatomic) BOOL                 colorPicker;

@property (nonatomic, strong) NSMutableArray      *images;

@end

@implementation XBJAddShitRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.colorArray = @[@"黑褐色",@"棕色",@"黄色",@"绿色",@"红色",@"灰白色"];
    self.traitArray = @[@"水样",@"很稀",@"粘稠",@"一般",@"较干",@"干硬"];
    
    if(self.isBindSample)
    {
        self.title = @"样品信息";
        
    }else
    {
        
     if(self.model)
     {
         self.title = @"编辑便便记录";

     }else{
         self.title = @"添加便便记录";

     }
        
    }
    
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordCalendarCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordCalendarCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordEditCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordEditCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordDescribeCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordDescribeCell"];
    _tableView.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9373 blue:0.9490 alpha:1.0];
    
    
    if(self.isBindSample)
    {
        self.model = [[XBJShitRecordModel alloc] init];
        
        IMBSampleInformation *sampleInformationV=[[[NSBundle mainBundle] loadNibNamed:@"IMBSampleInformation" owner:self options:nil] lastObject];
        self.sampleInformationV=sampleInformationV;
        
        _tableView.tableFooterView=self.sampleInformationV;
        
        BindHeadFlow *bindHeadFlowV=[[[NSBundle mainBundle] loadNibNamed:@"BindHeadFlow" owner:self options:nil] lastObject];
        bindHeadFlowV.imageV.image=[UIImage imageNamed:@"进度条_采样录入"];
        self.tableView.tableHeaderView=bindHeadFlowV;
        
        [self.sampleInformationV.wordsBtn addTarget:self action:@selector(clickWordsBut) forControlEvents:UIControlEventTouchUpInside];
        [self.sampleInformationV.submitBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        self.sampleInformationV.agreeBtn.selected=YES;
        self.sampleInformationV.agreeImage.image = [UIImage imageNamed:@"login_tick"];
    

        
    }else{
        if(self.model){
            self.isEdit = YES;
            [self addRightBarButtonWithTitle:@"完成" color:[UIColor whiteColor] normal:nil highLight:nil action:@selector(addAction) target:self];
        }else{
            self.isEdit = NO;
            self.model = [[XBJShitRecordModel alloc] init];
            [self addRightBarButtonWithTitle:@"添加" color:[UIColor whiteColor] normal:nil highLight:nil action:@selector(addAction) target:self];
        }
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
        
        
        NSLog(@"测试  %@",_model.createTime);
        
        
    }];
}
-(void)clickWordsBut
{
    XBJProtocolViewController *vc = [XBJProtocolViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)clearViewHide{
    self.clearView.hidden  = YES;
    self.pickerView.hidden = YES;
    self.datePicker.hidden = YES;
}

- (void)addAction{
    [self.view endEditing:YES];
    if(!_model.trait){
        [self showToastWith:@"性状不能为空"];
        return;
    }else if(!_model.color){
        [self showToastWith:@"颜色不能为空"];
        return;
    }
    if(!_model.remark){
        _model.remark = @"";
    }
    
     if(self.isBindSample)
     {
         if(self.sampleInformationV.agreeBtn.selected==NO)
         {
             [self showToastWith:@"请阅读并同意检测服务条款及知情同意书"];
             return;
         }
     }else{
         
     }

    
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    
    XBJAddRecordDescribeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:cell.images];
    [arr removeLastObject];
    self.images = arr;
    if(self.isBindSample)
    {
        
        NSString *address = [NSString stringWithFormat:@"%@%@",self.bind_model.province,self.bind_model.address];
        
        [[XBJNetWork sharedInstance] bindWithBabyID:babyId sampleCode:self.bind_model.code collectTime:_model.createTime contactName:self.bind_model.contactName mobile:self.bind_model.mobile address:address color:_model.color trait:_model.trait bindRemark:_model.remark images:self.images block:^(id result, NSError *error) {
            if(error){
//                [self showToastWith:error.localizedDescription];
            }else{
                if([result integerValue]==1){
                    [CyUserDefaults saveValue:@"1" forkey:@"firstBind"];
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"samepleCode"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    XBJSubmitSuccessViewController *vc = [XBJSubmitSuccessViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [self showToastWith:result[@"message"]];
                }
            }
            
        }];
        
        
        
        
    }else{
        
        
        
        if(!_isEdit){
            
            [[XBJNetWork sharedInstance] addDungRecordWithBabyID:babyId createTime:_model.createTime trait:_model.trait color:_model.color remark:_model.remark images:self.images block:^(id result, NSError *error) {
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
            [[XBJNetWork sharedInstance] editDungRecordWithBabyID:babyId dungId:_model.dungId createTime:_model.createTime trait:_model.trait color:_model.color remark:_model.remark images:self.images block:^(id result, NSString *msg, NSError *error) {
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
    
    
    
}


#pragma mark - tableView delegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor=RGB(244, 239, 242);
    
    
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section==0){
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
       if(self.isBindSample)
       {
           if (section==0) {
               return 0.1;
           }else
           {
                return 10;
           }
        
       }else
       {
           return 10;
       }
   
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
////    if(self.isBindSample)
////    {
////        self.title = @"样品信息";
////
////    }else
////    {
////        self.title = @"添加便便记录";
////
////    }
//
//    return 0.1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 44;
    }
    return 180;
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
            cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordEditCell"];
            XBJAddRecordEditCell *newCell = (XBJAddRecordEditCell *)cell;
            [newCell configureShitCellWith:indexPath.row andModel:self.model];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordDescribeCell"];
        XBJAddRecordDescribeCell *newCell = (XBJAddRecordDescribeCell *)cell;
        newCell.shitModel = self.model;
        
        __weak __typeof(self)weakSelf = self;
        [newCell setAddImageBlock:^(){
            [weakSelf addImage];
        }];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0 && indexPath.row==1){
        self.colorPicker = NO;
        self.clearView.hidden = NO;
        self.pickerView.hidden = NO;
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
        [self.pickerView reloadAllComponents];
    }else if(indexPath.section==0 && indexPath.row==2){
        self.colorPicker = YES;
        self.clearView.hidden = NO;
        self.pickerView.hidden = NO;
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
        [self.pickerView reloadAllComponents];
    }
}

#pragma mark UIPickerView delegate
//返回列数（必须实现）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//返回每列里边的行数（必须实现）
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.colorPicker) {
        return self.colorArray.count;
    }
    else
    {
        return self.traitArray.count;
    }
}

//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}
//设置组件中每行的标题row:行
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.colorPicker) {
        return self.colorArray[row];
    }
    else
    {
        return self.traitArray[row];
    }
}

//选中行的事件处理
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    [self clearViewHide];
    
    if(self.colorPicker){
        XBJAddRecordEditCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell.textField.text = self.colorArray[row];
        NSString *color = [XBJAppHelper sinoBritishConversion:self.colorArray[row]];
        self.model.color = color;
    }else{
        XBJAddRecordEditCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.textField.text = self.traitArray[row];
        NSString *trait = [XBJAppHelper sinoBritishConversion:self.traitArray[row]];
        self.model.trait = trait;
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
        XBJAddRecordDescribeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
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

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark goBack

- (void)goBack{
    NSDictionary *dic  = [self.model keyValues];
    if(dic.count>1||self.images.count){
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
