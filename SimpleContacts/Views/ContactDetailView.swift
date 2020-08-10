//
//  ContactDetailView.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI
import CoreData

struct ContactDetailView: View {
    let contact: Contact
    
    
    var body: some View {
        GeometryReader { geometry in
            Text("Name: \(self.contact.name ?? "Unknown Name...")")
        }
    }
}


