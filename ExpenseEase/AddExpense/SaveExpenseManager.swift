//
//  SaveExpenseManager.swift
//  ExpenseEase
//
//  Created by Xihuan Liu on 11/12/24.
//

import FirebaseFirestore
import FirebaseStorage

extension AddExpenseViewController{
    
    func saveExpenseToFirestore(_ expense: Expense, completion: @escaping (Bool) -> Void) {
        print("before user check")
        guard let currentUser = currentUser else {return}
        print("In save function")
        do {
            try database.collection("users")
                .document(currentUser.email!)
                .collection("expenses")
                .addDocument(from: expense) { error in
                if let error = error {
                    print("Error saving expense: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("Expense saved successfully!")
                    completion(true)
                }
            }
        } catch {
            print("Error encoding expense: \(error)")
            completion(false)
        }
    }
    
    func uploadImageToStorage(completion: @escaping (String?) -> Void) {
        // abort if no image selected
        guard selectedImage != nil else {
            print("No image selected")
            completion(nil)
            return
        }
        
        // create storage reference
        let storageRef = Storage.storage().reference()
        
        // turn image into data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        guard imageData != nil else {
            print("Failed to convert image to data")
            completion(nil)
            return
        }
        
        // generate file path and name
        let path = "expenses/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        // upload data
        fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
            } else {
                completion(path)
            }
        }
    }
    
    func deleteImageFromStorage(_ imageUrl: String) {
        let storageRef = Storage.storage().reference(forURL: imageUrl)
        storageRef.delete { error in
            if let error = error {
                print("Error deleting image: \(error.localizedDescription)")
            } else {
                print("Image deleted successfully")
            }
        }
    }
}
