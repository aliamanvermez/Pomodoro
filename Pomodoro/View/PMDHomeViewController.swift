//
//  PMDHomeViewController.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 11.08.2023.
//

import UIKit
import SnapKit
import Lottie
class PMDHomeViewController: UIViewController {
    
    lazy var headerLabel : UILabel = {
        let label = UILabel()
        label.text = "Start to focus"
        label.font = UIFont.remThin(size: 26)
        label.textColor = .white
        return label
    }()
    
    lazy var timerAnimationBorder : LottieAnimationView = {
        let animationView = LottieAnimationView(name: "circle")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    lazy var countdownLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.remBold(size: 30)
        label.text = "25:00"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var startCountdownButton : UIButton = {
        let button = UIButton()
        button.setTitle("Start Pomo", for: .normal)
        button.titleLabel?.font = UIFont.remThin(size: 20)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var stopCountdownButton : UIButton = {
        let button = UIButton()
        button.setTitle("Stop Pomo", for: .normal)
        button.titleLabel?.font = UIFont.remThin(size: 20)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    var viewModel = PMDHomeViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        setViewConstraints()
        setGestures()
    }
    
    func setViewConstraints(){
        addBackgroundImageView(to: view.self, imageName: "background_image")
        headerLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
        }
        
        timerAnimationBorder.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        
        }
        countdownLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(timerAnimationBorder.snp.centerY)
        }
        startCountdownButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(timerAnimationBorder.snp.bottom).offset(50)
        }
        
        stopCountdownButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(startCountdownButton.snp.bottom).offset(20)
        
        }
        
       
        
    }
    
    func setSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(timerAnimationBorder)
        view.addSubview(countdownLabel)
        view.addSubview(startCountdownButton)
        view.addSubview(stopCountdownButton)
    }
    
    func setGestures(){
        let countDownGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(countdownLabelClicked))
        countdownLabel.isUserInteractionEnabled = true
        countdownLabel.addGestureRecognizer(countDownGestureRecognizer)
    }
    
    @objc func countdownLabelClicked(){
        countdownLabel.isUserInteractionEnabled = false
        updateUI()
    }
    
    func updateUI() {
        viewModel = PMDHomeViewModel()
        viewModel.countdownText = { [weak self] text in
            DispatchQueue.main.async {
            self?.countdownLabel.text = text
            }
        }
    }
}
