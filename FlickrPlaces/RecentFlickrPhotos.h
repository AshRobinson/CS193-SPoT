//
//  RecentFlickrPhotos.h
//  FlickrPlaces
//
//  Created by Ashley Robinson on 08/09/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentFlickrPhotos : NSObject

+ (NSArray *)allPhotos;
+ (void) addPhoto: (NSDictionary *)photo;

@end
