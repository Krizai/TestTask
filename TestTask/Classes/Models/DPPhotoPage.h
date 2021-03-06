//
//  PDPhotosList.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DPPage.h"

@protocol DPPhoto;

@interface DPPhotoPage : JSONModel<DPPage>

@property (nonatomic, readonly, assign) NSUInteger totalPages;

@property (nonatomic, readonly, strong) NSArray<DPPhoto>* photos;

@end
