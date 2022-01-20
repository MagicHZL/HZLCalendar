//
//  AthDayCell.h
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AthDayModel.h"
#import "AthCalendarTool.h"

@interface AthDayCell : UICollectionViewCell

@property(nonatomic,strong)AthDayModel *selectMo;

@property(nonatomic,strong)AthDayModel *model;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIButton *haveClass;

@end
