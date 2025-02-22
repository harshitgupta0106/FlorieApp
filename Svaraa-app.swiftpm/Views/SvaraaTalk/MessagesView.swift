//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 18/02/25.
//

import SwiftUI

struct MessagesView: View {
    var message: Message
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                UserImageAsideMessages()
            } else if !message.isUser {
                SvaraaImageAsideMessages()
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
            }
        }
        .listRowSeparator(.hidden)
        .id(message.id)
    }
}

struct UserImageAsideMessages: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .foregroundStyle(.indigo)
                .frame(width: 25, height: 25)
                .padding(.bottom, 6)
        }
    }
}

struct SvaraaImageAsideMessages: View {
    var body: some View {
        VStack {
            Spacer()
            Image("App-Logo")
                .resizable()
                .frame(width: 25, height: 25)
                .cornerRadius(12.5)
                .padding(.bottom, 6)
                .padding(.leading, -10)
        }
    }
}
