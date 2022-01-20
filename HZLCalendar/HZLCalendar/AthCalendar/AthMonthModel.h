//
//  AthMonthModel.h
//  Athena_iOS
//
//  Created by 郝忠良 on 2018/3/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AthMonthModel : NSObject

@property(nonatomic,strong)NSMutableArray *days;
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;



/**自定义相关数据**/

@property(nonatomic,strong)NSDictionary *datas;

@property(nonatomic,assign)BOOL isOnlyShowOneWeek;//是否只展示一周数据


@end
