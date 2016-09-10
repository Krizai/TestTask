//
//  DPApiResponseParser.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPApiResponseParser <NSObject>

- (id) parse:(id) responseObject error:(NSError**) error;

@end
