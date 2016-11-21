//
//  XBJAddRecordDescribeCell.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/4.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJAddRecordDescribeCell.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
@implementation XBJAddRecordDescribeCell


- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
    self.textView.delegate = self;
    
    NSArray *arr = @[_imageView1,_imageView2,_imageView3];
    for(int i=0;i<arr.count;i++){
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGS:)];
        UIImageView *imageV = arr[i];
        [imageV addGestureRecognizer:tgr];
    }
    self.images = [NSMutableArray new];
    self.defaultImage = [UIImage imageNamed:@"camera.png"];
    self.imageView1.image = self.defaultImage;
    [self.images addObject:self.defaultImage];
    
}

- (void)setGrowModel:(XBJGrowRecordModel *)growModel{
    _growModel = growModel;
    self.textView.text = growModel.remark;
    [self setImagesWith:growModel.imagePaths];
    self.textView.placeholder = @"选填，可留下宝宝的生长变化，让他/她的成长多一份回忆和感动。";
}

- (void)setShitModel:(XBJShitRecordModel *)shitModel{
    _shitModel = shitModel;
    self.textView.text = shitModel.remark;
    [self setImagesWith:shitModel.imagePaths];
    self.textView.placeholder = @"选填，可记录宝宝排便的异常情况，如酸臭，连续三天没拉等。";
}

- (void)setDrugModel:(XBJDrugRecordModel *)drugModel{
    _drugModel = drugModel;
    self.textView.text = drugModel.remark;
    [self setImagesWith:drugModel.imagePaths];
    self.textView.placeholder = @"选填，可添加用药的目的，描述用药前后宝宝情况的变化。";
}

- (void)setImagesWith:(NSArray *)imageArr{
    [self.images removeAllObjects];
    [self.images addObjectsFromArray:imageArr];
    [self.images addObject:self.defaultImage];
    
    NSArray *arr = @[_imageView1,_imageView2,_imageView3];
    NSInteger minCount = self.images.count>arr.count?arr.count:self.images.count;
    _imageView1.hidden = YES;
    _imageView2.hidden = YES;
    _imageView3.hidden = YES;
    for(int i=0;i<minCount;i++){
        UIImageView *imageV = arr[i];
        id image = self.images[i];
        if([image isKindOfClass:[UIImage class]]){
            imageV.image        = image;
            
        }else if([image isKindOfClass:[NSString class]]){
            NSMutableString *imageUrl = [NSMutableString stringWithFormat:@"%@%@",IMAGE_IP,(NSString *)image];
            NSString *newStr = [imageUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
            NSURL *url = [NSURL URLWithString:newStr];
            [imageV sd_setImageWithURL:url completed:^(UIImage *sdimage, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //                NSString *urlstr = [imageURL absoluteString];
                NSInteger index = [self.images indexOfObject:image];
                [self.images replaceObjectAtIndex:index withObject:sdimage];
            }];
        }
        imageV.hidden       = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)tapGS:(UIGestureRecognizer *)tgr {
    UIImageView *imageV = (UIImageView *)tgr.view;
    UIImage *image = self.images.lastObject;
    if(imageV.image==image){
        NSLog(@"打开相册添加照片");
        if(self.addImageBlock){
            self.addImageBlock();
        }
    }else{
        NSLog(@"删除照片");
        self.deleteIndex = [self.images indexOfObject:imageV.image];
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"删除图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self.images removeObjectAtIndex:self.deleteIndex];
        [self.images removeLastObject];
        NSArray *array = [NSArray arrayWithArray:self.images];
        [self setImagesWith:array];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    self.growModel.remark = textView.text.length?textView.text:nil;
    self.shitModel.remark = textView.text.length?textView.text:nil;
    self.drugModel.remark = textView.text.length?textView.text:nil;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}


@end
