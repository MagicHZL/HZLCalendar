//
//  AthCollectionView.h
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger,AthCollectionViewLocation){
//
//    AthCollectionViewLocationLeft = 0,
//    AthCollectionViewLocationCenter = 1,
//    AthCollectionViewLocationRight = 2
//    
//};


@interface AthCollectionView : UICollectionView

@property(nonatomic,strong)UICollectionViewFlowLayout *cuslayout;

//@property(nonatomic,assign)AthCollectionViewLocation location;

+(instancetype)creatWithNibName:(NSString*)nib fram:(CGRect)fram itemSize:(CGSize)size;

@end
