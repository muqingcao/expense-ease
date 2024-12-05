//
//  EditExpenseImagePickerManager.swift
//  ExpenseEase
//
//  Created by Xihuan Liu on 11/18/24.
//

import PhotosUI

//MARK: protocols for UIImagePicker
extension EditExpenseViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.editExpenseView.imageView.image = image
            self.newImage = image
            self.editExpenseView.imageSelectedLabel.text = "Image Selected"
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
extension EditExpenseViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.editExpenseView.imageView.image = uwImage
                            self.newImage = uwImage
                            self.editExpenseView.imageSelectedLabel.text = "Image Selected"
                        }
                    }
                })
            }
        }
    }
}

