//
//  DPPhotoPageRequest.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPPhotoPageRequest.h"
#import "DPApiResponseParser.h"
#import "DPPhotoPage.h"

static NSUInteger const DPPhotoPageSize = 100;

@interface DPPhotoPageResponseParser : NSObject<DPApiResponseParser>

@end

@implementation DPPhotoPageResponseParser

- (id)parse:(id)responseObject error:(NSError *__autoreleasing *)error{
    NSError* parsingError = nil;
    NSDictionary* photosDictionary = responseObject[@"photos"];
    DPPhotoPage* page = [[DPPhotoPage alloc] initWithDictionary:photosDictionary error:&parsingError];
    if(parsingError){
        *error = parsingError;
        return nil;
    }
     
    return page;
}

@end

@interface DPPhotoPageRequest ()

@property ( nonatomic, strong) NSString* searchText;
@property ( nonatomic, assign) NSUInteger page;

@end


@implementation DPPhotoPageRequest

- (instancetype)initWithSearchText:(NSString*) searchText page:(NSUInteger) page
{
    self = [super init];
    if (self) {
        _searchText = searchText;
        _page = page;
    }
    return self;
}

- (NSString *)method{
    return @"flickr.photos.search";
}

- (NSDictionary<NSString *,NSString *> *)parameters{
    return @{@"page":[NSString stringWithFormat:@"%lu", (unsigned long)self.page],
             @"text": self.searchText,
             @"per_page" : [NSString stringWithFormat:@"%lu", (unsigned long)DPPhotoPageSize]};
}

- (id<DPApiResponseParser>)parser{
    return [DPPhotoPageResponseParser new];
}


@end
