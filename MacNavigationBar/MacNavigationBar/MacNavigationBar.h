//
//  MacNavigationBar.h
//  MacNavigationBar
//
//  Created by leon on 2019/7/26.
//  Copyright © 2019 Leonidas. All rights reserved.
//

#import <Cocoa/Cocoa.h>



NS_ASSUME_NONNULL_BEGIN

@interface NavigationBarItem: NSObject
@property (nonatomic, strong) NSView *view;
@property (nonatomic, assign) CGFloat y;
@end


@interface MacNavigationBar : NSViewController
@property (nonatomic, copy) NSArray <NavigationBarItem *> *items;

@end

NS_ASSUME_NONNULL_END
