//
//  MylistDAO.swift
//  MyList
//
//  Created by Gabriel de Castro Chaves on 26/10/23.
//

import Foundation
import FirebaseFirestore

enum FirestoreCollectionsEnum: String {
    case itensList = "itensList"
}

final class DataBaseManager {
    
    static let dataBase = Firestore.firestore()

    
//    static func getDataBaseFirestore(firestoreCollection: FirestoreCollectionsEnum) -> [String] {
//        var collection: [String] = []
//        dataBase.collection(firestoreCollection.rawValue).getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    let data = document.data()
//                    guard let items = data[firestoreCollection.rawValue] as? [String] else { return }
//                    items.forEach { value in
//                        collection.append(value)
//                    }
//                }
//            }
//        }
//        return collection
//    }
    
    static func getDataBaseFirestore(firestoreCollection: FirestoreCollectionsEnum, completion: @escaping ([String]) -> Void) {
       var collection: [String] = []
       dataBase.collection(firestoreCollection.rawValue).getDocuments() { (querySnapshot, err) in
           if let err = err {
               print("Error getting documents: \(err)")
               completion([])
           } else {
               for document in querySnapshot!.documents {
                   let data = document.data()
                   guard let items = data[firestoreCollection.rawValue] as? [String] else { return }
                   items.forEach { value in
                      collection.append(value)
                   }
               }
               completion(collection)
           }
       }
    }

    
    
    static func updateDataBaseFirestore(firestoreCollection: FirestoreCollectionsEnum, localCollection: [String]) {
        let docRef = dataBase.collection(firestoreCollection.rawValue).document("itensDocument")
        docRef.setData([firestoreCollection.rawValue: localCollection]) { error in
           if let error = error {
               print("Error writing document: \(error)")
           } else {
               print("Document successfully written!")
           }
        }

    }
}

