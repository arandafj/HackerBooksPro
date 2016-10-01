//
//  AppDelegate.h
//  HackerBooksPro
//

#import <UIKit/UIKit.h>

@class AGTSimpleCoreDataStack;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AGTSimpleCoreDataStack *model;

@end

