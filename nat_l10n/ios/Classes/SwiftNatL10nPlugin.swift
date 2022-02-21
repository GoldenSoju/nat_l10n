import Flutter
import UIKit

public class SwiftNatL10nPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.cloudia9/nat_l10n", binaryMessenger: registrar.messenger())
        let instance = SwiftNatL10nPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? Dictionary<String, AnyObject>
        switch call.method {
        case "localizedTimeZones":
            result(localizedTimeZones(arguments?["locale"] as? String, arguments?["timeZone"] as? [String], arguments?["style"] as? String))
        case "localizedLocales":
            result(localizedLocales(arguments?["locale"] as? String, arguments?["locales"] as? [String]))
        case "respectivelyLocalizedLocales":
            result(respectivelyLocalizedLocales(arguments?["locales"] as? [String]))
        case "localizedCurrencies":
            result(localizedCurrencies(arguments?["locale"] as? String, arguments?["currencies"] as? [String]))
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func localizedTimeZones(_ locale: String?, _ timeZoneIds: [String]?, _ style: String?) -> [Dictionary<String, Any>?]? {
        let formatStyle = parseStyle(style)
        if (locale != nil) {
            let loc = Locale.init(identifier: locale!)
            return timeZoneIds?.map {(id) -> Dictionary<String, Any?> in
                let tz = TimeZone.init(identifier: id)
                return ["id": id, "translation": tz?.localizedName(for: formatStyle, locale: loc), "offset": tz?.secondsFromGMT()]
            }
        } else {
            return nil
        }
    }
    
    private func parseStyle(_ style: String?) -> NSTimeZone.NameStyle {
        switch style {
        case "short":
            return NSTimeZone.NameStyle.shortStandard
        case "shortWithDst":
            return NSTimeZone.NameStyle.shortDaylightSaving
        case "long":
            return NSTimeZone.NameStyle.standard
        case "longWithDst":
            return NSTimeZone.NameStyle.daylightSaving
        case "generic":
            return NSTimeZone.NameStyle.generic
        case "shortGeneric":
            return NSTimeZone.NameStyle.shortGeneric
        default:
            return NSTimeZone.NameStyle.standard
        }
    }
    
    
    private func localizedLocales(_ locale: String?, _ localeTags: [String]?) -> [Dictionary<String, Any>?]? {
        if (locale != nil) {
            let loc = Locale.init(identifier: locale!)
            let locales = localeTags?.map { (tag) -> Locale in
                Locale.init(identifier: tag)
            }
            
            return locales?.map {(_locale) -> Dictionary<String, Any?> in
                return ["localeTag": _locale.identifier,
                        "translatedLocale": loc.localizedString(forIdentifier: _locale.identifier),
                        "translatedLanguage": loc.localizedString(forLanguageCode: _locale.languageCode ?? ""),
                        "translatedRegion": loc.localizedString(forRegionCode: _locale.regionCode ?? "")
                ]
            }
        } else {
            return nil
        }
    }
    
    private func respectivelyLocalizedLocales(_ localeTags: [String]?) -> [Dictionary<String, Any>?]? {
        let locales = localeTags?.map { (tag) -> Locale in
            Locale.init(identifier: tag)
        }
        return locales?.map {(_locale) -> Dictionary<String, Any?> in
            return ["localeTag": _locale.identifier,
                    "translatedLocale": _locale.localizedString(forIdentifier: _locale.identifier),
                    "translatedLanguage": _locale.localizedString(forLanguageCode: _locale.languageCode ?? ""),
                    "translatedRegion": _locale.localizedString(forRegionCode: _locale.regionCode ?? "")
            ]
        }
    }
    
    private func localizedCurrencies(_ locale: String?, _ currencyCodes: [String]?) -> [Dictionary<String, Any>?]? {
        if (locale != nil) {
            let loc = Locale.init(identifier: locale!)
            return currencyCodes?.map {(code) -> Dictionary<String, Any?> in
                return [
                    "currencyCode": code,
                    "translated": loc.localizedString(forCurrencyCode: code),
                    "symbol": loc.localizedCurrencySymbol(code)
                ]
            }
        } else {
            return nil
        }
    }
    
}

extension Locale {
    func localizedCurrencySymbol(_ currencyCode: String) -> String? {
        guard let languageCode = languageCode, let regionCode = regionCode else { return nil }
        let components: [String: String] = [
            NSLocale.Key.languageCode.rawValue: languageCode,
            NSLocale.Key.countryCode.rawValue: regionCode,
            NSLocale.Key.currencyCode.rawValue: currencyCode,
        ]
        let identifier = Locale.identifier(fromComponents: components)
        
        return Locale(identifier: identifier).currencySymbol
    }
}
