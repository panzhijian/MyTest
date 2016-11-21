//
//  BabyInformation.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "BabyInformation.h"
#import "BabyCell.h"
#import "BabyInformationCell.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetStringPicker.h"
#import "QIAODBMangerEx.h"
#import "NSString+Date.h"
#import "MBProgressHUD.h"

@implementation BabyInformation
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"宝宝信息";
    self.isUpdateValue = YES;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"保存" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(0,0,AUTO_MATE_WIDTH(100),AUTO_MATE_HEIGHT(30));
    [addBtn addTarget:self action:@selector(addBabyClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = addBtnItem;
    
    self.titleArray = [NSArray arrayWithObjects:@"宝宝昵称",@"宝宝生日",@"宝宝性别",@"宝宝出生孕周",@"宝宝分娩方式",@"宝宝出生体长",@"宝宝出生体重",@"宝宝出生头围", nil];
    
    self.updateMe = [[UpdateMeInformation alloc] init];
    self.updateMe.delegate = self;
    
    self.babyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, VIEW_SIZE.height) style:UITableViewStyleGrouped];
    self.babyTableView.delegate = self;
    self.babyTableView.dataSource = self;
    self.babyTableView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.babyTableView];
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    self.users = [[qiao selectAllFromTable] lastObject];
}

#pragma mark -- 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

#pragma mark -- 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 4)
    {
        return AUTO_MATE_HEIGHT(100);
    }
    else
    {
       return AUTO_MATE_HEIGHT(120);
    }
}

#pragma mark -- 返回头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return AUTO_MATE_HEIGHT(10);
}

#pragma mark -- 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < 4)
    {
        static NSString *meCell = @"informationCell";
        BabyCell *cell = [tableView dequeueReusableCellWithIdentifier:meCell];
        if(!cell)
        {
            cell = [[BabyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:meCell];
        }
        
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 0:
                cell.rightLabel.text = self.users.babyNickName;
                break;
            case 1:
                if(self.users.babyBirthday)
                {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",self.users.babyBirthday];
                }
                else
                {
                    cell.rightLabel.text = @"";
                }
                break;
            case 2:
                cell.rightLabel.text = self.users.babySex;
                break;
            case 3:
                cell.rightLabel.text = [NSString stringWithFormat:@"%ld周",[self.users.babyPregnancyCycle integerValue]];
                break;
                
            default:
                break;
        }
        
        return cell;
    }
    else
    {
        static NSString *babyCell = @"BabyInformationCell";
        BabyInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:babyCell];
        if(!cell)
        {
            cell = [[BabyInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:babyCell];
        }
        
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 4:
                cell.rightLabel.text = self.users.babyChildbirthType;
                break;
            case 5:
                cell.rightLabel.text = [NSString stringWithFormat:@"%.2fcm",[self.users.babyLength floatValue]];
                break;
            case 6:
                cell.rightLabel.text = [NSString stringWithFormat:@"%.2fkg",[self.users.babyBodyWeight floatValue]];
                break;
            case 7:
                cell.rightLabel.text = [NSString stringWithFormat:@"%.2fcm",[self.users.babyHeadSize floatValue]];
                break;
                
            default:
                break;
        }
        
        return cell;
    }
}

