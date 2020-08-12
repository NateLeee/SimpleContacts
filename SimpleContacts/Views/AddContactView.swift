//
//  AddContactView.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI
import CoreLocation

struct AddContactView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var blurredImage: Image?
    @State private var image: Image?
    @State private var uiImage: UIImage?
    @State private var name = ""
    @State private var showingImagePickerView = false
    @State private var showingMap = false
    @State private var location: CLLocationCoordinate2D?
    
    let locationFetcher = LocationFetcher()
    
    var addBtnDisabled: Bool {
        // If photo and name are both there, then false.
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
                        
                        Toggle(isOn: $showingMap.animation()) {
                            Text("Remember this location / Show Map")
                        }
                        //.disabled(self.addBtnDisabled)
                        
                        if (self.showingMap) {
                            MapView(locationFetcher: locationFetcher, title: $name, location: location)
                                .frame(height: 180)
                                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                            
                            HStack {
                                Button(action: {
                                    // Drop a pin annotation
                                    if let location = self.locationFetcher.lastKnownLocation {
                                        self.location = location
                                    }
                                    
                                }) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundColor(.red)
                                }
                                
                                Text("Drop a pin")
                            }
                        }
                    }
                    
                    
                }
                
                Spacer()
            }
            .navigationBarTitle("Add Contact", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                // Add this contact
                let newContact = Contact(context: self.moc)
                let uuid = UUID()
                
                newContact.imageId = uuid
                newContact.name = self.name
                // Save the location: CLLocationCoordinate2D?
                if let location = self.location {
                    newContact.latitude = location.latitude
                    newContact.longitude = location.longitude
                }
                
                try? self.moc.save()
                
                // Save image to the disk
                let docDirUrl = Utilities.getDocumentsDirectory()
                    .appendingPathComponent(uuid.uuidString)
                if let jpegData = self.uiImage?.jpegData(compressionQuality: 0.8) {
                    try? jpegData.write(to: docDirUrl, options: [.atomicWrite, .completeFileProtection])
                }
                
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Add")
            })
                .disabled(self.addBtnDisabled)
            )
                .sheet(isPresented: $showingImagePickerView) {
                    ImagePickerView(image: self.$image, uiImage: self.$uiImage, blurredImage: self.$blurredImage)
            }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
