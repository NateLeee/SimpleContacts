//
//  AddContactView.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var blurredImage: Image?
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
                        if (blurredImage == nil) {
                            Rectangle()
                                .foregroundColor(.secondary)
                                .cornerRadius(6)
                        }
                        
                        //                        blurredImage?
                        //                            .resizable()
                        //                            .scaledToFill()
                        //                            .cornerRadius(6)
                        
                        
                        image?
                            .resizable()
                            .scaledToFit()
                        
                        if (image == nil) {
                            Text("Select a photo")
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 1, x: 0, y: 1)
                        }
                    }
                    .onTapGesture {
                        // Bring up UIImagePickerController
                        self.showingImagePickerView = true
                    }
                    .padding(.top, 9)
                }
                .frame(height: 210)
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
                let newContact = Contact(context: self.moc)
                newContact.imageId = UUID()
                newContact.name = self.name
                try? self.moc.save()
                
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Add")
            })
                .disabled(self.addBtnDisabled)
            )
                .sheet(isPresented: $showingImagePickerView) {
                    ImagePickerView(blurredImage: self.$blurredImage, image: self.$image)
            }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
