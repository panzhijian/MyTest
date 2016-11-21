//
//  XBJSampleInfoViewController.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/6.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJSampleInfoViewController.h"
#import "XBJAddRecordCalendarCell.h"
#import "XBJBindTableViewCell.h"
#import "XBJProtocolViewController.h"
#import "XBJSubmitSuccessViewController.h"
#import "XBJNetWork.h"
#import "XBJAppHelper.h"
#import "UUDatePicker.h"
#import "CyUserDefaults.h"
#import"XBJAddRecordDescribeCell.h"
@interface XBJSampleInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (strong, nonatomic) NSArray *colorArray;
@property (strong, nonatomic) NSArray *traitArray;
@property (assign, nonatomic) BOOL colorPicker;
@property (weak, nonatomic) IBOutlet UIImageView *agreeImage;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIView *clearView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UUDatePicker *datePicker;

@end

@implementation XBJSampleInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"样品信息";
    self.tableView.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9373 blue:0.9490 alpha:1.0];
    
    XBJAddRecordDescribeCell *addRecordDescribeCell=[[[NSBundle mainBundle] loadNibNamed:@"XBJAddRecordDescribeCell" owner:self options:nil] lastObject ];
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"XBJAddRecordCalendarCell" bundle:nil] forCellReuseIdentifier:@"XBJAddRecordCalendarCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJBindTableViewCell" bundle:nil] forCellReuseIdentifier:@"XBJBindTableViewCell"];
    
    
    _tableView.tableFooterView=addRecordDescribeCell;
    
    self.submitBtn.layer.cornerRadius = self.submitBtn.bounds.size.height/2.0;
    self.colorArray = @[@"黑褐色",@"棕色",@"黄色",@"绿色",@"红色",@"灰白色"];
    self.traitArray = @[@"水样",@"很稀",@"粘稠",@"一般",@"较干",@"干硬"];
    
    self.agreeBtn.selected = YES;
    self.agreeImage.image = [UIImage imageNamed:@"login_tick"];
    
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
        self.bind_model.time = date;
    }];
    self.agreeImage.image = [UIImage imageNamed:@"login_tick"];
    self.agreeBtn.selected = YES;
}
- (void)datePickerHide{
    self.clearView.hidden  = YES;
    self.pickerView.hidden = YES;
    self.datePicker.hidden = YES;
}
#pragma mark - tableView delegate/dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 9;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(indexPath.row==0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"XBJAddRecordCalendarCell"];
        XBJAddRecordCalendarCell *newCell = (XBJAddRecordCalendarCell *)cell;
        newCell.titleLabel.text = @"采样时间：";
        
        NSDate * date = [NSDate date];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString * dateString = [dateFormatter stringFromDate:date];
        newCell.dateLabel.text = dateString;
        self.bind_model.time = dateString;
        
        __weak __typeof__(self) weakSelf = self;
        
        //  block的实现
        [newCell setBlock:^(){
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            [strongSelf.view endEditing:YES];
            strongSelf.clearView.hidden = NO;
            strongSelf.datePicker.hidden = NO;
        }];

    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"XBJBindTableViewCell"];
        XBJBindTableViewCell *newCell = (XBJBindTableViewCell *)cell;
        newCell.textField.userInteractionEnabled = NO;
        newCell.scanBtn.hidden = YES;
        newCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if(indexPath.row==1){
            newCell.titleLabel.text = @"本次排便性状：";
        }else{
            newCell.titleLabel.text = @"本次排便颜色：";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==2){
        self.colorPicker = YES;
        self.clearView.hidden = NO;
        self.pickerView.hidden = NO;
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
        [self.pickerView reloadAllComponents];
    }else if(indexPath.row==1){
        self.colorPicker = NO;
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
    if(self.colorPicker){
        XBJBindTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell.textField.text = self.colorArray[row];
        cell.textField.textAlignment = NSTextAlignmentRight;
        self.bind_model.color = self.colorArray[row];
    }else{
        XBJBindTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.textField.textAlignment = NSTextAlignmentRight;
        cell.textField.text = self.traitArray[row];
        self.bind_model.trait = self.traitArray[row];
    }
}

- (IBAction)agreeBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        self.agreeImage.image = [UIImage imageNamed:@"login_tick"];
    }else{
        self.agreeImage.image = [UIImage imageNamed:@"login_untick"];
    }
}
- (IBAction)wordBtnAction:(id)sender {
    XBJProtocolViewController *vc = [XBJProtocolViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)submitBtnAction:(id)sender {
    
    if(self.bind_model.trait.length==0){
        [self showToastWith:@"性状不能为空"];
        return;
    }else if(self.bind_model.color.length==0){
        [self showToastWith:@"颜色不能为空"];
        return;
    }else if(self.agreeBtn.selected==NO){
        [self showToastWith:@"请阅读并同意检测服务条款及知情同意书"];
        return;
    }
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    
    NSString *address = [NSString stringWithFormat:@"%@%@",self.bind_model.province,self.bind_model.address];
    [[XBJNetWork sharedInstance] bindWithBabyID:babyId sampleCode:self.bind_model.code collectTime:self.bind_model.time contactName:self.bind_model.contactName mobile:self.bind_model.mobile address:address color:self.bind_model.color trait:self.bind_model.trait block:^(NSNumber *result,NSString *msg, NSError *error) {
        if(error){
            [self showToastWith:error.description];
        }else{
            if([result intValue]==1){
                [CyUserDefaults saveValue:@"1" forkey:@"firstBind"];
                XBJSubmitSuccessViewController *vc = [XBJSubmitSuccessViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self showToastWith:msg];
            }
        }
    }];
    return;
    
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
