//
//  XJTopView.m
//  TTLive
//
//  Created by Dear on 16/9/12.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJTopView.h"

@interface XJTopView()
/**下划线*/
@property (nonatomic, weak) UIView *line;
/**选中的按钮*/
@property (nonatomic, strong) UIButton *selectedBtn;
/**热门*/
@property (nonatomic, weak) UIButton *hotBtn;
@end
@implementation XJTopView

#pragma mark - 懒加载
- (UIView *)line{
    if (!_line) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.hotBtn.xj_x, self.xj_height - 2, self.hotBtn.xj_width, 2)];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        _line = line;
    }
    return _line;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return  self;
}


- (void)setup{
    // 热门
    UIButton *hotBtn = [self createBtn:@"热门" tag:topTypeHot];
    // 最新
    UIButton *newBtn = [self createBtn:@"最新" tag:topTypeNew];
    // 关注
    UIButton *careBtn = [self createBtn:@"关注" tag:topTypeCare];
    
    _hotBtn = hotBtn;
    // 添加
    [self addSubview:hotBtn];
    [self addSubview:newBtn];
    [self addSubview:careBtn];
    
    // 设置约束
    [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(TopViewS * 2));
        make.centerY.equalTo(self);
        make.width.equalTo(@TopViewW);
    }];
    
    [newBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@TopViewW);
    }];
    
    [careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-TopViewS * 2));
        make.centerY.equalTo(self);
        make.width.equalTo(@TopViewW);
    }];
    
    // 强制刷新一次
    [self layoutIfNeeded];
    
    // 默认选中热门
    [self click:hotBtn];
    
    // 监听点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnClick) name:kNotifyToHotVC object:nil];
}

// 创建按钮
- (UIButton *)createBtn:(NSString *)title tag:(topType)tag{
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    // 绑定标记
    btn.tag = tag;
    // 监听
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

// 点击按钮
- (void)btnClick{
    [self click:_hotBtn];
}

// setter方法
-(void)setSelectBtnType:(topType)selectBtnType{
    _selectBtnType = selectBtnType;
    self.selectedBtn.selected = NO;
    for (UIView *view in self.subviews) { // 让滑动的按钮为选中
        if ([view isKindOfClass:[UIButton class]] && view.tag == selectBtnType) {
            self.selectedBtn = (UIButton *)view;
            ((UIButton *)view).selected = YES;
        }
    }
}

// 点击按钮
- (void)click:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    // 滚动下划线
    [UIView animateWithDuration:0.5 animations:^{
        // 让点击的按钮为滑动选中的类型
        if (btn.tag == _selectBtnType) {
            self.line.xj_centerX = btn.xj_centerX;
        }
        
    }];

    if (self.selectBlock) {
        self.selectBlock(btn.tag);
    }
}

@end
