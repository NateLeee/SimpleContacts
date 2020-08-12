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
                    
                    ZStack {
                        Text("Contact Name: \(self.contact.wrappedName)")
                        
                        MapView(
                            locationFetcher: nil,
                            title: self.contact.wrappedName,
                            location: CLLocationCoordinate2D(latitude: self.contact.latitude, longitude: self.contact.longitude)
                        )
                    }
                }
            }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete this contact"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteThisContact()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
                .padding([.leading, .top, .bottom])
            // .border(Color.blue, width: 1)
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


