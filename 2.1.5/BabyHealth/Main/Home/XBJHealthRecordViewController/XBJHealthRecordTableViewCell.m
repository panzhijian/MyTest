//
//  XBJHealthRecordTableViewCell.m
//  ChartDemo
//
//  Created by jxmac2 on 16/6/30.
//  Copyright © 2016年 jxmac2. All rights reserved.
//

#import "XBJHealthRecordTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "XBJAppHelper.h"
#import "SHandle.h"

@implementation XBJHealthRecordTableViewCell
//begin 2016.10.14 时攀 年龄计算提取
-(NSString *)ageStringGrow:(XBJGrowRecordModel*)model
{
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    //当前时间和宝宝出生时间差多少秒
    NSString* timeStr = [NSString stringWithFormat:@"%@ 00:00:00",users.babyBirthday];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *userDate = [formatter dateFromString:timeStr];
    
    NSArray *dateArr;
    if (model) {
        NSString* timeStr1 = [NSString stringWithFormat:@"%@ 00:00:00",model.recordDate];
        //获取目标时间到出生的秒数
        NSDate *userDate1 = [formatter dateFromString:timeStr1];
        
        dateArr = [SHandle countAge:userDate aDate:userDate1];
    }
    else{
        dateArr = [SHandle countAge:userDate aDate:nil];
    }
    
    NSInteger years = [dateArr[0] integerValue];
    NSInteger months = [dateArr[1] integerValue];
    NSInteger days = [dateArr[2] integerValue];
    
    NSString *timeString;
    if (model) {
        timeString  = [NSString stringWithFormat:@"%@ %ld岁%ld个月%ld天",model.recordDate,years,months,days];
    }else
    {
        timeString  = [NSString stringWithFormat:@"%ld岁%ld个月%ld天",years,months,days];
    }
    
    return timeString;
}
//end 2016.10.14 时攀 年龄计算提取
//begin 2016.10.14 时攀 年龄计算提取
-(NSString *)ageStringShit:(XBJShitRecordModel *)model
{
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    //当前时间和宝宝出生时间差多少秒
    NSString* timeStr = [NSString stringWithFormat:@"%@ 00:00:00",users.babyBirthday];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *userDate = [formatter dateFromString:timeStr];
    
    NSArray *dateArr;
    if (model) {
        NSString* timeStr1 = [NSString stringWithFormat:@"%@",model.createTime];
        //获取目标时间到出生的秒数
        NSDate *userDate1 = [formatter dateFromString:timeStr1];
        
        dateArr = [SHandle countAge:userDate aDate:userDate1];
    }
    else{
        dateArr = [SHandle countAge:userDate aDate:nil];
    }
    
    NSInteger years = [dateArr[0] integerValue];
    NSInteger months = [dateArr[1] integerValue];
    NSInteger days = [dateArr[2] integerValue];
    
    NSString *timeString;
    if (model) {
        timeString  = [NSString stringWithFormat:@"%@ %ld岁%ld个月%ld天",model.createTime,years,months,days];
    }else
    {
        timeString  = [NSString stringWithFormat:@"%ld岁%ld个月%ld天",years,months,days];
    }
    
    return timeString;
}
//end 2016.10.14 时攀 年龄计算提取
//begin 2016.10.14 时攀 年龄计算提取
-(NSString *)ageStringDrug:(XBJDrugRecordModel *)model
{
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    //当前时间和宝宝出生时间差多少秒
    NSString* timeStr = [NSString stringWithFormat:@"%@ 00:00:00",users.babyBirthday];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *userDate = [formatter dateFromString:timeStr];
    
    NSArray *dateArr;
    if (model) {
        NSString* timeStr1 = [NSString stringWithFormat:@"%@",model.createTime];
        //获取目标时间到出生的秒数
        NSDate *userDate1 = [formatter dateFromString:timeStr1];
        
        dateArr = [SHandle countAge:userDate aDate:userDate1];
    }
    else{
        dateArr = [SHandle countAge:userDate aDate:nil];
    }
    
    NSInteger years = [dateArr[0] integerValue];
    NSInteger months = [dateArr[1] integerValue];
    NSInteger days = [dateArr[2] integerValue];
    
    NSString *timeString;
    if (model) {
        timeString  = [NSString stringWithFormat:@"%@ %ld岁%ld个月%ld天",model.createTime,years,months,days];
    }else
    {
        timeString  = [NSString stringWithFormat:@"%ld岁%ld个月%ld天",years,months,days];
    }
    
    return timeString;
}
//end 2016.10.14 时攀 年龄计算提取
- (void)setGrowModel:(XBJGrowRecordModel *)model{
    _growModel = model;
    
    if(model.recordDate.length>10){
        model.recordDate = [model.recordDate substringToIndex:10];
    }
    //    NSString *string = [NSString stringWithFormat:@"%@  %@",model.recordDate,model.babyAge];
    NSString *string = [self ageStringGrow:model];
    self.dateLabel.text = string;
    self.titleLabel.text = [NSString stringWithFormat:@"身高：%.2fcm 体重：%.2fkg 头围：%.2fcm",[model.length floatValue],[model.bodyWeight floatValue],[model.headSize floatValue]];
    self.remarkLabel.text = model.remark;
    
    if(model.imagePaths.count==0){
        self.imageBottom.priority = 250;
        self.labelBottom.priority = 750;
    }else{
        self.imageBottom.priority = 750;
        self.labelBottom.priority = 250;
    }
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
    
    [self loadWebImageWith:model.imagePaths];    
}

