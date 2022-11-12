#import "SurrealdbPlugin.h"
#if __has_include(<surrealdb/surrealdb-Swift.h>)
#import <surrealdb/surrealdb-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "surrealdb-Swift.h"
#endif

@implementation SurrealdbPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSurrealdbPlugin registerWithRegistrar:registrar];
}
@end