#pragma mark -- cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            self.updateMe.updateTitle = @"修改宝宝昵称";
            self.updateMe.updateValue = self.users.babyNickName;
            self.updateMe.updateIndex = indexPath.row;
            [self.navigationController pushViewController:self.updateMe animated:YES];
        }
            break;
        case 1:
        {
            NSDate *date = [NSDate date];
            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate:date];
            NSDate *localeDate = [date dateByAddingTimeInterval:interval];
            
            ActionSheetDatePicker *datePicker = [ActionSheetDatePicker showPickerWithTitle:@"宝宝生日" datePickerMode:UIDatePickerModeDate selectedDate:localeDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
                [dateFormatter setDateFormat:@"YYYY-MM-dd"];
                
                self.users.babyBirthday = (NSDate *)[dateFormatter stringFromDate:selectedDate];
                
                [self.babyTableView reloadData];
                
            } cancelBlock:^(ActionSheetDatePicker *picker) {
            } origin:tableView];
            
            [datePicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确 定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            [datePicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取 消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            
            datePicker = nil;
        }
            break;
        case 2:
        {
            ActionSheetStringPicker *stringPicker = [ActionSheetStringPicker showPickerWithTitle:@"宝宝性别" rows:@[@"男孩",@"女孩"] initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                self.users.babySex = selectedValue;
                [self.babyTableView reloadData];
            } cancelBlock:^(ActionSheetStringPicker *picker) {
            } origin:tableView];
            
            [stringPicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确 定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            [stringPicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取 消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            
            stringPicker = nil;
        }
            break;
        case 3:
        {
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for(int i = 1;i <= 60;i++)
            {
                [array addObject:[NSString stringWithFormat:@"%d周",i]];
            }
            
            ActionSheetStringPicker *stringPicker = [ActionSheetStringPicker showPickerWithTitle:@"出生孕周" rows:array initialSelection:30 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                
                self.users.babyPregnancyCycle = [NSString stringWithFormat:@"%ld",selectedIndex + 1];
                [self.babyTableView reloadData];
                
            } cancelBlock:^(ActionSheetStringPicker *picker) {
            } origin:tableView];
            
            [stringPicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确 定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            [stringPicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取 消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            
            stringPicker = nil;
        }
            break;
        case 4:
        {
            ActionSheetStringPicker *stringPicker = [ActionSheetStringPicker showPickerWithTitle:@"分娩方式" rows:@[@"自然分娩",@"剖腹产",@"其他"] initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                
                self.users.babyChildbirthType = selectedValue;
                [self.babyTableView reloadData];
            } cancelBlock:^(ActionSheetStringPicker *picker) {
            } origin:tableView];
            
            [stringPicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确 定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            [stringPicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取 消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
            
            stringPicker = nil;
        }
            break;
        case 5:
        {
            self.updateMe.updateTitle = @"修改宝宝出生体长";
            self.updateMe.updateValue = [NSString stringWithFormat:@"%.2f",[self.users.babyLength floatValue]];
            self.updateMe.updateIndex = indexPath.row;
            [self.navigationController pushViewController:self.updateMe animated:YES];
        }
            break;
        case 6:
        {
            self.updateMe.updateTitle = @"修改宝宝出生体重";
            self.updateMe.updateValue = [NSString stringWithFormat:@"%.2f",[self.users.babyBodyWeight floatValue]];
            self.updateMe.updateIndex = indexPath.row;
            [self.navigationController pushViewController:self.updateMe animated:YES];
        }
            break;
        case 7:
        {
            self.updateMe.updateTitle = @"修改宝宝出生头围";
            self.updateMe.updateValue = [NSString stringWithFormat:@"%.2f",[self.users.babyHeadSize floatValue]];
            self.updateMe.updateIndex = indexPath.row;
            [self.navigationController pushViewController:self.updateMe animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- updateMeinformationdelegate
- (void)returnUpdateMeinformationValue:(NSString *)updateValue updateIndex:(NSInteger)updateIndex
{
    switch (updateIndex) {
        case 0:
            self.users.babyNickName = updateValue;
            self.isUpdateValue = NO;
            break;
        case 5:
            self.users.babyLength = updateValue;
            self.isUpdateValue = NO;
            break;
        case 6:
            self.users.babyBodyWeight = updateValue;
            self.isUpdateValue = NO;
            break;
        case 7:
            self.users.babyHeadSize = updateValue;
            self.isUpdateValue = NO;
            break;
        default:
            break;
    }
    [self.babyTableView reloadData];
}

#pragma mark -- 添加宝宝信息
- (void)addBabyClick
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在保存";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if(self.users.babyNickName)
    {
    [dict setObject:self.users.babyNickName forKey:@"nickName"];
    }
    
    if(self.users.babyBirthday)
    {
    [dict setObject:self.users.babyBirthday forKey:@"birthday"];
    }
    
    if([self.users.babySex isEqualToString:@"男孩"])
    {
        [dict setObject:[NSNumber numberWithInt:1] forKey:@"sex"];
    }
    else
    {
       [dict setObject:[NSNumber numberWithInt:0] forKey:@"sex"];
    }
    
    [dict setObject:[NSNumber numberWithInteger:[self.users.babyPregnancyCycle integerValue]] forKey:@"pregnancyCycle"];
    
    if([self.users.babyChildbirthType isEqualToString:@"自然分娩"])
    {
        [dict setObject:@"NORMAL" forKey:@"childbirthType"];
    }
    else if([self.users.babyChildbirthType isEqualToString:@"剖腹产"])
    {
       [dict setObject:@"CAESAREAN" forKey:@"childbirthType"];
    }
    else
    {
        [dict setObject:@"OTHER" forKey:@"childbirthType"];
    }
    
    [dict setObject:[NSNumber numberWithFloat:[self.users.babyLength floatValue]] forKey:@"length"];
    [dict setObject:[NSNumber numberWithFloat:[self.users.babyBodyWeight floatValue]] forKey:@"bodyWeight"];
    [dict setObject:[NSNumber numberWithFloat:[self.users.babyHeadSize floatValue]] forKey:@"headSize"];
    
    
    NSString *post_url = @"";
    //如果大于零就调用宝宝更新接口，否则调用宝宝插入接口
    if(self.users.babyId > 0)
    {
        [dict setObject:[NSNumber numberWithInteger:[self.users.babyId integerValue]] forKey:@"babyId"];
        
        post_url = POST_UPDATE_BABY;
    }
    else
    {
        [dict setObject:[NSNumber numberWithInteger:[self.users.customerId integerValue]] forKey:@"customer.customerId"];
        post_url = POST_SAVEBABY;
    }
    
    [session GET:post_url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if([[responseObject objectForKey:@"result"]isEqualToString:@"SUCCESS"])
        {
            //请求成功后将数据更新到本地
            QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
            
            if(![[responseObject objectForKey:@"data"]isKindOfClass:[NSNull class]])
            {
                NSDictionary *dict = [responseObject objectForKey:@"data"];
                
          
            
                self.users.babyId = [dict objectForKey:@"babyId"];
                
                [qiao updateDataWithModel:self.users];
                
                [self.navigationController.view makeToast:@"保存成功!"                                             duration:1.0 position:CSToastPositionCenter];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self.navigationController.view makeToast:@"保存失败!"
                                                 duration:1.0
                                                 position:CSToastPositionCenter];
            }
            
            self.isUpdateValue = YES;
            [self.delegate showNewView];
            [hud hideAnimated:YES];

        }
        else
        {
            [self.navigationController.view makeToast:@"宝宝数据更新失败!"
                                             duration:1.0
                                             position:CSToastPositionCenter];
        
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
        [hud hideAnimated:YES];
  
     
    }];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark goBack

- (void)goBack{

    if(!self.isUpdateValue){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否退出编辑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
