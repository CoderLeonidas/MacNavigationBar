//
//  MacNavigationBar.h
//  MacNavigationBar
//
//  Created by leon on 2019/7/26.
//  Copyright © 2019 Leonidas. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol NavigationBarDelegate <NSObject>

/**
拖拽时调用，通知外部自身位置的向量改变，既x方向移动了多少，y方向移动了多少，pt表示的是x、y方向移动的差量，外部使用时，直接加上这个差量即可

 @param pt x代表x方向上移动的差量、y代表y方向上移动的差量
 */
- (void)mouseDragPointDidUpdate:(NSPoint)pt;

@end

NS_ASSUME_NONNULL_BEGIN

@interface NavigationBarItem: NSObject
@property (nonatomic, strong) NSView *view;
@property (nonatomic, assign) CGFloat y;
@end


@interface MacNavigationBar : NSViewController
@property (nonatomic, weak) id<NavigationBarDelegate> delegate;
@property (nonatomic, copy) NSArray <NavigationBarItem *> *items;

@end

NS_ASSUME_NONNULL_END
