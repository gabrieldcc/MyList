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
        DataBaseManager.getDataBaseFirestore(
            firestoreCollection: .itensList,
            completion: { itensList in
                self.itensList = itensList
                self.tableView.reloadData()
            }
        )
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
                //self.updateDataBaseFirestore()
                DataBaseManager.updateDataBaseFirestore(
                    firestoreCollection: .itensList,
                    localCollection: self.itensList
                )
                self.tableView.reloadData()
                self.addBarButtonAction()
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
            DataBaseManager.updateDataBaseFirestore(
                firestoreCollection: .itensList,
                localCollection: self.itensList
            )
            tableView.reloadData()
        }
        trash.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [trash])
        return configuration
    }
}

