//
//  MultimodalChatView.swift
//  GeminiMultimodal
//
//  Created by DEEP BHUPATKAR on 15/05/24.
//
import SwiftUI
import PhotosUI

struct MultimodalChatView: View {
    @State private var textInput = ""
    @State private var chatService = ChatService()
    @State private var photoPickerItems = [PhotosPickerItem]()
    @State private var selectedPhotoData = [Data]()
    
    var body: some View {
      
        VStack {
            HStack{
                Text("Welcome to").font(.title3)  .fontWeight(.bold)
                    .foregroundStyle(.indigo)
                .padding(.top,10)
                
                // MARK: Logo
                Image(.geminiLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.top,40)
            }
                // MARK: Chat message list
                ScrollViewReader(content: { proxy in
                    ScrollView {
                        ForEach(chatService.messages) { chatMessage in
                            // MARK: Chat message view
                            chatMessageView(chatMessage)
                        }
                    }
                    .onChange(of: chatService.messages) {
                        guard let recentMessage = chatService.messages.last else { return }
                        DispatchQueue.main.async {
                            withAnimation {
                                proxy.scrollTo(recentMessage.id, anchor: .bottom)
                            }
                        }
                    }
                })
                
                // MARK: Image preview
                if selectedPhotoData.count > 0 {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10, content: {
                            ForEach(0..<selectedPhotoData.count, id: \.self) { index in
                                Image(uiImage: UIImage(data: selectedPhotoData[index])!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        })
                    }
                    .frame(height: 50)
                }
                
            HStack {
                TextField("Ask anything...", text: $textInput, onCommit: sendMessage)
                    .lineLimit(5)
                    .font(.title2)
                    .padding()
                    .background(Color.blue.opacity(0.1), in: Capsule())
                    .overlay(
                        HStack {
                            Spacer()
                            if chatService.loadingResponse {
                                ProgressView()
                                    .tint(Color.blue)
                                    .frame(width: 30)
                            } else {
                                Image(systemName: "paperplane.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 30)
                                    .onTapGesture {
                                        sendMessage()
                                    }
                            }
                        }
                        .padding(.trailing, 8)
                    )
                
                PhotosPicker(selection: $photoPickerItems, maxSelectionCount: 3, matching: .images) {
                    Image(systemName: "photo.stack.fill")
                        .frame(width: 40, height: 30)
                }
                .onChange(of: photoPickerItems) {
                    Task {
                        selectedPhotoData.removeAll()
                        for item in photoPickerItems {
                            if let imageData = try await item.loadTransferable(type: Data.self) {
                                selectedPhotoData.append(imageData)
                            }
                        }
                    }
                }
            }



            }
            .foregroundStyle(.blue)
            .padding()
            .background {
                // MARK: Background
                ZStack {
                    Color.white
                }
                .ignoresSafeArea()
            }
        
    }
    
    // MARK: Chat message view
    @ViewBuilder private func chatMessageView(_ message: ChatMessage) -> some View {
        // MARK: Chat image dislay
        if let images = message.images, images.isEmpty == false {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10, content: {
                    ForEach(0..<images.count, id: \.self) { index in
                        Image(uiImage: UIImage(data: images[index])!)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .containerRelativeFrame(.horizontal)
                    }
                })
                .scrollTargetLayout()
            }
            .frame(height: 150)
        }
        
        // MARK: Chat message bubble
        ChatBubble(direction: message.role == .model ? .left : .right) {
            Text(message.message)
                .font(.title3)
                .padding(.all, 20)
                .foregroundStyle(.white)
                .background(message.role == .model ? Color.blue : Color.indigo)
        }
    }
    
    // MARK: Fetch response
    private func sendMessage() {
        Task {
            await chatService.sendMessage(message: textInput, imageData: selectedPhotoData)
            selectedPhotoData.removeAll()
            textInput = ""
        }
    }
}

#Preview {
    MultimodalChatView()
}
