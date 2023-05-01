package com.cloudia9.nat_l10n

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

/** NatL10nPlugin */
class NatL10nPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.cloudia9/nat_l10n")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "localizedTimeZones" -> {
                result.success(
                    localizedTimeZones(
                        call.argument<String>("locale"),
                        call.argument<List<String>>("timeZone"),
                        call.argument<String>("style")
                    )
                )
            }
            "localizedLocales" -> {
                result.success(
                    localizedLocales(
                        call.argument<String>("locale"),
                        call.argument<List<String>>("locales")
                    )
                )
            }
            "respectivelyLocalizedLocales" -> {
                result.success(
                    respectivelyLocalizedLocales(
                        call.argument<List<String>>("locales")
                    )
                )
            }
            "localizedCurrencies" -> {
                result.success(
                    localizedCurrencies(
                        call.argument<String>("locale"),
                        call.argument<List<String>>("currencies")
                    )
                )
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun localizedTimeZones(
        locale: String?,
        timeZoneIds: List<String>?,
        style: String?
    ): List<Map<String, Any?>>? {
        val daytime = style == "shortWithDst" || style == "longWithDst"
        val displayStyle =
            if (style == "long" || style == "longWithDst" || style == "generic") TimeZone.LONG else TimeZone.SHORT
        return if (locale != null) {
            val loc = Locale.forLanguageTag(locale)
            val timeZones = timeZoneIds?.mapNotNull { TimeZone.getTimeZone(it) }
            return timeZones?.map {
                mapOf(
                    "id" to it.id,
                    "translation" to it.getDisplayName(
                        daytime,
                        displayStyle,
                        loc
                    ),
                    "offset" to (if (daytime) it.rawOffset + it.dstSavings else it.rawOffset) / 1000
                )
            }
        } else null
    }

    private fun localizedLocales(
        locale: String?,
        localeTags: List<String>?
    ): List<Map<String, Any?>>? {
        return if (locale != null) {
            val loc = Locale.forLanguageTag(locale)
            val locales = localeTags?.mapNotNull { Locale.forLanguageTag(it) }
            return locales?.map {
                mapOf(
                    "localeTag" to it.toLanguageTag(),
                    "translatedLocale" to it.getDisplayName(loc),
                    "translatedLanguage" to it.getDisplayLanguage(loc),
                    "translatedRegion" to it.getDisplayCountry(loc)
                )
            }
        } else null
    }

    private fun respectivelyLocalizedLocales(
        localeTags: List<String>?
    ): List<Map<String, Any?>>? {
        val locales = localeTags?.mapNotNull { Locale.forLanguageTag(it) }
        println("locales=${locales}")
        return locales?.map {
            println("localeTag=${it.toLanguageTag()}")
            println("translatedLocale=${it.getDisplayName(it)}")
            println("translatedLanguage=${it.getDisplayLanguage(it)}")
            println("translatedRegion=${it.getDisplayCountry(it)}")
            mapOf(
                "localeTag" to it.toLanguageTag(),
                "translatedLocale" to it.getDisplayName(it),
                "translatedLanguage" to it.getDisplayLanguage(it),
                "translatedRegion" to it.getDisplayCountry(it)
            )
        }
    }

    private fun localizedCurrencies(
        locale: String?,
        currencyCodes: List<String>?
    ): List<Map<String, Any?>>? {
        return if (locale != null) {
            val loc = Locale.forLanguageTag(locale)
            val currencies = currencyCodes?.mapNotNull { Currency.getInstance(it) }
            return currencies?.map {
                mapOf(
                    "currencyCode" to it.currencyCode,
                    "translated" to it.getDisplayName(loc),
                    "symbol" to it.getSymbol(loc)
                )
            }
        } else null
    }

}
