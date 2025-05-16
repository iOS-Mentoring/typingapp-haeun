//
//  TypoInfo.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/23/25.
//

struct TypoInfo {
    let text: String
    let title: String?
    let author: String?
    
    static let empty = TypoInfo(
        text: "필사된 정보가 없습니다.",
        title: nil,
        author: nil
    )
}
