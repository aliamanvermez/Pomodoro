//
//  PMDTasksViewController.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 8.09.2023.
//

import UIKit
import SnapKit
class PMDNotesViewController: UIViewController {
    
    var viewModel = PMDNotesViewModel()
    
    lazy var notesTableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 16
        return tableView
    }()
    
    lazy var addNoteButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("+", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImageView(to: view.self, imageName: "background_image")
        view.backgroundColor = .white
        setSubviews()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(viewModel.getData), name: NSNotification.Name(rawValue: "newNote"), object: nil)
        self.notesTableView.reloadData()
    }
    
    private func setConstraints(){
        notesTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview()
            make.height.equalTo(500)
        }
        notesTableView.dataSource = self
        notesTableView.delegate = self
        
        addNoteButton.snp.makeConstraints { make in
            make.top.equalTo(notesTableView.snp.bottom).offset(100)
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    private func setSubviews(){
        view.addSubview(notesTableView)
        view.addSubview(addNoteButton)
    }
    
    @objc func addNoteButtonTapped(){
        print("addNoteButton")
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

