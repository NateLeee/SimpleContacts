//
//  ContactDetailView.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI
import CoreData
import CoreLocation

struct ContactDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    let contact: Contact
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Utilities.getImageBy(self.contact.wrappedImageId)?
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .padding(.top)
                    
                    ZStack(alignment: .topLeading) {
                        MapView(
                            locationFetcher: nil,
                            title: self.contact.wrappedName,
                            location: CLLocationCoordinate2D(latitude: self.contact.latitude, longitude: self.contact.longitude)
                        )
                        
                        Text("Contact Name: \(self.contact.wrappedName)")
                            .underline()
                            .foregroundColor(.secondary)
                            .padding([.top, .leading])
                    }
                    .frame(height: 300)
                    
                    Spacer()
                }
            }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete this contact"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteThisContact()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarTitle("\(contact.wrappedName)", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { // 🗑 Delete button
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
                .padding([.leading, .top, .bottom])
        })
    }
    
    // Custom Funcs
    
    func deleteThisContact() {
        moc.delete(contact)
        
        if self.moc.hasChanges {
            try? self.moc.save()
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}


