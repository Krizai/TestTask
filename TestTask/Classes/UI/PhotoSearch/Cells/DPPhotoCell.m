//
//  DPPhotoCell.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPPhotoCell.h"
#import "DPPhoto.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DPPhotoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DPPhotoCell

- (void) fillWithPhoto:(DPPhoto*)photo{
    NSURL* photoUrl = [self urlForPhoto:photo];
    [self.imageView sd_setImageWithURL:photoUrl];
}

- (NSURL*) urlForPhoto:(DPPhoto*)photo{
    NSString* urlString = [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@.jpg",
                           photo.farm, photo.server, photo.photoId, photo.secret];
    return [NSURL URLWithString:urlString];
}

@end
