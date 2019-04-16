//
//  UMSearchListVC.m
//  UnionMap_Example
//
//  Created by SummerSoft.CQ on 2019/4/4.
//  Copyright © 2019 nullcex. All rights reserved.
//

#import "UMSearchListVC.h"
#import <Masonry/Masonry.h>

@interface UMSearchListVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic) UITextField *searchText;
@property (nonatomic) UIButton *dismissBtn;
@property (nonatomic) UITableView *searchTable;

@property (nonatomic) NSArray<UMTip *> *tips;

@end

@implementation UMSearchListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tips = [NSArray array];
    
    self.searchText = [[UITextField alloc] init];
    self.searchText.backgroundColor = [UIColor whiteColor];
    [self.searchText setPlaceholder:@"输入位置"];
    self.searchText.delegate = self;
    [self.searchText addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:(UIControlEventEditingChanged)];
    [self.view addSubview:self.searchText];
    
    self.dismissBtn = [[UIButton alloc] init];
    self.dismissBtn.backgroundColor = [UIColor whiteColor];
    [self.dismissBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.dismissBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [self.dismissBtn addTarget:self action:@selector(dismissClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.dismissBtn];
    
    self.searchTable = [[UITableView alloc] init];
    [self.searchTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.searchTable.delegate = self;
    self.searchTable.dataSource = self;
    [self.view addSubview:self.searchTable];
    
    [self.dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@50);
        make.trailing.top.equalTo(@0);
    }];
    [self.searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(@0);
        make.trailing.equalTo(self.dismissBtn.mas_leading);
        make.height.equalTo(self.dismissBtn.mas_height);
    }];
    [self.searchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(@0);
        make.top.equalTo(self.searchText.mas_bottom).offset(10);
    }];
}

- (void)dismissClick {
    !self.dismissAction ? : self.dismissAction(nil);
}

- (void)updateSearchList:(NSArray<UMTip *> *)list {
    self.tips = list;
    [self.searchTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tips.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UMTip *tip = self.tips[indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",tip.name, tip.address];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UMTip *tip = self.tips[indexPath.row];
    !self.dismissAction ? : self.dismissAction(tip);
}

- (void)textFieldDidChanged:(UITextField *)textField {
    !self.searchForKeyword ? : self.searchForKeyword(textField.text);
}

@end
