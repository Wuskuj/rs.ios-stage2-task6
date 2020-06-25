//
//  CollectionViewController.m
//  task6rsschool
//
//  Created by Филипп on 6/23/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "CollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "UIColor + Extension.h"
#import "ImagePreviewViewController.h"
@import Photos;
@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate>
@property (nonatomic,strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic,strong) PHCachingImageManager *imageManager;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) NSMutableDictionary<NSString * , UIImage*> *dictionary;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dictionary = [NSMutableDictionary new];
    self.title = @"Gallery";
    PHFetchOptions *options = [PHFetchOptions new];
    options.sortDescriptors = @[
        [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES],
    ];
    self.imageManager = [[PHCachingImageManager alloc] init];
    self.fetchResult = [PHAsset fetchAssetsWithOptions:options];
    self.layout = [UICollectionViewFlowLayout new];
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.layout];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerClass:PhotoCollectionViewCell.class forCellWithReuseIdentifier:@"Cell"];
    self.myCollectionView.backgroundColor = [UIColor rsschoolWhiteColor];
    [self.view addSubview:self.myCollectionView];
    [self setupConstraints];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor rsschoolBlackColor];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  [_fetchResult count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    PhotoCollectionViewCell *cell = [self.myCollectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.imageViewPhoto.image = nil;
    PHAsset *asset = self.fetchResult[indexPath.row];
    UIImage *img = [UIImage new];
    img = [self.dictionary valueForKey:(NSString*)[asset valueForKey:@"filename"]];
    if (img != nil )
    {
        cell.imageViewPhoto.image = img;
        return cell;
    }


    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(500, 500) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
          [self.dictionary setValue:result forKey:(NSString*)[asset valueForKey:@"filename"]];
        cell.imageViewPhoto.image = result;
    }];

    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImagePreviewViewController *vc = [ImagePreviewViewController new];
    vc.indexPathSent = indexPath;
    PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.row];
    vc.title = (NSString*)[asset valueForKey:@"filename"];
    [self.navigationController pushViewController:vc animated:true];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.myCollectionView.frame.size.width;
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
       BOOL isLandscape = UIDeviceOrientationIsLandscape(orientation);
       if (isLandscape) {
           return CGSizeMake(width / 6 - 1, width / 6 - 1);
       }else {
            return CGSizeMake(width / 3 - 1, width / 3 - 1);
       }

}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.myCollectionView.collectionViewLayout invalidateLayout];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}

-(void)sendPhotoArray:(PHFetchResult*)fetchResult
{
    self.imageArray = [NSMutableArray new];
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
    [requestOptions setSynchronous:YES];
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    if([self.fetchResult count] > 0)
           {
               for (int i = 0; i <self.fetchResult.count; i++){
                   [manager requestImageForAsset:
                    [self.fetchResult objectAtIndex:i]
                                      targetSize:CGSizeMake(500, 500)
                                     contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                       [self.imageArray addObject:result];
                   }];
               }
           }else {
               NSLog(@"No Photo");
           }
}

- (void)photoLibraryDidChange:(nonnull PHChange *)changeInstance {
    PHFetchResultChangeDetails *change=  [changeInstance changeDetailsForFetchResult:self.fetchResult];
       if(change != nil){
           NSLog(@"!= nil");
       }else {
           NSLog(@"nil");
       }
       dispatch_async(dispatch_get_main_queue(), ^{
           self.fetchResult = change.fetchResultAfterChanges;
           [self.myCollectionView reloadData];
       });
}



@end
