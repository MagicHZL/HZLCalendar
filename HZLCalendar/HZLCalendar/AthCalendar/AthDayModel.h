//
//  AthDayModel.h
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AthDayModel : NSObject

@property(nonatomic,assign)NSInteger day;
@property(nonatomic,assign)NSInteger week;//该年的第几周
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger moth;

@property(nonatomic,assign)NSInteger currentMonth;

@property(nonatomic,assign)BOOL isCurrent;
@property(nonatomic,assign)BOOL isSelect;

@property(nonatomic,assign)BOOL isNext;
@property(nonatomic,assign)BOOL isLast;

@property(nonatomic,assign)BOOL isHaveDatas;

@property(nonatomic,copy)NSString *conut;
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *date;

@end
