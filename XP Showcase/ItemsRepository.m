//
//  ItemsRepository.m
//  XP Showcase
//
//  Created by Yachin Ilya on 27.02.2020.
//  Copyright © 2020 Yachin Ilya. All rights reserved.
//

#import "ItemsRepository.h"
#import "Constants.h"
#import "NetworkManager.h"

@interface ItemsRepository ()
@property (strong,nonatomic)UIImage *defaultImage;
@property (strong,nonatomic)NSArray *itemsArray;
@end

@implementation ItemsRepository

+(id)sharedInstance{
    static NetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemsArray = [self getItemsArray];
    }
    return self;
}

- (void)clearCache{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kImageFilenamePrefix options:NSRegularExpressionCaseInsensitive error:nil];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:NSHomeDirectory()];
    NSString *file;
    NSError *error;
    while (file = [enumerator nextObject]) {
        NSUInteger match = [regex numberOfMatchesInString:file options:0 range:NSMakeRange(0, [file length])];
        if (match) {
            [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:file] error:&error];
        }
    }
}

- (NSArray *)getItemsArray{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:kMaxNumberOfItems];
    for (int i=0; i<kMaxNumberOfItems; i++){
        arr[i] = [NSString stringWithFormat:@"%@%d%@", kImageFilenamePrefix, i, kImageFilenameSuffix];
    }
    return arr;
}

- (UIImage *)getImageById:(NSString *)imageId withCompletion:(void(^)(void))completion {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:imageId];
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    if (img==nil){
        [NetworkManager.sharedInstance downloadImageForItem:imageId withCompletion:completion];
        return [self getDefaultImage];
    }
    return img;
}

- (UIImage *)getDefaultImage{
    if (_defaultImage==nil){
        _defaultImage=[UIImage imageNamed:@"PlaceholderItemImage"];
    }
    return _defaultImage;
}

@end
