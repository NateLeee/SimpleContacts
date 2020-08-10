//
//  AddContactView.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct AddContactView: View {
    @State private var image: Image?
    @State private var name = ""
    @State private var showingImagePickerView = false
    
    var addBtnDisabled: Bool {
        // TODO: - If photo and name are both there, then false.
        if (image != nil && !name.isEmpty) {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondary)
                            .cornerRadius(6)
                        
                        Text("Select a photo")
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 1, x: 0, y: 1)
                    }
                    .onTapGesture {
                        // Bring up UIImagePickerController
                        self.showingImagePickerView = true
                    }
                    .padding(.top, 9)
                }
                .frame(height: 240)
                .padding(.horizontal)
                
                Form {
                    Section(header: Text("Edit Name")) {
                        TextField("Name", text: $name)
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("Add Contact", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                // Add this contact
            }, label: {
                Text("Add")
            })
                .disabled(self.addBtnDisabled)
            )
                .sheet(isPresented: $showingImagePickerView) {
                    ImagePickerView()
            }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
