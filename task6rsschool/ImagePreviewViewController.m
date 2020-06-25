//
//  ImagePreviewViewController.m
//  task6rsschool
//
//  Created by Филипп on 6/23/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "ImagePreviewViewController.h"
#import "UIColor + Extension.h"
#import "ImagePreviewFullViewCell.h"
@import Photos;
@interface ImagePreviewViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic,strong) PHCachingImageManager *imageManager;
@end

@implementation ImagePreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PHFetchOptions *options = [PHFetchOptions new];
       options.sortDescriptors = @[
           [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES],
       ];
    self.imageManager = [[PHCachingImageManager alloc] init];
    self.fetchResult = [PHAsset fetchAssetsWithOptions:options];
    self.indexPath = self.indexPathSent;
    self.myCollectionView.backgroundColor = [UIColor rsschoolBlackColor];
    self.layout = [UICollectionViewFlowLayout new];

    self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;


    self.myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.layout];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerClass:ImagePreviewFullViewCell.class forCellWithReuseIdentifier:@"Cell"];
    self.myCollectionView.pagingEnabled = true;

    self.myCollectionView.backgroundColor = [UIColor rsschoolWhiteColor];
    [self.view addSubview:self.myCollectionView];
    [self setupConstraints];


}

- (void)viewDidLayoutSubviews
{
    [self.myCollectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:false];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImagePreviewFullViewCell *cell = [self.myCollectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    PHAsset *asset = self.fetchResult[indexPath.row];
    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(1000, 1000) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.imgView.image = result;
    }];
    return cell;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.myCollectionView.collectionViewLayout;
    flowLayout.itemSize = self.myCollectionView.frame.size;
    [flowLayout  invalidateLayout];
    [self.myCollectionView.collectionViewLayout invalidateLayout];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    CGPoint offset = self.myCollectionView.contentOffset;
    CGFloat width = self.myCollectionView.bounds.size.width;

    double index = round(offset.x / width);

    CGPoint newOffset = CGPointMake(index * size.width, offset.y);
    [self.myCollectionView setContentOffset:newOffset animated:false];

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.myCollectionView reloadData];
        [self.myCollectionView setContentOffset:newOffset animated:false];
    } completion:nil];
}


-(void)setupConstraints
{
    self.myCollectionView.translatesAutoresizingMaskIntoConstraints = false;

    [NSLayoutConstraint activateConstraints:@[
        [self.myCollectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.myCollectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.myCollectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.myCollectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor]
    ]];
}

@end
