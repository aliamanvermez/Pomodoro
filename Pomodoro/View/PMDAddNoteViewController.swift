//
//  PMDAddNoteViewController.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 11.09.2023.
//

import UIKit
import SnapKit
class PMDAddNoteViewController: UIViewController {
    
    let viewModel = PMDAddNoteViewModel()
    
    lazy var noteHeaderLabel : UILabel = {
        let label = UILabel()
        label.text = "Add Your Notes Here"
        label.font = UIFont.remLight(size: 35)
        label.textColor = .white
        return label
    }()
    
    lazy var noteTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .white
        return label
    }()
    
    lazy var titleTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.setLeftPaddingPoints(5)
        return textField
    }()
    
    lazy var noteLabel : UILabel = {
        let label = UILabel()
        label.text = "Note"
        label.textColor = .white
        return label
    }()
    
    lazy var noteTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Note"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Note",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.setLeftPaddingPoints(5)
        return textField
    }()
    
    lazy var saveNoteButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(saveNoteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setViewController()
        addBackgroundImageView(to: self.view, imageName: "background_image")
    }
    
    func addSubview(){
        self.view.addSubview(noteHeaderLabel)
        self.view.addSubview(noteTitleLabel)
        self.view.addSubview(titleTextField)
        self.view.addSubview(noteLabel)
        self.view.addSubview(noteTextField)
        self.view.addSubview(saveNoteButton)
    }
    
    func setViewController(){
        noteHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        noteTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(noteHeaderLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(noteTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        noteTextField.snp.makeConstraints { make in
            make.top.equalTo(noteLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(75)
        }
        saveNoteButton.snp.makeConstraints { make in
            make.top.equalTo(noteTextField.snp.bottom).offset(20)
            make.width.equalTo(70)
            make.height.equalTo(35)
            make.centerX.equalToSuperview()
        }
    
    }
    
    @objc func saveNoteButtonPressed(){
        viewModel.saveNote(title: titleTextField.text!, note: noteTextField.text!)
    }
    

}
