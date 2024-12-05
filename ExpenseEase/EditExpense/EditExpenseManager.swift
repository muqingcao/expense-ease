//
//  EditExpenseManager.swift
//  ExpenseEase
//
//  Created by Xihuan Liu on 11/18/24.
//

import FirebaseFirestore
import FirebaseStorage

extension EditExpenseViewController{
    func updateExpenseToFirestore(_ expenseId: String, imageUrl: String?, completion: @escaping (Bool) -> Void) {
        guard let currentUser = currentUser else {return}
        
        // new data
        var newData: [String: Any] = [
            "dateTime": self.selectedDate,
            "amount": self.amount,
            "category": self.selectedCategory,
            "note": self.note ?? ""
        ]
        print(newData)
        print("EDIT call: amount:\(amount), date:\(selectedDate), category:\(selectedCategory), note:\(String(describing: note)), image:\(String(describing: imageUrl))")
        
        // only include imageUrl if it’s not nil, a new image is chosen
        if let imageUrl = imageUrl {
            newData["imageUrl"] = imageUrl
        }

        database.collection("users")
        .document(currentUser.email!)
        .collection("expenses")
        .document(expenseId)
        .updateData(newData){ error in
            if let error = error {
                print("Error saving expense: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Expense updated successfully!")
                completion(true)
            }
        }
    }
    
    func updateImageToStorage(completion: @escaping (String?) -> Void) {
        // abort if no image selected
        guard newImage != nil else {
            print("No image selected")
            completion(nil)
            return
        }
        
        // create storage reference
        let storageRef = Storage.storage().reference()
        
        // turn image into data
        let imageData = newImage!.jpegData(compressionQuality: 0.8)
        guard imageData != nil else {
            print("Failed to convert image to data")
            completion(nil)
            return
        }
        
        // generate file path and name
        let path = "expenses/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        // upload data
        fileRef.putData(imageData!, metadata: nil) { [weak self] metadata, error in
            guard let self = self else {return}
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // remove the old image if exists
            if let oldImageUrl = self.selectedImageUrl {
                self.deleteImageFromStorage(oldImageUrl) { success in
                    if success {
                        print("Old image deleted successfully")
                    } else {
                        print("Failed to delete old image")
                    }
                    completion(path)
                }
            } else {
                completion(path)
            }
        }
    }
  
    func deleteImageFromStorage(_ imageUrl: String, completion: @escaping (Bool) -> Void) {
        let storageRef = Storage.storage().reference().child(imageUrl)
        storageRef.delete { error in
            if let error = error {
                print("Failed to delete image: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Image deleted successfully")
                completion(true)
            }
        }
    }
}
