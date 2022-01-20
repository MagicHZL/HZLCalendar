//
//  AthCalendarTool.h
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AthDayModel.h"
#define CollItemSize(a,b) CGSizeMake(floor(a),b)
#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
#define ColorValue(a) (a / 255.0)
#define kWeakSelf(type)   __weak typeof(type) weak##type = type;

@interface AthCalendarTool : NSObject

//通过年月日构建date
+(NSDate*)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

//构建当天的model
+(AthDayModel*)currentDay;
//通过年月获取本月天数
+(NSInteger)daysFromYear:(NSInteger)year month:(NSInteger)month;
//通过年月获取本月有几周
+(NSInteger)weeksFromYear:(NSInteger)year month:(NSInteger)month;
//通过年月获取本月第一天是第几周    注：每周第一天为周日
+(NSInteger)firstWeekDayFromYear:(NSInteger)year month:(NSInteger)month;

//指定一天是第周几
+(NSInteger)weekDayFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

//本年度的第几周 //
+(NSInteger)weekOfYearFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

//获取某月的参数
+(NSMutableArray*)creatMonthDataFromYear:(NSInteger)year month:(NSInteger)month;


@end
