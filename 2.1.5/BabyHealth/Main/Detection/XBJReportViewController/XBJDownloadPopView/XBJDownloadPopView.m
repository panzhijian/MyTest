//
//  XBJDownloadPopView.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJDownloadPopView.h"
#import "Masonry.h"
#import "SDWebImageManager.h"

@implementation XBJDownloadPopView

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.type = MMPopupTypeCustom;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(frame.size);
    }];
}

- (void)setImages:(NSArray *)images{
    _images = images;
    
    CGFloat size = 0.0;
    for(NSDictionary *dic in images){
        
        NSString *fileSize = dic[@"fileSize"];
        
        
        // begain  潘志健  10-20  图片大小计算错误
        //        if(fileSize.length>2){
        //            float imageSize = [[fileSize substringToIndex:fileSize.length-2] floatValue];
        //            size = size + imageSize;
        //        }
        
        CGFloat imageSize = [fileSize floatValue];
        size = size + imageSize;
        
        
        //end  潘志健 10-20  图片大小计算错误
        
        
    }
    if(size>1024*1024)
    {
        self.sizeLabel.text = [NSString stringWithFormat:@"图片大小为%.1fM",size/(1024.0*1024.0)];
        
    }else if((size<(1024*1024))&&(size>1024))
    {
        self.sizeLabel.text = [NSString stringWithFormat:@"图片大小为%.1fKB",size/1024.0];
    }else{
        self.sizeLabel.text = [NSString stringWithFormat:@"图片大小为%.1fB",size/1024.0];
        
    }
    

}

- (IBAction)confirmBtnAction:(id)sender {
    
    [self saveImageToIphone];
    
    [self hide];
}

- (void)saveImageToIphone{
    
    /**
     *  将图片保存到iPhone本地相册
     *  UIImage *image            图片对象
     *  id completionTarget       响应方法对象
     *  SEL completionSelector    方法
     *  void *contextInfo
     */
    for(NSDictionary *dic in self.images){
        NSMutableString *string = [NSMutableString stringWithFormat:@"%@%@",IMAGE_IP,dic[@"filePath"]];
        
       NSString *newStr = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];

        NSURL *url = [NSURL URLWithString:newStr];
        [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if(image){
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }else{
                if(self.block){
                    self.block(NO);
                }
            }
        }];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        if(self.block){
            self.block(YES);
        }
        
    }else{
        
        if(self.block){
            self.block(NO);
        }
    }
}


/*
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
//        UIView *containerView = [[[UINib nibWithNibName:@"CustomSegmented" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
//        containerView.frame = CGRectMake(0, 0, WIDTH, 40);
//        [self addSubview:containerView];
    }
    return self;
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
