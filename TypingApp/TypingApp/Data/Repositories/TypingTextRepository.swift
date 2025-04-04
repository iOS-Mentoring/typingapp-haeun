//
//  TypingTextRepository.swift
//  TypingApp
//
//  Created by Haeun Kwon on 4/4/25.
//

import Combine

protocol TypingTextRepository {
    func fetchTypingText() -> AnyPublisher<String, Error>
}

final class TypingTextRepositoryImpl: TypingTextRepository {
    func fetchTypingText() -> AnyPublisher<String, Error> {
        let typingText = "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
        return Just(typingText)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
