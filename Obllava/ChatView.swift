import SwiftUI

struct ChatView: View {
    @StateObject var session = ChatSession()
    @State var inputText: String = ""
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(session.messages) { message in
                            HStack {
                                if message.sender == .user {
                                    Spacer()
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
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                            .id(message.id) // важно для скролла
                        }
                    }
                    .onChange(of: session.messages.count) {
                        if let last = session.messages.last {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
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
                    let userMessage = Message(
                        text: inputText,
                        sender: .user,
                        timestamp: Date()
                    )
                    session.addMessage(userMessage)
                    
                    // Заглушка ответа ИИ
                    let aiMessage = Message(
                        text: "Заглушка ответа ИИ на: \(inputText)",
                        sender: .ai,
                        timestamp: Date()
                    )
                    session.addMessage(aiMessage)
                    
                    inputText = ""
                }
                .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
