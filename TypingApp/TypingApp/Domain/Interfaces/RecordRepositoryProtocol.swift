//
//  RecordRepositoryProtocol.swift
//  TypingApp
//
//  Created by Haeun Kwon on 5/16/25.
//

import Foundation

protocol RecordRepositoryProtocol: Sendable {
    func fetchRecord() async throws -> Record
}
