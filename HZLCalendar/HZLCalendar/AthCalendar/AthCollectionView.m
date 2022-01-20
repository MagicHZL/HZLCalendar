//
//  AthCollectionView.m
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import "AthCollectionView.h"

@implementation AthCollectionView

+(instancetype)creatWithNibName:(NSString*)nib fram:(CGRect)fram itemSize:(CGSize)size{
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = size;
    
    layout.minimumLineSpacing= 0 ;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    AthCollectionView *collentionView = [[AthCollectionView alloc] initWithFrame:fram collectionViewLayout:layout];
    
    collentionView.cuslayout = layout;
    collentionView.pagingEnabled = YES;
    collentionView.showsHorizontalScrollIndicator = NO;
    [collentionView registerNib:[UINib nibWithNibName:nib bundle:nil] forCellWithReuseIdentifier:nib];
    
    return collentionView;
    
    
}

@end
