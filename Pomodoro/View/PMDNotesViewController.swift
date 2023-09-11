//
//  PMDTasksViewController.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 8.09.2023.
//

import UIKit
import SnapKit
class PMDNotesViewController: UIViewController {
    
    lazy var notesTableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 16
        return tableView
    }()
    
//    lazy var addNoteButton : UIButton = {
//        let button : UIButton()
//        button.setTitle("Add Note", for: <#T##UIControl.State#>)
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImageView(to: view.self, imageName: "background_image")
        view.backgroundColor = .white
        setSubviews()
        setTableView()
    }
    
    private func setTableView(){
        notesTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview()
            make.height.equalTo(500)
        }
        notesTableView.dataSource = self
        notesTableView.delegate = self
    }
    
    private func setSubviews(){
        view.addSubview(notesTableView)
    }
}

extension PMDNotesViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hello"
        return cell
    }
}

