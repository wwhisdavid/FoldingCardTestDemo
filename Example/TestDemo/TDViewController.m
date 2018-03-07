//
//  TDViewController.m
//  TestDemo
//
//  Created by wwhisdavid on 03/07/2018.
//  Copyright (c) 2018 wwhisdavid. All rights reserved.
//

#import "TDViewController.h"
#import "TDFoldingCardViewModel.h"
#import "TDCommand.h"
#import "TDFoldingCardCompoment.h"
#import "TDFoldingCardListEntity.h"
#import "TDFoldingCardTableViewCell.h"

#import <BlocksKit/NSObject+BKBlockObservation.h>
#import "MJExtension.h"

@interface TDViewController ()

@property (nonatomic, strong) TDFoldingCardViewModel *viewModel;
@property (nonatomic, strong) TDFoldingCardCompoment *cardView;
@property (nonatomic, strong) TDFoldingCardListEntity *cardListEntity;

@end

@implementation TDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[TDFoldingCardTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([TDFoldingCardTableViewCell class])];
    
    [self _bindViewModel];
    [self _execute];
}

#pragma mark - Pravite
- (void)_bindViewModel{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel.cardCommand bk_addObserverForKeyPath:@"result"
                                                    task:^(id target) {
                                                        __strong __typeof(weakSelf)strongSelf = weakSelf;
                                                        NSDictionary *content = strongSelf.viewModel.cardCommand.result.content;
                                                        if(content){
                                                            strongSelf.cardListEntity = [TDFoldingCardListEntity mj_objectWithKeyValues:content];
                                                            [self.tableView reloadData];
                                                        }else{
                                                            strongSelf.cardListEntity = nil;
                                                        }
                                                    }];
}

- (void)_execute{
    [self.viewModel.cardCommand execute:@{
                                          @"fileName":@"data.json"
                                          }];
}
#pragma mark - Lazy Load
- (TDFoldingCardViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[TDFoldingCardViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cardListEntity.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDFoldingCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDFoldingCardTableViewCell class])];
    cell.entity = self.cardListEntity.list[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
@end
