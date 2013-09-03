//
//  TagTVC.m
//  FlickrPlaces
//
//  Created by Ashley Robinson on 03/09/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "TagTVC.h"
#import "FlickrFetcher.h"

@interface TagTVC ()

@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSDictionary *photosByTag;

@end

@implementation TagTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photos = [FlickrFetcher stanfordPhotos];
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self updatePhotosByTag];
    [self.tableView reloadData];
}


- (void)updatePhotosByTag
{
    NSMutableDictionary *photosByTag = [NSMutableDictionary dictionary];
    for (NSDictionary *photo in self.photos){
        for (NSString *tag in [photo[FLICKR_TAGS] componentsSeparatedByString:@" "]){
            if ([tag isEqualToString:@"cs193pspot"]) continue;
            if ([tag isEqualToString:@"portrait"]) continue;
            if ([tag isEqualToString:@"landscape"]) continue;
            NSMutableArray *photos = [photosByTag objectForKey:tag];
            if (!photos){
                photos = [NSMutableArray array];
                photosByTag[tag] = photos;
            }
            [photos addObject:photo];
        }
    }
    self.photosByTag = photosByTag;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photosByTag count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Tag Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *tag = [[self.photosByTag allKeys] objectAtIndex:indexPath.row];
    int photoCount = [self.photosByTag[tag] count];
    cell.textLabel.text = [tag capitalizedString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Photo%@", photoCount, photoCount > 1 ? @"s": @""];
    return cell;
}


@end
