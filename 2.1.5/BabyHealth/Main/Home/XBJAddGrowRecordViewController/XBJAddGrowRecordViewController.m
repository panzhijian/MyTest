//
//  XBJAddGrowRecordViewController.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/17.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJAddGrowRecordViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "XBJAddRecordCalendarCell.h"
#import "XBJAddRecordEditCell.h"
#import "XBJAddRecordDescribeCell.h"
#import "XBJAddRecordMoreCell.h"
#import "XBJNetWork.h"
#import "MJExtension.h"
#import "UUDatePicker.h"

@interface XBJAddGrowRecordViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *clearView;
@property (weak, nonatomic) IBOutlet UUDatePicker *datePicker;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation XBJAddGrowRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordCalendarCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordCalendarCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordEditCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordEditCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordDescribeCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordDescribeCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordMoreCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordMoreCell"];
    
    _tableView.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9373 blue:0.9490 alpha:1.0];
    
    if(self.model){
        self.isEdit = YES;
        self.title = @"编辑生长记录";;
        [self addRightBarButtonWithTitle:@"完成" color:[UIColor whiteColor] normal:nil highLight:nil action:@selector(addAction) target:self];
    }else{
        self.isEdit = NO;
        self.title = @"添加生长记录";;
        self.model = [[XBJGrowRecordModel alloc] init];
        [self addRightBarButtonWithTitle:@"添加" color:[UIColor whiteColor] normal:nil highLight:nil action:@selector(addAction) target:self];
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(datePickerHide)];
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
        _model.recordDate = date;
    }];

}

- (void)datePickerHide{
    self.clearView.hidden = YES;
    self.datePicker.hidden = YES;
}

- (void)addAction{
    [self.view endEditing:YES];
    if(!self.model.length){
        [self showToastWith:@"身高不能为空"];
        return;
    }else if(!_model.bodyWeight){
        [self showToastWith:@"体重不能为空"];
        return;
    }else if(!_model.headSize){
        [self showToastWith:@"头围不能为空"];
        return;
    }
    if(!_model.remark){
        _model.remark = @"";
    }
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    
    XBJAddRecordDescribeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:cell.images];
    [arr removeLastObject];
    self.images = arr;
    
    if(!_isEdit){
        [[XBJNetWork sharedInstance] addGrowRecordWithBabyID:babyId recordDate:_model.recordDate length:_model.length weight:_model.bodyWeight headSize:_model.headSize remark:_model.remark images:self.images block:^(id result, NSError *error) {
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
        [[XBJNetWork sharedInstance] editGrowRecordWithBabyID:babyId growId:_model.growId recordDate:_model.recordDate length:_model.length bodyWeight:_model.bodyWeight headSize:_model.headSize remark:_model.remark images:self.images block:^(id result, NSString *msg, NSError *error) {
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 4;
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
        return 44;
    }
    return 180;
    //    float height = [tableView fd_heightForCellWithIdentifier:@"XBJAddRecordCalendarCell" cacheByIndexPath:indexPath configuration:^(XBJAddRecordCalendarCell * cell) {
    //
    //    }];
    //    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    if(indexPath.section==0){
        if(indexPath.row==0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordCalendarCell"];
            XBJAddRecordCalendarCell *newCell = (XBJAddRecordCalendarCell *)cell;
            
            if(self.isEdit){
                newCell.dateLabel.text = self.model.recordDate;
            }else{
                NSDate * date = [NSDate date];
                NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSString * dateString = [dateFormatter stringFromDate:date];
                newCell.dateLabel.text = dateString;
                _model.recordDate = dateString;
            }
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
            [newCell configureGrowCellWith:indexPath.row andModel:self.model];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordDescribeCell"];
        XBJAddRecordDescribeCell *newCell = (XBJAddRecordDescribeCell *)cell;
        newCell.growModel = self.model;
        /*
         NSArray *arr = @[[UIImage imageNamed:@"chenggong"],[UIImage imageNamed:@"baby car"],[UIImage imageNamed:@"shilipic"]];
         [newCell setImagesWith:arr];
         */
        __weak __typeof(self)weakSelf = self;
        [newCell setAddImageBlock:^(){
            [weakSelf addImage];
        }];
    }
    //        }else{
    //        if(indexPath.section==0){
    //            if(indexPath.row==0){
    //                cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordCalendarCell"];
    //            }else if(indexPath.row==3){
    //                cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordMoreCell"];
    //            }else{
    //                cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordEditCell"];
    //            }
    //        }else{
    //            cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordDescribeCell"];
    //        }
    
    return cell;
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

#pragma mark goBack

- (void)goBack{
    NSDictionary *dic  = [self.model keyValues];
    if(dic.count>1||self.images.count    ){
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
