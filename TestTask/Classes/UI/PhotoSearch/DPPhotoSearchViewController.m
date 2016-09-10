//
//  DPPhotoSearchViewController.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPPhotoSearchViewController.h"
#import "UICollectionView+DP.h"
#import "DPPhotoCell.h"
#import "DPPhotoResource.h"

static NSUInteger const DPPhotoSearchViewControllerColumnCount = 3;

@interface DPPhotoSearchViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) DPPhotoResource* photoResource;

@end

@implementation DPPhotoSearchViewController

- (instancetype)initWithPhotoResource:(DPPhotoResource*) photoResource
{
    self = [super init];
    if (self) {
        _photoResource = photoResource;
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self.collectionView dp_registerCellClass:[DPPhotoCell class]];
    
    [self loadData];
}

- (void) loadData{
    [self.photoResource loadPhotoPage:0
                        forSearchText:@"Test"
                           completion:^(DPPhotoPage * _Nonnull page, NSError * _Nonnull error) {
                               int i = 0; i++;
                           }];
}


#pragma mark UICollectionViewDelegate/DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [self.collectionView dp_dequeueReusableCellClass:[DPPhotoCell class] forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        UICollectionViewFlowLayout* flowLayout = (UICollectionViewFlowLayout*)collectionViewLayout;
        CGFloat cellWidth = collectionView.frame.size.width / DPPhotoSearchViewControllerColumnCount - flowLayout.minimumInteritemSpacing;
        return CGSizeMake(cellWidth, cellWidth);

}

@end
