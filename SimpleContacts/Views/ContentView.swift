//
//  ContentView.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Contact.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Contact.name, ascending: true),
    ]) var contacts: FetchedResults<Contact>
    
    @State private var showingAddContactView = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts, id: \.self) { contact in
                    NavigationLink(destination: ContactDetailView(contact: contact)) {
                        // TODO: - Read jpeg image
                        // Image(systemName: "person.circle")
                        Utilities.getImageBy(contact.wrappedImageId)?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                        
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.caption)
                            
                            Text(contact.wrappedName)
                                .font(.subheadline)
                        }
                        
                        Divider() // Turns out this could be vertical!
                        
                        VStack(alignment: .leading) {
                            Text("Latitude: \(contact.latitude)")
                                .font(.subheadline)
                            
                            Text("Longitude: \(contact.longitude)")
                                .font(.subheadline)
                            
                        }
                    }
                }
                .onDelete(perform: deleteRows(offsets:))
            }
            .navigationBarTitle("Simple Contacts")
            .navigationBarItems(leading: contacts.count == 0 ? nil : EditButton(), trailing: Button(action: {
                self.showingAddContactView = true
            }, label: {
                Image(systemName: "plus")
                    .padding([.leading, .top, .bottom])
            }))
        }
        .sheet(isPresented: $showingAddContactView) {
            AddContactView().environment(\.managedObjectContext, self.moc)
        }
    }
    
    // Custom Funcs
    
    /// Delete selected row(s)
    func deleteRows(offsets: IndexSet) {
        for offset in offsets {
            let contact = contacts[offset]
            
            moc.delete(contact)
        }
        
        // save the context
        if self.moc.hasChanges {
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
