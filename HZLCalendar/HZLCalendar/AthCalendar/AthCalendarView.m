//
//  AthCalendarView.m
//  Calendar
//
//  Created by 郝忠良 on 2018/2/5.
//  Copyright © 2018年 haozhongliang. All rights reserved.
//

#import "AthCalendarView.h"

@interface AthCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    AthCollectionView *_collection;
    int lastM;
    int oldM;
    BOOL isGo;
    AthDayModel *jumpModel;
    UIView *bgView;
}

@property(nonatomic,strong)NSMutableArray *datas;


@end


@implementation AthCalendarView

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
        self.currentDay = [AthCalendarTool currentDay];
        
        jumpModel = self.currentDay;
        
        self.datas = [NSMutableArray array];
        
//        selMo = [[AthDayModel alloc] init];
        [self loadData];
                
        lastM = 6;
        oldM = -6;
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
        
    }

    return  self;
}

-(void)creatUI{
    
    _collection = [AthCollectionView creatWithNibName:@"AthMonthCell" fram:CGRectMake(0, 30, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 30) itemSize:CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 30)];
    
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.backgroundColor = [UIColor clearColor];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelDay:) name:@"SelDay" object:nil];
    [self addSubview:_collection];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 30)];
    
    bgView.backgroundColor = [UIColor clearColor];
    
    NSArray *weekName = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    for (int i = 0; i < 7; i ++ ) {
        
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake( (CGRectGetWidth(self.frame)/ 7.0) *i, 0, CGRectGetWidth(self.frame)/7, 28)];
        
        la.backgroundColor = [UIColor clearColor];
        la.font = [UIFont systemFontOfSize:12];
        la.textColor = COLOR_WITH_HEX(0x999999);
        la.textAlignment = NSTextAlignmentCenter;
        la.text = weekName[i];
        [bgView addSubview:la];
        
    }
    
    [self addSubview:bgView];
    
    [_collection setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * 5, 0)];
    self.currentMonth = self.datas[5];
    
}

-(void)refreshCollView{
    
    [_collection reloadData];
    [_collection setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * 5, 0)];
}

-(void)didSelDay:(AthDayModel *)notif{
    

//    AthDayModel *notifMo  = notif.object;

    
//    selMo.day = notifMo.day;
//    selMo.moth = notifMo.moth;
//    selMo.year = notifMo.year;
    
    _selMo = notif;
    
    [_collection reloadData];
    
    
    if ([self.delegate respondsToSelector:@selector(athCalendarView:selectModel:)]) {
        
        [self.delegate athCalendarView:self selectModel:_selMo];
        
    }
    
    if (self.datas.count < 3) {
        
        return;
    }
    
    if (notif.isNext) {
        
        CGFloat goX = _collection.contentOffset.x + CGRectGetWidth(self.frame);
        [_collection setContentOffset:CGPointMake(goX, 0) animated:YES];
        [self changeYM:goX];
        
    }else if (notif.isLast){
        
        CGFloat goX = _collection.contentOffset.x - CGRectGetWidth(self.frame);
        [_collection setContentOffset:CGPointMake(goX, 0) animated:YES];
        [self changeYM:goX];
    }
    
    
}




-(void)loadData{
    
    for (int i = -5; i < 6 ; i ++ ) {
        
        [self.datas addObject:[self creatData:i]];
        
    }
    
}


//num取前后5个月

-(AthMonthModel*)creatData:(NSInteger)num{
    
    
    NSInteger userMonth  = jumpModel.moth + num%12;
    NSInteger userYear = jumpModel.year + num/12;
    
//    NSLog(@"%ld,%ld,%ld",userMonth,userYear,num);
    
    if (userMonth < 1) {
        
        userMonth += 12;
        userYear = userYear - 1;
    }else if (userMonth > 12){
        
        userMonth -= 12;
        userYear = userYear + 1;
    }
    
    AthMonthModel *monthModel = [[AthMonthModel alloc] init];
    
    monthModel.days = [AthCalendarTool creatMonthDataFromYear:userYear month:userMonth];
    monthModel.year = userYear;
    monthModel.month = userMonth;
    
    return monthModel;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _collection.contentInset = UIEdgeInsetsZero;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.datas.count;
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AthMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AthMonthCell" forIndexPath:indexPath];
    
    
    cell.selectModel = _selMo;
    
    cell.month = _datas[indexPath.row];
    
    kWeakSelf(self);
    [cell setSelBlock:^(AthDayModel *cellSelMo) {
       
        [weakself didSelDay:cellSelMo];
        
    }];
    
    return cell;
    
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    
    /*判断是否加载其他数据*/
    
    CGFloat goX = targetContentOffset->x;
    
    if(goX > (CGRectGetWidth(self.frame) * (_datas.count - 2))){
        
        for(int i = lastM  ;i < lastM + 5;i ++){
            
            
            [self.datas addObject:[self creatData:i]];
        }
        
        lastM += 5;
        [_collection reloadData];
    }
    
    if(goX < (2*CGRectGetWidth(self.frame))){
        
        int a= 0;
        NSMutableArray *indexPathArr = [NSMutableArray array];
        for(int i = oldM  ;i > oldM - 5;i --){
            
            [self.datas insertObject:[self creatData:i] atIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:a inSection:0];
            
            [indexPathArr addObject:indexPath];
            a ++ ;
        }
        
        oldM -= 5;
        
        
        [_collection reloadData];
        isGo = YES;
        
        
    }
    
    [self changeYM:goX];

    
}

