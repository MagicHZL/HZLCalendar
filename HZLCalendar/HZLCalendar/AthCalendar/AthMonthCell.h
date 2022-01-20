//
//  AthMonthCell.h
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AthMonthModel.h"
#import "AthDayModel.h"

@interface AthMonthCell : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)id selectModel;

@property(nonatomic,strong)AthMonthModel *month;

@property(nonatomic,copy)void(^SelBlock)(AthDayModel* cellSelMo);

@end
