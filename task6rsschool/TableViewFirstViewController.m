//
//  TableViewFirstViewController.m
//  task6rsschool
//
//  Created by Филипп on 6/20/20.
//  Copyright © 2020 Filipp. All rights reserved.
//

#import "TableViewFirstViewController.h"
#import "InfoAboutGalleryCell.h"
#import "InfoAboutFileViewController.h"
#import "UIColor + Extension.h"
#import "Data.h"
#import "SceneDelegate.h"
@import Photos;

@interface TableViewFirstViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, strong) NSMutableArray<PHAsset*> *assetArray;
@property (nonatomic, strong) InfoAboutGalleryCell *cellInfo;
@property (nonatomic,strong) Data *data;
@property (nonatomic,strong) NSMutableDictionary<NSString * , UIImage*> *dictionary;
@end

@implementation TableViewFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dictionary = [NSMutableDictionary new];
    PHFetchOptions *options = [PHFetchOptions new];
    options.sortDescriptors = @[
        [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES],
    ];
    self.imageManager = [[PHCachingImageManager alloc] init];
    self.fetchResult = [PHAsset fetchAssetsWithOptions:options];
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"InfoAboutGalleryCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CellID"];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setupConstraints];
    self.title = @"Info";
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fetchResult count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InfoAboutGalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    PHAsset *asset = self.fetchResult[indexPath.row];

    UIView *bgColorView = [UIView new];
    bgColorView.backgroundColor = [UIColor rsschoolYellowHighlightedColor];
    [cell setSelectedBackgroundView:bgColorView];

    UIImage *img = [UIImage new];
    img = [self.dictionary valueForKey:(NSString*)[asset valueForKey:@"filename"]];
    if (img != nil )
    {
        cell.imageViewCell.image = img;
        [self setupOtherSettingsForCell:asset cell:cell];
        return cell;
    }
    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(500, 500) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.imageViewCell.image = result;
        [self.dictionary setValue:result forKey:(NSString*)[asset valueForKey:@"filename"]];
        [self setupOtherSettingsForCell:asset cell:cell];
    }];
    return cell;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor rsschoolBlackColor];
    [self.tableView reloadData];
}


-(void)setupOtherSettingsForCell:(PHAsset*)asset cell:(InfoAboutGalleryCell*)cell
{
    NSTimeInterval progress = asset.duration;
    int minutes = floor(progress/60);
    int seconds = trunc(progress - minutes * 60);
    NSString *timeString = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    NSString *string = [NSString stringWithFormat:@"%ldx%ld", asset.pixelWidth, asset.pixelHeight];
        switch (asset.mediaType) {

            case PHAssetMediaTypeUnknown:
                cell.imageViewCell.image = [UIImage imageNamed:@"unknown"];
                cell.labelTwo.text = (NSString*)[asset valueForKey:@"filename"];
                cell.smallImageView.image = [UIImage imageNamed:@"other"];
                cell.labelTwo.text = @"";
                break;
            case PHAssetMediaTypeImage:
                cell.labelOneq.text = (NSString*)[asset valueForKey:@"filename"];
                cell.smallImageView.image = [UIImage imageNamed:@"image"];
                cell.labelTwo.text = string;
                break;
            case PHAssetMediaTypeVideo:
                cell.labelOneq.text = (NSString*)[asset valueForKey:@"filename"];
                cell.smallImageView.image = [UIImage imageNamed:@"video"];
                cell.smallImageView.tintColor = [UIColor rsschoolBlackColor];
                cell.labelTwo.text = [NSString stringWithFormat:@"%@ %@", string,timeString];
                break;
            case PHAssetMediaTypeAudio:
                cell.imageViewCell.image = [UIImage imageNamed:@"audioImageCell"];
                cell.labelTwo.text = (NSString*)[asset valueForKey:@"filename"];
                cell.smallImageView.image = [UIImage imageNamed:@"audio"];
                cell.labelTwo.text = timeString;
                break;
        }
}

-(void)setupConstraints
{
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;

    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor]
    ]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
    InfoAboutFileViewController *controller = [InfoAboutFileViewController new];
    self.data = [Data new];
    PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.row];
    controller.title = (NSString*)[asset valueForKey:@"filename"];
    [self.data getPicture:controller asset:asset];
    controller.stringCreationDate = [self createSendDate:asset.creationDate];
    controller.stringModificationDate = [self createSendDate:asset.modificationDate];
    controller.stringType = [self typeObject:asset];
    controller.assetSend = asset;
    [self.navigationController pushViewController:controller animated:true];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}



-(NSString*)createSendDate:(NSDate *)getDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss dd.MM.YYYY"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSString *dateString = [dateFormat stringFromDate:getDate];
    return  dateString;
}


-(NSString*)typeObject:(PHAsset*)asset
{
    switch (asset.mediaType) {
        case PHAssetMediaTypeUnknown:
            return @"Unknown";
            break;
        case PHAssetMediaTypeImage:
            return @"Image";
            break;
        case PHAssetMediaTypeVideo:
            return @"Video";
            break;
        case PHAssetMediaTypeAudio:
            return @"Audio";
            break;
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
        [self.tableView reloadData];
    });
}


@end
