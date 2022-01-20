//
//  AthDayCell.m
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import "AthDayCell.h"

@implementation AthDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.dayLabel.layer.cornerRadius = 5;
    self.dayLabel.layer.masksToBounds = YES;
}

-(void)setModel:(AthDayModel *)model{
    
    _model = model;
    
    self.dayLabel.text = [NSString stringWithFormat:@"%.2ld",model.day];
    
    if (model.currentMonth == model.moth) {
        
        self.dayLabel.textColor = COLOR_WITH_HEX(0x333333);
        
    }else{
        
        self.dayLabel.textColor = COLOR_WITH_HEX(0xb8b8b8);
    }
    
    if (self.model.isCurrent) {
        
//        self.dayLabel.backgroundColor = [UIColor whiteColor];
        if (self.selectMo == nil) {
            
            self.selectMo = model;
            
        }
        self.dayLabel.text = @"今";
        self.dayLabel.textColor = COLOR_WITH_HEX(0xeb0000);
    
    }
    
    if (self.model.day == self.selectMo.day && self.model.year == self.selectMo.year && self.model.moth == self.selectMo.moth && !self.model.isNext && !self.model.isLast   ) {
        
        self.dayLabel.backgroundColor = COLOR_WITH_HEX(0xff8200);
        
        if (self.model.isCurrent) {
            
            self.dayLabel.textColor = [UIColor whiteColor];//COLOR_WITH_HEX(0xeb0000)
        }else{
            
            self.dayLabel.textColor = [UIColor whiteColor];
        }
        
        self.haveClass.backgroundColor = [UIColor whiteColor];
        
    }else{
        
        self.dayLabel.backgroundColor = [UIColor clearColor];
        self.haveClass.backgroundColor = [UIColor colorWithRed:ColorValue(216) green:ColorValue(216) blue:ColorValue(216) alpha:1];
        
    }
    
    self.haveClass.hidden = !model.isHaveDatas;
    
    
}

@end
