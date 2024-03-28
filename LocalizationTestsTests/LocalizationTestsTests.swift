//
//  LocalizationTestsTests.swift
//  LocalizationTestsTests
//
//  Created by Amir on 3/28/24.
//

import Foundation
import LocalizationTests
import XCTest

final class LocalizationTestsTests: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Localizable"
        let presentationBundle = Bundle(for: Localized.self)
        let localizationBundles = allLocalizationBundles(in: presentationBundle)
        let localizedStringKeys = getAllLocalizationKeys()
        
        localizationBundles.forEach { (bundle, localization) in
            let language = Locale.current.localizedString(forLanguageCode: localization) ?? ""
            localizedStringKeys.forEach { key in
                let localizedString = bundle.localizedString(forKey: key, value: nil, table: table)
                
                if localizedString == key {
                    
                    XCTFail("Missing \(language) (\(localization)) localized string for key: '\(key)' in table: '\(table)'")
                } else if let key = Localized.Keys(rawValue: key) {
                    XCTAssertEqual(localizedString, getValueForALocalizationKey(key: key, language: language))
                }
            }
        }
    }
    
    // MARK: - Helpers
    private typealias LocalizedBundle = (bundle: Bundle, localization: String)
    
    private func allLocalizationBundles(in bundle: Bundle, file: StaticString = #file, line: UInt = #line) -> [LocalizedBundle] {
        return bundle.localizations.compactMap { localization in
            guard
                let path = bundle.path(forResource: localization, ofType: "lproj"),
                let localizedBundle = Bundle(path: path)
            else {
                XCTFail("Couldn't find bundle for localization: \(localization)", file: file, line: line)
                return nil
            }
            
            return (localizedBundle, localization)
        }
    }
    
    private func allLocalizedStringKeys(in bundles: [LocalizedBundle], table: String, file: StaticString = #file, line: UInt = #line) -> Set<String> {
        return bundles.reduce([]) { (acc, current) in
            guard
                let path = current.bundle.path(forResource: table, ofType: "strings"),
                let strings = NSDictionary(contentsOfFile: path),
                let keys = strings.allKeys as? [String]
            else {
                XCTFail("Couldn't load localized strings for localization: \(current.localization)", file: file, line: line)
                return acc
            }
            
            return acc.union(Set(keys))
        }
    }
    
    func getAllLocalizationKeys() -> [String] {
        return Localized.Keys.allCases.map({$0.rawValue})
    }
    
    func getValueForALocalizationKey(key: Localized.Keys, language: String) -> String {
        switch (key, language) {
        case (.greating, "English"):
            return "Hello, World!"
        case (.greating, "Georgian"):
            return "Გამარჯობა მსოფლიო!"
        default:
            return "The \(key) key was not found in \(language) language"
        }
    }
}

