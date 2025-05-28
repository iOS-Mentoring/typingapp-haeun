//
//  TypingRepositoryImpl.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/4/25.
//

import Combine
import Foundation

final class TypingRepository: TypingRepositoryProtocol {
    func fetchTypingInfo() async throws -> TypingInfo {
        return MockTypingData.typingInfo
    }
    
    func fetchTypingInfoPublisher() -> AnyPublisher<TypingInfo, any Error> {
        return Just(MockTypingData.typingInfo)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        /*return Deferred {
            Future { promise in
                Task {
                    do {
                        let typingData = try await self.fetchTypingInfo()
                        promise(.success(typingData))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()*/
    }
}

final class MockTypingData {
    static let typingInfo = TypingInfo(title: "불안한 사람들", typing: "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.", author: "프레드릭 베크만", url: "https://www.google.com")
}
