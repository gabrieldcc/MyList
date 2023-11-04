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

enum FirestoreDocumentsEnum: String {
    case itensDocument = "itensDocument"
}

final class DataBaseManager {
    
    static let dataBase = Firestore.firestore()

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

    static func updateDataBaseFirestore(firestoreDocument: FirestoreDocumentsEnum, firestoreCollection: FirestoreCollectionsEnum, localCollection: [String]) {
        let docRef = dataBase.collection(firestoreCollection.rawValue).document(firestoreDocument.rawValue)
        docRef.setData([firestoreCollection.rawValue: localCollection]) { error in
           if let error = error {
               print("Error writing document: \(error)")
           } else {
               print("Document successfully written!")
           }
        }
    }
    
    static func listenerDataBaseFirestore(firestoreCollection: FirestoreCollectionsEnum, firestoreDocument: FirestoreDocumentsEnum, completion: @escaping() -> Void) {
        let docRef = dataBase.collection(firestoreCollection.rawValue).document(firestoreDocument.rawValue)

        docRef.addSnapshotListener { documentSnapshot, error in
           guard let document = documentSnapshot else {
               print("Error fetching document: \(error!)")
               return
           }
           guard let data = document.data() else {
               print("Document data was empty.")
               return
           }
           print("Current data: \(data)")
            completion()
           // Atualize sua interface de usuário aqui
           // self.tableView.reloadData()
        }

    }
}

