//
//  AGFNotesViewController.h
//  HackerBooksPro
//

#import "AGTCoreDataCollectionViewController.h"
@class AGFBook;

@interface AGFNotesViewController : AGTCoreDataCollectionViewController

@property (strong, nonatomic) AGFBook *book;

@end
