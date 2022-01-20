//
//  AthMonthModel.m
//  Athena_iOS
//
//  Created by 郝忠良 on 2018/3/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import "AthMonthModel.h"
#import "AthDayModel.h"
#import "AthCalendarTool.h"

@implementation AthMonthModel

-(void)setDatas:(NSDictionary *)datas{
    
    _datas = datas;
    
    for (NSString *key in datas) {
        
        NSArray *arr = [key componentsSeparatedByString:@"-"];
        
        NSInteger dayNum = [[arr lastObject] integerValue];
        
        NSDictionary *val = datas[key];
        
        for (AthDayModel *day in self.days) {
            
            if (day.day == dayNum && day.moth == self.month) {
                
                day.isHaveDatas = YES;
                day.conut = [NSString stringWithFormat:@"%@",val[@"count"]];
                day.ids = [NSString stringWithFormat:@"%@",val[@"ids"]];
                day.date = key;
            }
            
        }
    }
    
}



-(NSMutableArray *)days{
    
    
    if (self.isOnlyShowOneWeek) {
            
        
        AthDayModel *curDay = [AthCalendarTool currentDay];
        
        NSInteger weekNum = curDay.week;
        
        NSMutableArray *onlyOneWeeks = [NSMutableArray array];
        
        for (AthDayModel *subDay in _days) {
            
            if (subDay.week == weekNum) {
                
                [onlyOneWeeks addObject:subDay];
            }
            
        }
        
//        [onlyOneWeeks insertObject:[_days firstObject] atIndex:0];
        
        return onlyOneWeeks;
        
    }
    
    return _days;
    
    
}


@end
