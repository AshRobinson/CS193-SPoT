//
//  FlickrRecentsTVC.m
//  FlickrPlaces
//
//  Created by Ashley Robinson on 08/09/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "FlickrRecentsTVC.h"
#import "RecentFlickrPhotos.h"

@interface FlickrRecentsTVC ()

@end

@implementation FlickrRecentsTVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	self.photos = [RecentFlickrPhotos allPhotos];
}


@end
