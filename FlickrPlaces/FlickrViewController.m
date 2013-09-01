//
//  FlickrViewController.m
//  FlickrPlaces
//
//  Created by Ashley Robinson on 01/09/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "FlickrViewController.h"
#import "FlickrFetcher.h"

@interface FlickrViewController ()

@end

@implementation FlickrViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", [FlickrFetcher stanfordPhotos]);
}

@end
