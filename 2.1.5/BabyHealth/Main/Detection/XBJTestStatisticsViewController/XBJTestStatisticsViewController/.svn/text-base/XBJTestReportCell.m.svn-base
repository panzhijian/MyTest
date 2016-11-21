//
//  XBJTestReportCell.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJTestReportCell.h"
#import "XBJAppHelper.h"

@implementation XBJTestReportCell

- (void)setModel:(XBJTestReportModel *)model andIndex:(NSInteger )index{
    _model = model;
    UIColor *green = [UIColor colorWithRed:108/255.0 green:149/255.0 blue:74/255.0 alpha:1.0];
    UIColor *red = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
//begin 时攀 报告指标更换
    switch (index) {
        case 0:
        {
            self.titleLabel.text = @"颜色/ys";
            self.describeLabel.text = model.color;
            if([model.color isEqualToString:@"棕黄色"])
            {
                self.stateLabel.text = @"正常";
            }
            else
            {
                self.stateLabel.text = @"视具体情况而定";
            }
                    self.contentLab.text=@"正常颜色:\n 1)黄褐色。婴儿的便便呈现黄绿色或金黄色，随着宝宝消化能力的提升，便便颜色逐渐加深呈现黄褐色。\n异常颜色：\n 1)绿色：常见于小儿肠炎，或食用大量绿色蔬菜。此外，有些吃富含铁质配方奶的宝宝，排出的粪便会呈暗绿色。\n 2)白色、灰白色：常见于阻塞性黄疸。\n 3)红色便：常见于肛裂及痔疮等，或食用大量番茄、西瓜等\n 4)果酱色：常见于肠套叠，或食用大量巧克力等；\n 5)黑色（柏油色）：常见于上消化道出血。如果进食动物血、猪肝等含铁多的食物也可使粪便呈黑色，但一般为灰黑色无光泽，做隐血试验阴性可帮助鉴别。";

        }
            break;
        case 1:
        {
            self.titleLabel.text = @"性状/xz";
            self.describeLabel.text = model.trait;
            self.stateLabel.text = [XBJAppHelper britishSinoConversion:model.traitResult];
            self.contentLab.text=@"正常形态:\n 1)成形软便。婴儿便便呈现糊状，随着宝宝肠道功能逐步成熟，便便逐步为成形软 \n异常形态：\n 1)泡沫样大便：常见于偏食淀粉或糖类食物过多时。\n 2)奇臭难闻大便：常见于偏食含蛋白质的食物过多时。\n 3)蛋花汤样大便：粘液性或脓血性便，常见于病毒性肠炎和致病性大肠杆菌性肠炎等。\n 4)豆腐渣样大便：常见于霉菌引起的肠炎。\n 5)粥样或水样稀便：见于急性肠炎、食物中毒等。\n 6)乳凝乳块便：见于婴儿消化不良、婴儿腹泻、脂肪或酪蛋白消化不全等。\n 7)球形硬便：见于便秘、偏食等。";

        }
            break;
        case 2:
        {
            self.titleLabel.text = @"红细胞/rbc";
            self.describeLabel.text = model.rbc;
            self.stateLabel.text = [XBJAppHelper britishSinoConversion:model.rbcResult];
                       self.contentLab.text=@"正常参考值:\n 1)未见（-）\n异常情况：\n 1)（+）的多少代表便便中红细胞的数量情况。红细胞的出现和增多，常见于下消化道炎症或出血。上消化道出血时，由于胃液的消化作用，红细胞已破坏，粪便中难见到，可配合隐血检测结果分析。";
        }
            break;
        case 3:
        {
            self.titleLabel.text = @"白细胞/f-wbc";
            self.describeLabel.text = model.wbc;
            self.stateLabel.text = [XBJAppHelper britishSinoConversion:model.wbcResult];
                     self.contentLab.text=@"正常参考值：\n 1)未见（-）或少许\n异常情况：\n 1)（+）的多少代表便便中白细胞的数量情况。白细胞数量与炎症轻重及部位有关。若是细菌感染，除了可见大便中含有脓性物质，会检测出较多白细胞或脓细胞，同时也可检测出红细胞。若是病毒感染，以稀水便为主，会检测出少许白、红细胞。";

        }
            break;
        case 4:
        {
            self.titleLabel.text = @"脂肪球/zfq";
            self.describeLabel.text = model.zfq;
            self.stateLabel.text = [XBJAppHelper britishSinoConversion:model.zfqResult];
                       self.contentLab.text=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示粪便中存在脂肪球。粪便脂肪检测可作为了解消化功能和胃肠道吸收功能的参考指标。宝宝消化不良、吸收能力减退时，便便中可能会检出脂肪球。";
        }
            break;
        case 5:
        {
            self.titleLabel.text = @"寄生虫/jsc";
            self.describeLabel.text = model.bcl;
            self.stateLabel.text = [XBJAppHelper britishSinoConversion:model.bclResult];
                self.contentLab.text=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示宝宝肠道感染寄生虫。大多数肠道寄生虫感染与卫生条件、生活习惯、健康意识和家庭聚集性等因素有关。肠道寄生虫感染可能引起腹泻、腹痛、营养吸收不良等症状。肠道寄生虫种类较多，如检出，建议咨询正规医院专科医生，使用对应的驱虫药治疗。";

        }
            break;
        case 6:
        {
            self.titleLabel.text = @"虫卵/cl";
            self.describeLabel.text = model.fob;
            self.stateLabel.text = [XBJAppHelper britishSinoConversion:model.fobResult];
                    self.contentLab.text=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示宝宝肠道感染寄生虫。虫卵容易漏检，如怀疑感染寄生虫，建议多次检查。肠道寄生虫种类较多，如检出，建议咨询正规医院专科医生，使用对应的驱虫药治疗。";

        }
            break;
        case 7:
        {
            self.titleLabel.text = @"隐雪试验/fob";
            self.describeLabel.text = model.rwm;
            self.stateLabel.text = [XBJAppHelper britishSinoConversion:model.rwmResult];
                     self.contentLab.text=@"正常参考值：\n 1)阴性（-）\n异常情况：\n 1)阳性（+）表示宝宝消化道出现少量出血现象。肠道隐性出血可能引起宝宝黑便、便血等症状。";

        }
            break;
        case 8:
        {
            self.titleLabel.text = @"霉菌/mj";
            self.describeLabel.text = model.yeast;
            self.stateLabel.text = [XBJAppHelper britishSinoConversion:model.yeastResult];
                     self.contentLab.text=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示宝宝肠道感染霉菌。宝宝腹泻、红屁屁、大便豆渣样等，可能与霉菌感染相关。抗生素或消毒剂滥用、过于干净养育宝宝等可造成肠道菌群失调，就容易出现霉菌感染。";
        }
            break;
        case 9:
        {
            self.titleLabel.text = @"A群轮状病毒抗原/rv";
            self.describeLabel.text = model.ava;
            self.stateLabel.text = [XBJAppHelper britishSinoConversion:model.avaResult];
                      self.contentLab.text=@"正常参考值：\n 1)阴性（-）\n异常情况：\n 1)阳性（+）表示A群轮状病毒感染。轮状病毒引起的胃肠炎俗称“秋季腹泻”，发热、呕吐、便便成蛋花汤样，一般与轮状病毒感染相关。轮状病毒性胃肠炎对宝宝造成的危害就是呕吐及腹泻后的脱水，建议提供充足水分、适当添加电解质、服用益生菌。";

        }
            break;
    
        default:
            break;
    }
    if([self.stateLabel.text isEqualToString:@"正常"]){
        self.stateLabel.textColor = green;
    }else{
        self.stateLabel.textColor = red;
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
- (void)setOpen:(BOOL)open{
    if(open){
        
        self.contentLab.hidden=NO;
  
    }else{
        self.contentLab.hidden=YES;

    }
   
}
+(CGFloat)rowheight:(NSString*)contentText
{
    
    CGSize  contectSize = CGSizeMake(SCREEN_WIDTH-40, 2000);
    
    NSDictionary * attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGRect addressSize = [contentText boundingRectWithSize:contectSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attributes context:nil];
 
    return addressSize.size.height+35+3;
    
}

@end
