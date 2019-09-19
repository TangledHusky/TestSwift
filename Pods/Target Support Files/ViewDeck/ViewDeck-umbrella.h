#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IIEnvironment.h"
#import "IIViewDeckController.h"
#import "IIViewDeckTransitioning.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "ViewDeck.h"

FOUNDATION_EXPORT double ViewDeckVersionNumber;
FOUNDATION_EXPORT const unsigned char ViewDeckVersionString[];

