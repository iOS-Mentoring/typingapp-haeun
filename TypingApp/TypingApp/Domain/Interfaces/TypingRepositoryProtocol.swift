//
//  TypingRepositoryProtocol.swift
//  TypingApp
//
//  Created by 권하은 on 4/6/25.
//

import Combine

protocol TypingRepositoryProtocol: Sendable {
    func fetchTypingInfo() async throws -> TypingInfo
}
