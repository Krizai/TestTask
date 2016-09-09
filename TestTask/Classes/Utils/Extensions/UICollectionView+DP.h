//
//  UICollectionView+DP.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (DP)

- (void)dp_registerCellClass:(Class)cellClass;
- (id)dp_dequeueReusableCellClass:(Class)cellClass forIndexPath:(NSIndexPath*) indexPath;

@end
