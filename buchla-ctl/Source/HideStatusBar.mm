#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static BOOL alwaysHidden(id self, SEL _cmd)
{
    (void)self;
    (void)_cmd;
    return YES;
}

__attribute__((constructor))
static void forceHideStatusBar(void)
{
    Method m = class_getInstanceMethod([UIViewController class],
                                       @selector(prefersStatusBarHidden));
    method_setImplementation(m, (IMP)alwaysHidden);

    Method h = class_getInstanceMethod([UIViewController class],
                                        @selector(prefersHomeIndicatorAutoHidden));
    if (h) {
        method_setImplementation(h, (IMP)alwaysHidden);
    }
}
