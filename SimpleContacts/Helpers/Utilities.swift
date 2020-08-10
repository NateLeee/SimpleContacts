//
//  Utilities.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

class Utilities {
    static func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    static func getImageBy(_ uuidString: String) -> Image? {
        let fileUrl = Utilities.getDocumentsDirectory().appendingPathComponent(uuidString)
        if let data = try? Data(contentsOf: fileUrl) {
            return Image(uiImage: UIImage(data: data)!)
        }
        return nil
    }
}
