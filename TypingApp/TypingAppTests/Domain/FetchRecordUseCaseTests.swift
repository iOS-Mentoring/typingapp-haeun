//
//  FetchRecordUseCaseTests.swift
//  TypingApp
//
//  Created by Haeun Kwon on 6/23/25.
//

import Testing
import Foundation
@testable import TypingApp

struct FetchRecordUseCaseTests {
    
    private func createUseCase() -> FetchRecordUseCase {
        let mockRepository = RecordRepository()
        let useCase = FetchRecordUseCase(repository: mockRepository)
        return useCase
    }
    
    @Test
    func fetchRecord_success() async throws {
        let testDate = Date()
        let expectedRecord = TypingRecord(
            wpm: 430,
            acc: 99,
            date: testDate,
            typing: "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.",
            title: "불안한 사람들",
            author: "프레드릭 베크만"
        )
        
        let result = try await createUseCase().execute(for: testDate)
        
        #expect(result.wpm == expectedRecord.wpm)
        let calendar = Calendar.current
        #expect(calendar.isDate(result.date, inSameDayAs: expectedRecord.date))
        #expect(result.typing == expectedRecord.typing)
    }
}
