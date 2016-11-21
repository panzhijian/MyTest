//
//  XBJTestDepictPopViewCell.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJTestDepictPopViewCell.h"
#import "XBJAppHelper.h"

@implementation XBJTestDepictPopViewCell

- (void)setModel:(XBJTestReportModel *)model andIndex:(NSInteger )index{
    _model = model;
    //begin 时攀 报告指标更换
    switch (index) {
        case 0:
        {
            self.titleLabel.text = @"颜色/ys";
            self.depictLabel.text = [XBJAppHelper britishSinoConversion:model.color];
            self.contentLabel.text = model.colorRemark;
        }
            break;
        case 1:
        {
            self.titleLabel.text = @"性状/xz";
            self.depictLabel.text = [XBJAppHelper britishSinoConversion:model.trait];
            self.contentLabel.text = model.traitRemark;
        }
            break;
        case 2:
        {
            self.titleLabel.text = @"红细胞/rbc";
            self.depictLabel.text = [XBJAppHelper britishSinoConversion:model.rbc];
            self.contentLabel.text = model.rbcRemark;
        }
            break;
        case 3:
        {
            self.titleLabel.text = @"白细胞/wbc";
            self.depictLabel.text = [XBJAppHelper britishSinoConversion:model.wbc];
            self.contentLabel.text = model.wbcRemark;
        }
            break;
        case 4:
        {
            self.titleLabel.text = @"脂肪球/fat";
            self.depictLabel.text = [XBJAppHelper britishSinoConversion:model.zfq];
            self.contentLabel.text = model.zfqRemark;
        }
            break;
        case 5:
        {
            self.titleLabel.text = @"寄生虫/jsc";
            self.depictLabel.text = [XBJAppHelper britishSinoConversion:model.bcl];
            self.contentLabel.text = model.bclRemark;
        }
            break;
        case 6:
        {
            self.titleLabel.text = @"隐血试验/qx";
            self.depictLabel.text = [XBJAppHelper britishSinoConversion:model.fob];
            self.contentLabel.text = model.fobRemark;
        }
            break;
        default:
            break;
    }
}

- (void)configerCellWith:(NSInteger )index{
    //begin 时攀 报告指标更换
        switch (index) {
            case 0:
            {
                self.titleLabel.text = @"颜色/ys";
                self.depictLabel.text = @"棕黄色";
                self.contentLabel.text = @"正常的婴儿粪便因含胆绿素而呈现黄绿色或金黄色。随着宝宝消化能力的提升，幼儿的粪便颜色逐渐加深，逐步呈现棕黄色。";
            }
                break;
            case 1:
            {
                self.titleLabel.text = @"性状/xz";
                self.depictLabel.text = @"有形软便";
                self.contentLabel.text = @"正常的婴儿粪便呈现糊状，随着宝宝消化能力的提升，肠道逐步成熟，幼儿的粪便逐步为成形便，条带状软便。";
            }
                break;
            case 2:
            {
                self.titleLabel.text = @"红细胞/rbc";
                self.depictLabel.text = @"未见（-）";
                self.contentLabel.text = @"正常粪便中无红细胞，检测结果为未见（-）。\n病理情况下，下消化道炎症或出血时，粪便中可出现数量不等的红细胞，红细胞呈草绿色、略带折光性的圆盘状，有时可因粪便pH影响，而呈皱缩状。上消化道出血时，由于胃液的消化作用，红细胞已破坏，粪便中也难见到，可配合隐血检测结果分析。";
            }
                break;
            case 3:
            {
                self.titleLabel.text = @"白细胞/wbc";
                self.depictLabel.text = @"未见（-）";
                self.contentLabel.text = @"正常粪便无或偶见白细胞，检测结果为未见（-）。\n病理情况下，白细胞数量与炎症轻重及部位有关。肠炎时，白细胞增多不明显，呈分散存在；细菌性痢疾、溃疡性结肠炎时，可见大量白细胞或成堆出现的脓细胞，以及吞食异物的小吞噬细胞。";
            }
                break;
            case 4:
            {
                self.titleLabel.text = @"脂肪球/fat";
                self.depictLabel.text = @"未检出（-）";
                self.contentLabel.text = @"正常粪便中极少见脂肪球，检测结果为未检出（-）。\n当消化道发生病变时，消化功能减退，缺乏脂肪酶或胃蛋白酶，造成消化不良和吸收障碍，因而使脂肪水解不全，出现脂肪球等食物残渣。";
            }
                break;
            case 5:
            {
                self.titleLabel.text = @"寄生虫/jsc";
                self.depictLabel.text = @"未见（-）";
                self.contentLabel.text = @"正常粪便中无寄生虫，检测结果为未见（-）。";
            }
                break;
            case 6:
            {
                self.titleLabel.text = @"虫卵/cl";
                self.depictLabel.text = @"未见（-）";
                self.contentLabel.text = @"正常粪便中无蛔虫卵及其他虫卵，检测结果为未见（-）。";
            }
                break;
            case 7:
            {
                self.titleLabel.text = @"霉菌/mj";
                self.depictLabel.text = @"未检出（-）";
                self.contentLabel.text = @"正常粪便中无霉菌，检测结果为未检出（-）。";
            }
                break;
            case 8:
            {
                self.titleLabel.text = @"隐血试验/qx";
                self.depictLabel.text = @"阴性（-）";
                self.contentLabel.text = @"正常粪便隐血试验结果为阴性（-）。\n大便隐血试验是测定消化道出血的一种方法，主要用于检验肉眼不可见的少量出血。";
            }
                break;
            case 9:
            {
                self.titleLabel.text = @"A群轮状病毒抗原/rv";
                self.depictLabel.text = @"阴性（-）";
                self.contentLabel.text = @"正常粪便A群轮状病毒抗原检测结果为阴性（-）。\n轮状病毒主要入侵婴幼儿，被感染的婴幼儿初期出现轻度上呼吸道症状，随后很快会引起呕吐和急性腹泻，常常会导致脱水。";
            }
                break;
            default:
                break;
        }
}

- (void)setOpen:(BOOL)open{
    if(open){
        self.contentBottom.priority = 750;
        self.imageBottom.priority = 250;
        self.openImageView.image = [UIImage imageNamed:@"close"];
        self.contentLabel.hidden = NO;
    }else{
        self.imageBottom.priority = 750;
        self.contentBottom.priority = 250;
        self.openImageView.image = [UIImage imageNamed:@"open"];
        self.contentLabel.hidden = YES;
    }
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
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
