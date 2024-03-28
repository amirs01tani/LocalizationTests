//
//  Copyright © Essential Developer. All rights reserved.
//

import Foundation

public final class Localized {
	static var bundle: Bundle {
		Bundle(for: Localized.self)
	}
}

public extension Localized {
    enum Keys: String, CaseIterable {
        case greating = "first.page.greating"
        
    }
    
    enum MainPage {
		static var table: String { "Localizable" }

        static var greating: String {
            NSLocalizedString(
                Keys.greating.rawValue,
                tableName: table,
                bundle: bundle,
                comment: "Greating for the first view")
            
        }
        
	}
}
