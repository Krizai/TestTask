//
//  DPPhotoPageRequest.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPApiRequest.h"

@interface DPPhotoPageRequest : NSObject<DPApiRequest>

- (instancetype)initWithSearchText:(NSString*) searchText page:(NSUInteger) page;

@end
