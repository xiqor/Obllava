//
//  ChatView.swift
//  Obllava
//
//  Created by МФ on 7/3/26.
//
import SwiftUI


struct ChatView: View {
    @StateObject var session = ChatSession()
    @State var inputText: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(session.messages) { message in
                        HStack {
                            if message.sender == .user {
                                Spacer()  // Выравниваем сообщения пользователя вправо
                                Text(message.text)
                                    .padding()
                                    .background(Color.blue.opacity(0.7))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            } else {
                                Text(message.text)
                                    .padding()
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                                Spacer()  // Выравниваем сообщения ИИ влево
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 2)
                    }
                }
            }
            Divider()
            
            // Поле ввода и кнопка
            HStack {
                TextField("Введите сообщение", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 30)

                Button("Отправить") {
                    // Добавляем сообщение пользователя
                    let newMessage = Message(
                        text: inputText,
                        sender: .user,
                        timestamp: Date()
                    )
                    session.addMessage(newMessage)
                    inputText = ""  // очищаем поле
                }
                .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding()
        }
    }
}

// Превью для Xcode
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
