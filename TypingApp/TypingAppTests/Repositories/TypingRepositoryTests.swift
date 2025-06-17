//
//  TypingRepositoryTests.swift
//  TypingApp
//
//  Created by Haeun Kwon on 6/17/25.
//

import Testing
@testable import TypingApp

struct TypingRepositoryTests {
    @Test
    func fetchTypingInfo_success() async throws {
        let repository = TypingRepository()
        
        let result = try await repository.fetchTypingInfo()
        
        #expect(result.title == "불안한 사람들")
    }
}
