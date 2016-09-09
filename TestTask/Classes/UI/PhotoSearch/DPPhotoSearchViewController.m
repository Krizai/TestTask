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

static NSUInteger const DPPhotoSearchViewControllerColumnCount = 3;

@interface DPPhotoSearchViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation DPPhotoSearchViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    [self.collectionView dp_registerCellClass:[DPPhotoCell class]];
}

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
