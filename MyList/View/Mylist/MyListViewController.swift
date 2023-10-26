//
//  ViewController.swift
//  MyList
//
//  Created by Gabriel de Castro Chaves on 24/10/23.
//

import UIKit

class MyListViewController: UIViewController {
    
    var list: [String] = ["arroz", "feijao"]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationBar.topItem?.title = NavigationBarTitleEnum.myList.rawValue
        list = MyListUserDefault.getObject(with: .itensList)
    }
    
    private func deleteBarButtonAction() {
        DSAlert.show(
            controller: self,
            alertTitle: .attention,
            alertMessage: .deleteItemMessage,
            leftButtonTitle: .cancel,
            rightButtonTitle: .delete) {
                self.list.removeAll()
                self.tableView.reloadData()
                MyListUserDefault.save(object: self.list, with: .itensList)
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
                self.list.append(item)
                self.tableView.reloadData()
                MyListUserDefault.save(object: self.list, with: .itensList)
            }
    }
    
    @IBAction func didTapDeleteBarButton(_ sender: UIBarButtonItem) {
        deleteBarButtonAction()
    }
    
    @IBAction func didTapAddBarButton(_ sender: UIBarButtonItem) {
        addBarButtonAction()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: MyListTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MyListTableViewCell.identifier
        )
    }
}

//MARK: - TableView
extension MyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    
}

