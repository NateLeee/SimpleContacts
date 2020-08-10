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
                        Image(systemName: "person.circle")
                        Text("Name: \(contact.name ?? "Unknown Name")")
                    }
                }
            }
            .navigationBarTitle("Simple Contacts")
            .navigationBarItems(trailing: Button(action: {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
