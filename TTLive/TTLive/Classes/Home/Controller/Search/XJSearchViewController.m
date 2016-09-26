//
//  XJSearchViewController.m
//  TTLive
//
//  Created by Dear on 16/9/25.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJSearchViewController.h"
#import "DXPopover.h"

@interface XJSearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UIView *searchBgView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) DXPopover *popover;
@end

@implementation XJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self buildUIElements];
    [self.searchBgView setHidden:NO];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    
//    
//}

- (void)buildUIElements{
    
    [self.navigationController.navigationBar addSubview:self.searchBgView];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-80);
    }];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.top.equalTo(@5);
        make.bottom.equalTo(@-5);
    }];
}

- (UIView *)searchBgView
{
    if (!_searchBgView) {
        _searchBgView = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
        _searchBgView.userInteractionEnabled = YES;
        _searchBgView.backgroundColor = [UIColor clearColor];
        
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.showsCancelButton = NO;
        _searchBar.tintColor = [UIColor orangeColor];
        _searchBar.placeholder = @"搜索感兴趣的内容";
        _searchBar.delegate = self;
        [self.searchBgView addSubview:self.searchBar];
        
        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    
                    //设置默认文字颜色
                    UIColor *color = [UIColor grayColor];
                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索感兴趣的内容" attributes:@{NSForegroundColorAttributeName:color}]];
                    //修改默认的放大镜图片
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
                    imageView.backgroundColor = [UIColor clearColor];
                    imageView.image = [UIImage imageNamed:@"gww_search_ misplaces"];
                    textField.leftView = imageView;
                }
            }
        }
        
        UIImage *image = [UIImage imageNamed:@"gww_search_cancle_button"];
        [_searchBar setImage:image forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
        
        _cancleBtn = [[UIButton alloc] init];
        _cancleBtn.backgroundColor = [UIColor clearColor];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_searchBgView addSubview:_cancleBtn];
        
        [_cancleBtn addTarget:self action:@selector(cancleBtnTouched) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _searchBgView;
}

- (void)cancleBtnTouched
{
//    [self.searchBar resignFirstResponder];
//    [self hiddenTheHistoryRecords];
    [self.searchBgView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [self.searchBgView removeFromSuperview];
    [self.searchBgView setHidden:YES];
}

- (void)hiddenTheHistoryRecords
{
    [self.popover dismiss];
}


#pragma mark - Table view data source

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 3;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
//    
//    
//    return cell;
//}


@end
