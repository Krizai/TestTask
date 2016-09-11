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
#import "DPLoadingCell.h"
#import "DPPhotoResource.h"
#import "DPPhoto.h"
#import "DPPhotoPage.h"
#import "DPPagingContainer.h"
#import "DPAlertHelper.h"
#import "DPSearchHistoryResource.h"

static NSUInteger const DPPhotoSearchViewControllerColumnCount = 3;

typedef NS_ENUM(NSUInteger, DPPhotoSearchViewControllerState) {
    DPPhotoSearchViewControllerStart,
    DPPhotoSearchViewControllerNoData,
    DPPhotoSearchViewControllerLoading,
    DPPhotoSearchViewControllerLoaded,
    DPPhotoSearchViewControllerError
};

@interface DPPhotoSearchViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *welcomeState;
@property (weak, nonatomic) IBOutlet UIView *emptyState;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSString* searchText;
@property (strong, nonatomic) DPPagingContainer* pagingContainer;

@property (strong, nonatomic, readonly) DPPhotoResource* photoResource;
@property (strong, nonatomic, readonly) DPSearchHistoryResource* searchHistoryResource;

@property (assign, nonatomic) DPPhotoSearchViewControllerState state;

@end

@implementation DPPhotoSearchViewController

- (instancetype)initWithPhotoResource:(DPPhotoResource*) photoResource
                searchHistoryResource:(DPSearchHistoryResource*) searchHistoryResource
{
    self = [super init];
    if (self) {
        _photoResource = photoResource;
        _searchHistoryResource = searchHistoryResource;
        _pagingContainer = [DPPagingContainer new];
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.state = DPPhotoSearchViewControllerStart;
    [self.collectionView dp_registerCellClass:[DPPhotoCell class]];
    [self.collectionView dp_registerCellClass:[DPLoadingCell class]];
    
}

-(void)searchFor:(NSString*) searchItem{
    self.searchText = searchItem;
    self.searchBar.text = searchItem;
    [self reloadData];
}


- (void)setState:(DPPhotoSearchViewControllerState)state{
    
    DPPhotoSearchViewControllerState previousState = state;
    _state = state;
    
    self.collectionView.hidden = state == DPPhotoSearchViewControllerNoData || self.state == DPPhotoSearchViewControllerStart;
    self.emptyState.hidden = state != DPPhotoSearchViewControllerNoData;
    self.welcomeState.hidden = state != DPPhotoSearchViewControllerStart;
    
    if([self sectionForState:previousState] != [self sectionForState:state]){
        [self.collectionView reloadData];
    }
}

- (void) reloadData{
    [self.pagingContainer clean];
    [self loadMoreData];
}

- (void) loadMoreData{
    self.state = DPPhotoSearchViewControllerLoading;
    [self.collectionView reloadData];

    [self.photoResource loadPhotoPage:self.pagingContainer.pagesLoaded
                        forSearchText:self.searchText
                           completion:^(DPPhotoPage * _Nonnull page, NSError * _Nonnull error) {
                               if(error){
                                   self.state = DPPhotoSearchViewControllerError;
                                   if(self.pagingContainer.pagesLoaded == 0){
                                       [DPAlertHelper presentFrom:self
                                                        withTitle:NSLocalizedString(@"Error", nil)
                                                          message:NSLocalizedString(@"Can't load photos. Please try again later", nil)];
                                   }
                                   return;
                               }
                               [self.pagingContainer addPage:page];
                               self.state = self.pagingContainer.pagesLoaded > 0 ? DPPhotoSearchViewControllerLoaded : DPPhotoSearchViewControllerNoData;
                               [self.collectionView reloadData];
                           }];
}


#pragma mark UICollectionViewDelegate/DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self sectionForState:self.state];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 0 ? self.pagingContainer.objects.count : 1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        DPLoadingCell* cell = [self.collectionView dp_dequeueReusableCellClass:[DPLoadingCell class] forIndexPath:indexPath];
        return cell;
    }
    
    DPPhoto* photo = self.pagingContainer.objects[indexPath.row];
    DPPhotoCell* cell = [self.collectionView dp_dequeueReusableCellClass:[DPPhotoCell class] forIndexPath:indexPath];
    [cell fillWithPhoto:photo];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewFlowLayout* flowLayout = (UICollectionViewFlowLayout*)collectionViewLayout;

    if(indexPath.section == 1){
        return CGSizeMake(collectionView.frame.size.width, 40);
    }
    
    CGFloat cellWidth = collectionView.frame.size.width / DPPhotoSearchViewControllerColumnCount - flowLayout.minimumInteritemSpacing;
    return CGSizeMake(cellWidth, cellWidth);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomContentOffset = scrollView.contentOffset.y + scrollView.frame.size.height;
    BOOL positionShouldCallLoadMore = scrollView.contentSize.height - bottomContentOffset < 100;
    
    if (positionShouldCallLoadMore &&
        (self.state == DPPhotoSearchViewControllerLoaded || self.state == DPPhotoSearchViewControllerError) &&
        self.pagingContainer.totalPages > self.pagingContainer.pagesLoaded) {
        [self loadMoreData];
    }
}

#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString* searchText = searchBar.text;
    
    self.searchText = searchText;
    [self.searchHistoryResource addHistoryItem:searchText];
    [self reloadData];
}

- (NSUInteger) sectionForState:(DPPhotoSearchViewControllerState) state{
    return (state == DPPhotoSearchViewControllerLoading || state == DPPhotoSearchViewControllerError) ? 2 : 1;
}

@end
