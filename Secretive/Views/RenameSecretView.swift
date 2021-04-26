//
//  RenameSecretView.swift
//  Secretive
//
//  Created by Diesal11 on 26/4/21.
//  Copyright © 2021 Max Goedjen. All rights reserved.
//

import SwiftUI
import SecretKit

struct RenameSecretView<StoreType: SecretStoreModifiable>: View {

    @ObservedObject var store: StoreType
    let secret: StoreType.SecretType
    var dismissalBlock: (_ renamed: Bool) -> ()

    @State private var newName = ""

    var body: some View {
        VStack {
            HStack {
                Image(nsImage: NSApp.applicationIconImage)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .padding()
                VStack {
                    HStack {
                        Text("Type your new name for \"\(secret.name)\" below.")
                        Spacer()
                    }
                    HStack {
                        TextField(secret.name, text: $newName).focusable()
                    }
                }
            }
            HStack {
                Spacer()
                Button("Save", action: rename)
                    .disabled(newName.count == 0)
                    .keyboardShortcut(.return)
                Button("Cancel") {
                    dismissalBlock(false)
                }.keyboardShortcut(.cancelAction)
            }
        }
        .padding()
        .frame(minWidth: 400)
    }

    func rename() {
        try? store.update(secret: secret, name: newName)
        dismissalBlock(true)
    }
}
