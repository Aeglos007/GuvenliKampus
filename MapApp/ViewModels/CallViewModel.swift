//
//  CallViewModel.swift
//  MapApp
//
//  Created by yusuf ergül on 11.02.2024.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import UIKit
class CallViewModel: ObservableObject{
    init(){}
    
    func savePhoto(image: UIImage?){
        let uid = UUID().uuidString
        let storageRef = Storage.storage().reference(withPath: uid)
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        storageRef.putData(imageData) { _, _ in
            storageRef.downloadURL { url, err in
                if let err = err {
                    print("zortingen")
                    return
                }
                guard let url = url else{return}
                let db = Firestore.firestore()
                db.collection("photos").document(uid).setData(["Konum Foto" : url.absoluteString])

            }
        }
        
    }
    
    
}
