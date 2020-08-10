//
//  ImagePickerView.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import UIKit
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let uiImagePickerController = UIImagePickerController()
        uiImagePickerController.delegate = context.coordinator
        
        return uiImagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
}
