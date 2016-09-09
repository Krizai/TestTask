//
//  UICollectionView+DP.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "UICollectionView+DP.h"

@implementation UICollectionView (DP)

- (void)dp_registerCellClass:(Class)cellClass {
    NSString *cellName = NSStringFromClass(cellClass);
    
    UINib *nib = [self dp_nibForClass:cellClass];
    
    if (nib != nil) {
        [self registerNib:nib forCellWithReuseIdentifier:cellName];
    } else {
        [self registerClass:cellClass forCellWithReuseIdentifier:cellName];
    }
}

- (id)dp_dequeueReusableCellClass:(Class)cellClass forIndexPath:(NSIndexPath*) indexPath{
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
    return cell;
}

- (UINib *)dp_nibForClass:(Class)className {
    if (className && [[NSBundle mainBundle] pathForResource:NSStringFromClass(className) ofType:@"nib"] != nil) {
        return [UINib nibWithNibName:NSStringFromClass(className) bundle:nil];
    }
    
    return nil;
}


@end
