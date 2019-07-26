//
//  MacNavigationBar.m
//  MacNavigationBar
//
//  Created by leon on 2019/7/26.
//  Copyright © 2019 Leonidas. All rights reserved.
//

#import "MacNavigationBar.h"

@implementation NavigationBarItem {}
@end

@implementation MacNavigationBar {
    struct {
        unsigned int mouseDragDidUpdateFlag : 1;
    }_delegateFlags;
    
    NSPoint _lastDragPt;
}

- (void)viewDidAppear {
    NSWindowStyleMask mask = NSWindowStyleMaskFullSizeContentView ;
    self.view.window.styleMask |= mask;
    self.view.window.titlebarAppearsTransparent = YES;
    self.view.window.titleVisibility = NSWindowTitleHidden;

}

- (void)initVars {
    _lastDragPt = NSZeroPoint;
    
    NSVisualEffectView *view = [NSVisualEffectView new];
    view.material = NSVisualEffectMaterialHUDWindow;
    view.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVars];
}

#pragma mark - Events

- (void)mouseDragged:(NSEvent *)event {
    [super mouseDragged:event];
  
    [self drag];
}

- (void)mouseDown:(NSEvent *)event {
    [super mouseDown:event];
    _lastDragPt = [NSEvent mouseLocation] ;

}

- (void)mouseUp:(NSEvent *)event {
    [super mouseUp:event];
    _lastDragPt = NSZeroPoint;
}

- (void)drag {
    if (_delegateFlags.mouseDragDidUpdateFlag){
        NSPoint pt = [NSEvent mouseLocation] ;
        if (NSEqualPoints(_lastDragPt, NSZeroPoint)){
            _lastDragPt = pt;
            return;
        }
        NSPoint newPt = NSMakePoint(pt.x - _lastDragPt.x, pt.y - _lastDragPt.y);
        [self.delegate mouseDragPointDidUpdate:newPt];
        _lastDragPt = pt;
    }
}


#pragma mark - Setter

- (void)setDelegate:(id<NavigationBarDelegate>)delegate {
    _delegate = delegate;
    _delegateFlags.mouseDragDidUpdateFlag = [_delegate respondsToSelector:@selector(mouseDragPointDidUpdate:)];
}


- (void)setItems:(NSArray<NavigationBarItem *> *)items {
    _items = items;
    for (NavigationBarItem *item in _items) {
        NSView *view = item.view;
        [view setFrameSize:NSMakeSize(40, 40)];
        [view setFrameOrigin:NSMakePoint(0.5 * (NSWidth(self.view.frame) - NSWidth(view.frame)), item.y + 0.5 * NSHeight(view.frame))];
        [self.view addSubview:view];
        
    }
}

@end
