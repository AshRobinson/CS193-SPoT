//
//  TagTVC.m
//  FlickrPlaces
//
//  Created by Ashley Robinson on 03/09/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "TagTVC.h"
#import "FlickrFetcher.h"
#import "NetworkActivityIndicator.h"

@interface TagTVC ()

@property (strong, nonatomic) NSArray *photos;  //of photo
@property (strong, nonatomic) NSDictionary *photosByTag; //of dictionary of array
@property (strong, nonatomic) NSArray *tags;

@end

@implementation TagTVC


- (void)updatePhotosByTag
{
    NSMutableDictionary *photosByTag = [NSMutableDictionary dictionary];
    for (NSDictionary *photo in self.photos) {
        for (NSString *tag in [photo[FLICKR_TAGS] componentsSeparatedByString:@" "]) {
            if ([tag isEqualToString:@"cs193pspot"]) continue;
            if ([tag isEqualToString:@"portrait"]) continue;
            if ([tag isEqualToString:@"landscape"]) continue;
            NSMutableArray *photos = photosByTag[tag];
            if (!photos) {
                photos = [NSMutableArray array];
                photosByTag[tag] = photos;
            }
            [photos addObject:photo];
        }
    }
    self.photosByTag = photosByTag;
    self.tags = [[photosByTag allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = [photos sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1[FLICKR_PHOTO_TITLE] compare:obj2[FLICKR_PHOTO_TITLE] options:NSCaseInsensitiveSearch];
    }];
    
    [self updatePhotosByTag];
    [self.tableView reloadData];
}

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self
                            action:@selector(loadPhotos)
                  forControlEvents:UIControlEventValueChanged];
    [self loadPhotos];
}

- (IBAction)loadPhotos
{
    [self.refreshControl beginRefreshing];
    dispatch_queue_t queue = dispatch_queue_create("load photos", NULL);
    dispatch_async(queue, ^{
        [NetworkActivityIndicator start];
        NSArray *photos = [FlickrFetcher stanfordPhotos];
        [NetworkActivityIndicator stop];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photos = photos;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        });
    });
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Photos"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setPhotos:)]) {
                    NSString *tag = self.tags[indexPath.row];
                    [segue.destinationViewController performSelector:@selector(setPhotos:)
                                                          withObject:self.photosByTag[tag]];
                    [segue.destinationViewController setTitle:[tag capitalizedString]];
                }
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tags count];
}

- (NSString *)tagForRow:(NSUInteger)row
{
    return [[self.photosByTag allKeys] sortedArrayUsingSelector:@selector(compare:)][row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Tag Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *tag = self.tags[indexPath.row];
    int photoCount = [self.photosByTag[tag] count];
    cell.textLabel.text = [tag capitalizedString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photo%@", photoCount, photoCount > 1 ? @"s" : @""];
    
    return cell;
}


@end