- (void)setShitModel:(XBJShitRecordModel *)model{
    _shitModel = model;
    
    //    NSString *string = [NSString stringWithFormat:@"%@  %@",model.createTime,model.babyAge];
    NSString *string = [self ageStringShit:model];
    self.dateLabel.text = string;
    NSString *trait = [XBJAppHelper britishSinoConversion:model.trait];
    NSString *color = [XBJAppHelper britishSinoConversion:model.color];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %@",trait,color];
    self.remarkLabel.text = model.remark;
    
    if(model.imagePaths.count==0){
        self.imageBottom.priority = 250;
        self.labelBottom.priority = 750;
    }else{
        self.imageBottom.priority = 750;
        self.labelBottom.priority = 250;
    }
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
    
    [self loadWebImageWith:model.imagePaths];
}

- (void)setDrugModel:(XBJDrugRecordModel *)model{
    _drugModel = model;
    
    //    NSString *string = [NSString stringWithFormat:@"%@  %@",model.createTime,model.babyAge];
    NSString *string = [self ageStringDrug:model];
    self.dateLabel.text = string;

    
    NSMutableString *content = [[NSMutableString alloc] init];
//    model.medicineInfos = @[@{@"medicineName":@"青霉素",@"measure":@"1"}];
    for(NSDictionary *dic in model.medicineInfos){
        NSString *medicineName = dic[@"medicineName"];
        NSString *measure = dic[@"measure"];
        NSString *string;
        if(dic==model.medicineInfos.lastObject){
            string = [[NSString alloc] initWithFormat:@"%@ %@",medicineName,measure];
        }else{
            string = [[NSString alloc] initWithFormat:@"%@ %@\n",medicineName,measure];
        }
        [content appendString:string];
    }
    self.titleLabel.text = content;
    self.remarkLabel.text = model.remark;
    
    if(model.imagePaths.count==0){
        self.imageBottom.priority = 250;
        self.labelBottom.priority = 750;
    }else{
        self.imageBottom.priority = 750;
        self.labelBottom.priority = 250;
    }
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
    
    [self loadWebImageWith:model.imagePaths];
}

- (void)loadWebImageWith:(NSArray *)imageUrls
{
    NSArray *imageVs = @[self.imageView1,self.imageView2,self.imageView3];
    for(UIImageView *imageV in imageVs){
        imageV.hidden = YES;
    }
    
    int i=0;
    for(NSString *url in imageUrls){
        NSMutableString *string = [NSMutableString stringWithFormat:@"%@%@",IMAGE_IP,url];
        NSString *newStr = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        if(i>=3){
            break;
        }
        UIImageView *imageV = imageVs[i];
        [imageV sd_setImageWithURL:[NSURL URLWithString:newStr]];
        imageV.hidden = NO;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomImage:)];
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:tap];
        
        i++;
    }
}

//begin  2016-9.28 时攀 放大点击事件
-(void)zoomImage:(UITapGestureRecognizer *)tap
{
    UIImageView * imgV = (UIImageView *)tap.view;
    if (self.zoom_block) {
        self.zoom_block(imgV.image);
    }
    
}
//end 2016-9.28 时攀 放大点击事件
- (IBAction)editBtnAction:(id)sender {
    if(self.edit_block){
        self.edit_block(self.index);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
