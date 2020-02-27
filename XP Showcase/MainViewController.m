//
//  ViewController.m
//  XP Showcase
//
//  Created by Yachin Ilya on 26.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewControllerViewModel.h"
#import "MainCollectionViewCell.h"
#import "MainCollectionFlow.h"
#import "SettingsViewController.h"

@interface MainViewController ()
@property(strong,nonatomic)MainViewControllerViewModel *viewModel;
@property(strong,nonatomic)UICollectionView *collection;
@property(strong,nonatomic)UIRefreshControl *refreshControl;
@property(nonatomic)BOOL forceInvalidate;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionView *collection = self.collection;
    [collection registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    MainViewControllerViewModel *viewModel = self.viewModel;
    collection.dataSource = viewModel;
    collection.delegate = viewModel;
    
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
        collection.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        collection.backgroundColor = [UIColor whiteColor];
    }
    
    collection.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:collection];
    [[collection.topAnchor constraintEqualToAnchor:self.view.topAnchor]setActive:YES];
    [[collection.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]setActive:YES];
    [[collection.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor]setActive:YES];
    [[collection.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]setActive:YES];
    
    if (@available(iOS 10.0, *)) {
        collection.refreshControl = self.refreshControl;
    } else {
        [collection addSubview:self.refreshControl];
    }
   
    self.navigationItem.rightBarButtonItems = @[
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ToggleSettings"] landscapeImagePhone:[UIImage imageNamed:@"ToggleSettings"] style:UIBarButtonItemStylePlain target:self action:@selector(navigateToSettings)],
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ClearImageCache"] landscapeImagePhone:[UIImage imageNamed:@"ClearImageCache"] style:UIBarButtonItemStylePlain target:self action:@selector(clearCacheAction)]
    ];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_forceInvalidate){
        [self.collection reloadData];
    }
}

- (void)refershControlAction{
    [self.viewModel reloadItemsFromCacheForCollection:self.collection];
    if (@available(iOS 10.0, *)) {
        [self.collection.refreshControl endRefreshing];
    } else {
        [self.refreshControl endRefreshing];
    }
}

-(void)clearCacheAction{
    [self.viewModel clearCacheForCollection:self.collection];
}

-(void)navigateToSettings{
    _forceInvalidate = YES;
    [self.navigationController pushViewController:[[SettingsViewController alloc] init]  animated:YES];
}

- (MainViewControllerViewModel *)viewModel{
    if (_viewModel==nil){ _viewModel = [[MainViewControllerViewModel alloc] init]; }
    return _viewModel;
}

- (UICollectionView *)collection{
    if (_collection==nil){
        MainCollectionFlow *layout = [[MainCollectionFlow alloc] initWithInteritemSpacing:10 lineSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumInteritemSpacing = 10;
//        layout.minimumLineSpacing = 10;
//        [layout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collection;
}

-(UIRefreshControl *)refreshControl{
    if (_refreshControl==nil){
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refershControlAction) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}
@end
