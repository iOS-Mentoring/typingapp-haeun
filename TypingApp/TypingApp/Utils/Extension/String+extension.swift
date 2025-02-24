//
//  String+extension.swift
//  TypingApp
//
//  Created by Haeun Kwon on 2/12/25.
//

extension String {
    func decompose() -> [Character] {
        return self.decomposedStringWithCanonicalMapping
            .unicodeScalars
            .map { Character($0) }
    }
}
