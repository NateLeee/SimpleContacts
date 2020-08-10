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

    @State private var showingAddContactView = false
    
    @FetchRequest(entity: Contact.entity(), sortDescriptors: []) var contacts: FetchedResults<Contact>
    
    var body: some View {
        NavigationView {
            List(contacts, id: \.self) { contact in
                NavigationLink(destination: ContactDetailView()) {
                    Image(systemName: "person.circle")
                    Text("Name: \(contact.name ?? "Unknown Name")")
                }
            }
            .navigationBarTitle("Simple Contacts")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddContactView = true
            }, label: {
                Image(systemName: "plus")
                    .padding([.leading, .top, .bottom])
                    // .border(Color.blue, width: 1)
            }))
        }
        .sheet(isPresented: $showingAddContactView) {
            AddContactView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
