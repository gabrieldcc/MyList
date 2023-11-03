//
//  ViewController.swift
//  MyList
//
//  Created by Gabriel de Castro Chaves on 24/10/23.
//

import UIKit
import FirebaseFirestore

final class MyListViewController: UIViewController {
    
    var itensList: [String] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    private func setupView() {
        navigationBar.topItem?.title = NavigationBarTitleEnum.myList.rawValue
        //itensList = MyListUserDefault.getObject(with: .itensList)
        //itensList = getDataFirebaseFirestore()
        getDataFirebaseFirestore()
        print("LISTA DE ITENS ---> \(itensList)")
        //addDataBaseDocumentInFirebase()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: MyListTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MyListTableViewCell.identifier
        )
    }
    
    private func deleteBarButtonAction() {
        DSAlert.show(
            controller: self,
            alertTitle: .attention,
            alertMessage: .deleteItemMessage,
            leftButtonTitle: .cancel,
            rightButtonTitle: .delete) {
                self.itensList.removeAll()
                //MyListUserDefault.save(object: self.itensList, with: .itensList)
                self.addItemInFirebaseFirestore("")
                self.tableView.reloadData()
            }
    }
    
    private func addBarButtonAction() {
        DSAlert.showWithTextField(
            controller: self,
            textFieldPlaceholder: .addItem,
            alertTitle: .attention,
            alertMessage: .none,
            leftButtonTitle: .cancel,
            rightButtonTitle: .ok) { item in
                self.itensList.append(item)
                //MyListUserDefault.save(object: self.itensList, with: .itensList)
                self.addItemInFirebaseFirestore(item)
                self.tableView.reloadData()
                self.addBarButtonAction()
            }
    }
    
    private func addItemInFirebaseFirestore(_ item: String) {
        let dataBase = Firestore.firestore()
        dataBase.collection("itensList").document("itensDocument")
            .updateData([
                "items": FieldValue.arrayUnion([item])
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated!")
                }
            }
        
    }
    
    private func deleteItemInFirebaseFirestore(_ item: String) {
        let dataBase = Firestore.firestore()
        dataBase.collection("itensList").document("itensDocument")
           .updateData([
               "items": FieldValue.arrayUnion([item])
           ]) { error in
               if let error = error {
                   print("Error updating document: \(error)")
               } else {
                   print("Document successfully updated!")
               }
           }

    }
    
    private func getDataFirebaseFirestore() {
        let dataBase = Firestore.firestore()
        dataBase.collection("itensList").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    guard let items = data["items"] as? [String] else { return }
                    items.forEach { value in
                        self.itensList.append(value)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func didTapDeleteBarButton(_ sender: UIBarButtonItem) {
        deleteBarButtonAction()
    }
    
    @IBAction func didTapAddBarButton(_ sender: UIBarButtonItem) {
        addBarButtonAction()
    }
}

//MARK: - TableView
extension MyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itensList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = itensList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(
            style: .destructive,
            title: "Excluir"
        ) {  _, _, _ in
            self.itensList.remove(at: indexPath.row)
            tableView.reloadData()
            //MyListUserDefault.save(object: self.itensList, with: .itensList)
        }
        trash.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [trash])
        return configuration
    }
}

