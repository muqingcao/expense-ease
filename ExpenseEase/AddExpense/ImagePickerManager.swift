//
//  ImagePickerManager.swift
//  ExpenseEase
//
//  Created by Xihuan Liu on 11/11/24.
//

import PhotosUI

//MARK: protocols for UIImagePicker
extension AddExpenseViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.addExpenseView.imageView.image = image
            self.selectedImage = image
            self.addExpenseView.imageSelectedLabel.text = "Image Selected"
        }else{
            showImageAlert()
        }
    }
    
    //MARK: Alert for unloaded image
    func showImageAlert(){
        let alert = UIAlertController(title: "Error!", message: "Error! No image loaded!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
}

//MARK: protocols for PHPicker
extension AddExpenseViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.addExpenseView.imageView.image = uwImage
                            self.selectedImage = uwImage
                            self.addExpenseView.imageSelectedLabel.text = "Image Selected"
                        }
                    }
                })
            }
        }
    }
}
