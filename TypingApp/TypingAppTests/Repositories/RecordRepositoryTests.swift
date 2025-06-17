//
//  RecordRepositoryTests.swift
//  TypingApp
//
//  Created by Haeun Kwon on 6/17/25.
//

import Testing
@testable import TypingApp
import Foundation

struct RecordRepositoryTests {
    @Test
    func fetchRecord_success() async throws {
        let repository = RecordRepository()
        
        let result = try await repository.fetchRecord(for: Date())
        
        #expect(result.title == "불안한 사람들")
    }
}
