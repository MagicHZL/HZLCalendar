//
//  AthCalendarView.h
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AthDayModel.h"
#import "AthCalendarTool.h"
#import "AthMonthCell.h"
#import "AthCollectionView.h"
#import "AthMonthModel.h"


@class AthCalendarView;

@protocol AthCalendarViewDelegate <NSObject>

@optional

/*正在显示的月历*/
-(void)athCalendarView:(AthCalendarView *)calendarView showModel:(AthMonthModel*)mo;
/*点击哪那一天*/
-(void)athCalendarView:(AthCalendarView *)calendarView selectModel:(AthDayModel*)mo;

@end


@interface AthCalendarView : UIView

@property(nonatomic,weak)id<AthCalendarViewDelegate> delegate;

@property(nonatomic,strong)AthDayModel *currentDay;
@property(nonatomic,strong)AthMonthModel *currentMonth;
@property(nonatomic,strong)AthDayModel *selMo;


@property(nonatomic,strong)AthMonthModel *showMonth;//显示的月份


/**
 跳回今天
 */
-(void)restoretheDefault;

/**
 指定跳转到某一天
 **/
-(void)jumpToYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/*刷新视图*/

-(void)reload;

-(void)reloadFrame;


//只显示本周
-(void)showOneList;
//只显示本月
-(void)showAllList;


@end
