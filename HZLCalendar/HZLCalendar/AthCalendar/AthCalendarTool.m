//
//  AthCalendarTool.m
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import "AthCalendarTool.h"
#import "AthDayModel.h"

@implementation AthCalendarTool

+(NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%ld-%.2ld-%.2ld",year,month,day]];
    
    if(date == nil){
        
        date = [NSDate date];
        
    }
    
    return date;
}

+(AthDayModel*)currentDay{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:[NSDate date]];
    
    AthDayModel *model = [[AthDayModel alloc] init];
    model.day = components.day;
    model.moth = components.month;
    model.year = components.year;
    
    return model;
    
}




+(NSInteger)daysFromYear:(NSInteger)year month:(NSInteger)month{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [self dateFromYear:year month:month day:1];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return range.length;
    
}

+(NSInteger)weeksFromYear:(NSInteger)year month:(NSInteger)month{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [self dateFromYear:year month:month day:1];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
    
}

+(NSInteger)firstWeekDayFromYear:(NSInteger)year month:(NSInteger)month{
    
    return [self weekDayFromYear:year month:month day:1];
}


+(NSInteger)weekDayFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [self dateFromYear:year month:month day:day];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    return components.weekday;
    
}

+(NSInteger)weekOfYearFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [self dateFromYear:year month:month day:day];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfYear fromDate:date];
    
    return components.weekOfYear;
    
}

+(NSMutableArray*)creatMonthDataFromYear:(NSInteger)year month:(NSInteger)month{
    
    NSInteger userMonth  = month;
    NSInteger userYear = year;
    
    NSMutableArray *_moths = [NSMutableArray array];
    
    NSInteger currentDays = [self daysFromYear:userYear month:userMonth];
    NSInteger firstWeekDay = [self firstWeekDayFromYear:userYear month:userMonth];
    
    NSInteger lastMoth = (userMonth - 1) < 1 ? 12 : (userMonth - 1);
    NSInteger lastYear = (userMonth - 1) < 1 ? (userYear - 1) : userYear;
    
    NSInteger lastDays = [self daysFromYear:lastYear month:lastMoth];
    
    AthDayModel *currentMo = [self currentDay];
    
    //本月数据
    for (int i = 0;  i < currentDays; i ++ ) {
        
        AthDayModel *dMo = [[AthDayModel alloc] init];
        dMo.day = i + 1;
        dMo.year = userYear;
        dMo.moth = userMonth;
        dMo.currentMonth = userMonth;
        
        
        if (dMo.day == currentMo.day && dMo.year == currentMo.year && dMo.moth == currentMo.moth) {
            
            dMo.isCurrent = YES;
        }
        
        [_moths addObject:dMo];
        
    }
    
    //    NSMutableArray *subArrs = [NSMutableArray array];
    //填充数据 上月
    for (int i = 0 ; i < firstWeekDay - 1; i ++) {
        
        AthDayModel *dMo = [[AthDayModel alloc] init];
        dMo.day = lastDays - i;
        dMo.year = lastYear;
        dMo.moth = lastMoth;
        dMo.isLast = YES;
        dMo.currentMonth = userMonth;
        [_moths insertObject:dMo atIndex:0];
        
    }
    NSInteger nextMoth = (userMonth + 1) > 12 ? 1 : (userMonth + 1);
    NSInteger nextYear = (userMonth + 1) > 12 ? (userYear + 1) : userYear;
    
    //填充数据 下月
    
    NSInteger lastWeekDay = [self weekDayFromYear:userYear month:userMonth day:currentDays];
    
    for (int i = 0 ; i < 7 - lastWeekDay; i ++) {
        
        AthDayModel *dMo = [[AthDayModel alloc] init];
        dMo.day = i + 1;
        dMo.year = nextYear;
        dMo.moth = nextMoth;
        dMo.isNext = YES;
        dMo.currentMonth = userMonth;
        [_moths insertObject:dMo atIndex:_moths.count];
        
    }
    
    //插入一条头数据 便于获得此月份
    AthDayModel *dMO = [[AthDayModel alloc] init];
    dMO.moth = userMonth;
    dMO.year = userYear;
    [_moths insertObject:dMO atIndex:0];
    
    return _moths;
    
    
}


@end
