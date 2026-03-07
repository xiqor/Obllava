//
//  Models.swift
//  Obllava
//
//  Created by МФ on 7/3/26.
//
import Foundation
import SwiftUI
import Combine

enum Sender {
    case user
    case ai
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let sender: Sender
    let timestamp: Date
}

struct Settings {
    var temperature: Double = 0.7
    var topP: Double = 0.9
    var maxTokens: Int = 500
    var selectedModel: String = "ollama-default"
}

class ChatSession: ObservableObject, Identifiable {
    let id = UUID()  // уникальный идентификатор сессии
    @Published var messages: [Message] = []  // массив сообщений, на который подписан UI
    
    var settings: Settings = Settings() // текущие настройки генерации сообщений
    
    init(settings: Settings = Settings()) {
        self.settings = settings
    }
    
    // Добавление нового сообщения
    func addMessage(_ message: Message) {
        messages.append(message)
    }
    
    // Удаление конкретного сообщения
    func removeMessage(_ message: Message) {
        messages.removeAll { $0.id == message.id }
    }
    
    // Очистка всех сообщений
    func clearAllMessages() {
        messages.removeAll()
    }
}
