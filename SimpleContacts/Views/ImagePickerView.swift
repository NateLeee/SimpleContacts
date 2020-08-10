//
//  ImagePickerView.swift
//  SimpleContacts
//
//  Created by Nate Lee on 8/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import UIKit
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ImagePickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: Image?
    @Binding var uiImage: UIImage?
    @Binding var blurredImage: Image?
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerView
        
        // Filter related
        let context = CIContext()
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let uiImage = info[.originalImage] as? UIImage else { return }
            guard let blurredImage = applyFilter(filterName: "CIGaussianBlur", uiImage: uiImage, inputRadius: 21) else { return }
            
            parent.image = Image(uiImage: uiImage)
            parent.uiImage = uiImage
            parent.blurredImage = blurredImage
            
            // Dismiss this picker view
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func applyFilter(filterName: String, uiImage: UIImage, inputRadius: Double) -> Image? {
            guard let currentFilter = CIFilter(name: filterName) else { return nil }
            guard let ciImage = CIImage(image: uiImage) else { return nil }
            currentFilter.setValue(ciImage, forKey: kCIInputImageKey)
            currentFilter.setValue(inputRadius, forKey: kCIInputRadiusKey)
            
            guard let outputImage = currentFilter.outputImage else { return nil }
            guard let cgimg = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
            
            let filterredImage = UIImage(cgImage: cgimg)
            return Image(uiImage: filterredImage)
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let uiImagePickerController = UIImagePickerController()
        // uiImagePickerController.sourceType = .camera
        uiImagePickerController.delegate = context.coordinator
        
        return uiImagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
}
