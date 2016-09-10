//
//  DPPhotoCell.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPPhoto;

@interface DPPhotoCell : UICollectionViewCell

- (void) fillWithPhoto:(DPPhoto*)photo;

@end
