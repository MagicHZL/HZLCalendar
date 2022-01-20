//
//  AthMonthCell.m
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import "AthMonthCell.h"
#import "AthDayCell.h"

@implementation AthMonthCell{
    
    UICollectionViewFlowLayout *layout;
    UICollectionView *collectionView;
    NSMutableArray *models;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.contentInset = UIEdgeInsetsMake(1, 1, 0, 0);
    [collectionView registerNib:[UINib nibWithNibName:@"AthDayCell" bundle:nil] forCellWithReuseIdentifier:@"AthDayCell"];
    collectionView.scrollEnabled = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:collectionView];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (models) {
        
        layout.itemSize = CollItemSize((CGRectGetWidth(self.frame) - 10) / 7.0, (CGRectGetHeight(self.bounds) -ceilf((models.count-1)/7.0)-1)/ ceilf((models.count-1)/7.0));
    }else{
        
        layout.itemSize = CollItemSize((CGRectGetWidth(self.frame) - 10) / 7.0, (CGRectGetHeight(self.bounds) -6)/5.0);
    }
    
    collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.bounds));
    
}

-(void)setMonth:(AthMonthModel *)month{
    
    _month = month;
    
    models = month.days;
    
    layout.itemSize = CollItemSize((CGRectGetWidth(self.frame) - 10) / 7.0, (CGRectGetHeight(self.bounds) -ceilf((models.count-1)/7.0)-1)/ ceilf((models.count-1)/7.0));
    
    [collectionView reloadData];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return models.count - 1;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AthDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AthDayCell" forIndexPath:indexPath];
    
    cell.selectMo = self.selectModel;
    
    cell.model = models[indexPath.row + 1];
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    AthDayModel *mo = models[indexPath.row + 1];
    mo.isSelect = YES;
    
    if (self.SelBlock) {
        
        self.SelBlock(mo);
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelDay" object:mo];
    
}


@end
