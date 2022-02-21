#import "NatL10nPlugin.h"
#if __has_include(<nat_l10n/nat_l10n-Swift.h>)
#import <nat_l10n/nat_l10n-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "nat_l10n-Swift.h"
#endif

@implementation NatL10nPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNatL10nPlugin registerWithRegistrar:registrar];
}
@end
