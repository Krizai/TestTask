//
//  PDPhoto.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@interface DPPhoto : JSONModel

@property ( nonatomic, readonly, strong) NSString* photoId;
@property ( nonatomic, readonly, strong) NSString* server;
@property ( nonatomic, readonly, strong) NSString* secret;
@property ( nonatomic, readonly, strong) NSString* farm;

@end