-(void)changeYM:(CGFloat)goX{
    
    //
    int index = goX/CGRectGetWidth(self.frame);
    //
    if(isGo){
        index += 5;
    }
    
//    AthDayModel *mo = [self.datas[index] firstObject];
    
//    NSLog(@"---%ld------%ld-----", mo.year ,mo.moth);
    
    self.showMonth = self.datas[index];
    
    if ([self.delegate respondsToSelector:@selector(athCalendarView:showModel:)]) {
        
        [self.delegate athCalendarView:self showModel:self.datas[index]];
        
    }
//    _yearL.text = [NSString stringWithFormat:@"%ld",mo.year];
//    _monthL.text = [NSString stringWithFormat:@"%ld",mo.moth];
    
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate && isGo ) {
        [_collection setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * 6, 0)];
        isGo = NO;
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (isGo) {
        
        [_collection setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * 6, 0)];
        isGo = NO;
    }
    
}

-(void)restoretheDefault{
    
    jumpModel = [AthCalendarTool currentDay];
    
    [self.datas removeAllObjects];
    [self loadData];
    self.currentMonth = self.datas[5];
    lastM = 6;
    oldM = -6;
    [self refreshCollView];
    
}


-(void)jumpToYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    
    jumpModel.day = day;
    jumpModel.moth = month;
    jumpModel.year = year;
    
    [self.datas removeAllObjects];
    [self loadData];
    

    AthMonthModel *mm = self.datas[5];


            for (AthDayModel *mday in mm.days) {
                
                if (mday.day == day && mday.moth == month) {
                    
                    self.selMo = mday;
                    
                    break;
                }
            }
    
    self.showMonth = mm;
    if ([self.delegate respondsToSelector:@selector(athCalendarView:showModel:)]) {
        
        [self.delegate athCalendarView:self showModel:mm];
        
    }
    
    lastM = 6;
    oldM = -6;
    [self refreshCollView];
    
}

-(void)reload{
    
    [_collection reloadData];
    
}

-(void)reloadFrame{
    
    _collection.frame = CGRectMake(0, 30, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 30);
    
    _collection.cuslayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame), floor( CGRectGetHeight(self.frame) - 30));
    
    [_collection reloadData];
    
    if (self.datas.count > 5) {
        
        if (self.showMonth) {
            
            [_collection setContentOffset:CGPointMake([self.datas indexOfObject:self.showMonth] *CGRectGetWidth(self.frame) , 0)];
            
        }else{
            
            
            [_collection setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * 5, 0)];
        }
        
    }

    
    [bgView removeFromSuperview];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 30)];
    
    bgView.backgroundColor = [UIColor clearColor];
    
    NSArray *weekName = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    for (int i = 0; i < 7; i ++ ) {
        
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake( (CGRectGetWidth(self.frame)/ 7.0) *i, 0, CGRectGetWidth(self.frame)/7, 28)];
        
        la.backgroundColor = [UIColor clearColor];
        la.font = [UIFont systemFontOfSize:12];
        la.textColor = COLOR_WITH_HEX(0x999999);
        la.textAlignment = NSTextAlignmentCenter;
        la.text = weekName[i];
        [bgView addSubview:la];
        
    }
    
    [self addSubview:bgView];
    
}


-(void)showOneList{
    
    [self.datas removeAllObjects];
    
    self.currentMonth.isOnlyShowOneWeek = YES;
    
    [self.datas addObject:self.currentMonth];
    self.backgroundColor = [UIColor clearColor];
    [_collection setContentOffset:CGPointZero animated:NO];
//    [_collection reloadData];
    _collection.scrollEnabled = NO;
    
    [self reloadFrame];
    
}

-(void)showAllList{
    
    [self.datas removeAllObjects];
    
    self.currentMonth.isOnlyShowOneWeek = NO;
    [self.datas addObject:self.currentMonth];
    self.backgroundColor = [UIColor clearColor];
    [_collection setContentOffset:CGPointZero animated:NO];
//    [_collection reloadData];
    _collection.scrollEnabled = NO;
    
    [self reloadFrame];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
