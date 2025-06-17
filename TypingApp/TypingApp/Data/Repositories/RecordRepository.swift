//
//  RecordRepository.swift
//  TypingApp
//
//  Created by Haeun Kwon on 5/16/25.
//

import Foundation

final class RecordRepository: RecordRepositoryProtocol {
    func fetchRecord(for date: Date) async throws -> TypingRecord {
        return MockRecordData.record
    }
}

final class MockRecordData {
    static let record = TypingRecord(wpm: 430, acc: 99, date: Date(), typing: "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.", title: "불안한 사람들", author: "프레드릭 베크만")
}
