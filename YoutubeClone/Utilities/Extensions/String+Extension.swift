//
//  String+Extensions.swift
//  YoutubeClone
//
//  Created by mert can çifter on 5.03.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self
        )
    }
}
