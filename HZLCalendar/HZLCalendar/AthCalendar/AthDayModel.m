//
//  AthDayModel.m
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import "AthDayModel.h"
#import "AthCalendarTool.h"

@implementation AthDayModel


-(NSInteger)week{
    
    return [AthCalendarTool weekOfYearFromYear:self.year month:self.moth day:self.day];
    
}



@end
