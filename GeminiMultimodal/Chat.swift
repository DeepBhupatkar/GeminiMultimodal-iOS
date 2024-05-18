
//Chat.swift
//GeminiMultimodal
// Created by DEEP BHUPATKAR on 15/05/24.


import Foundation

enum ChatRole {
    case user
    case model
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID().uuidString
    var role: ChatRole
    var message : String
    var images: [Data]?
}

