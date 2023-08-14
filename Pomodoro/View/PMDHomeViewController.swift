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
    
    var viewModel = PMDHomeViewModel()

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
        button.setTitle("Start to focus", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 26
        button.titleLabel?.font = UIFont.remThin(size: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var continueCountdownButton : UIButton = {
        let button = UIButton()
        button.setTitle("Continue to focus", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 26
        button.titleLabel?.font = UIFont.remThin(size: 20)
        button.setTitleColor(.black, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var pauseCountdownButton : UIButton = {
        let button = UIButton()
        button.setTitle("Pause", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 26
        button.titleLabel?.font = UIFont.remThin(size: 20)
        button.addTarget(self, action: #selector(pauseButtonClicked), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var stopCountdownButton : UIButton = {
        let button = UIButton()
        button.setTitle("Stop Pomo Session", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 26
        button.titleLabel?.font = UIFont.remThin(size: 20)
        button.addTarget(self, action: #selector(stopButtonClicked), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        setViewConstraints()
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
            make.width.equalTo(250)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(timerAnimationBorder.snp.bottom).offset(50)
        }
        
        pauseCountdownButton.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(timerAnimationBorder.snp.bottom).offset(50)
            
        }
        stopCountdownButton.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(pauseCountdownButton.snp.bottom).offset(50)
        }
        
        continueCountdownButton.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(timerAnimationBorder.snp.bottom).offset(50)
        }
    }
    
    func setSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(timerAnimationBorder)
        view.addSubview(countdownLabel)
        view.addSubview(startCountdownButton)
        view.addSubview(pauseCountdownButton)
        view.addSubview(stopCountdownButton)
        view.addSubview(continueCountdownButton)
    }
    
    @objc func startButtonClicked(){
        updateUI()
        timerAnimationBorder.play()
        startCountdownButton.isHidden = true
        pauseCountdownButton.isHidden = false
        pauseCountdownButton.isUserInteractionEnabled = true
    }
    
    @objc func pauseButtonClicked(){
        timerAnimationBorder.pause()
        viewModel.stopPomodoroTime()
        stopCountdownButton.isHidden = false
        pauseCountdownButton.isHidden = true
        continueCountdownButton.isHidden = false
    }
    
    @objc func continueButtonClicked(){
        timerAnimationBorder.play()
        viewModel.startPomodoroTime()
        pauseCountdownButton.isHidden = false
        continueCountdownButton.isHidden = true
        stopCountdownButton.isHidden = true
    }
    
    @objc func stopButtonClicked(){
        timerAnimationBorder.pause()
        viewModel.stopPomodoroTime()
        stopPomodoroAlert()
    
    }
    
    func updateUI() {
        viewModel.startPomodoroTime()
        viewModel.pomodoroTimeText = { [weak self] text in
            self?.countdownLabel.text = text
        }
        viewModel.pomodoroBreakTimeText = {
            [weak self] text in
            self?.countdownLabel.text = text
        }
        viewModel.pomodoroAlertTetikle = { [weak self] in
            self?.showTimerCompletedAlert()
        }
        viewModel.pomodoroBreakAlertTetikle = { [weak self] in
            self?.showBreakTimerCompletedAlert()
        }
    }
    
    func showTimerCompletedAlert() {
        let alert = UIAlertController(title: "Süre Bitti!", message: "25 dakika tamamlandı. 5 dakikalık mola süresine başlamak için TAMAM'a tıklayın.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "TAMAM", style: .default) { [weak self] _ in
            self?.viewModel.startPomodoroBreakTime()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showBreakTimerCompletedAlert() {
        let alert = UIAlertController(title: "Mola Süresi Bitti!", message: "5 dakikalık mola süresi tamamlandı. 25 dakikalık pomodoro süresine başlamak için TAMAM'a tıklayın.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "TAMAM", style: .default) { [weak self] _ in
            self?.viewModel.startPomodoroTime()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func stopPomodoroAlert(){
        let alert = UIAlertController(title: "Pomodoro Süresi Durdurulsun mu?", message: "Pomodoro süresi durdurulacak. Devam etmek için Bitir'e tıklayın.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Bitir", style: .default) { [weak self] _ in
            self?.viewModel.stopPomodoroTime()
            self?.viewModel.resetPomodoroTime()
            self?.startCountdownButton.isHidden = false
            self?.stopCountdownButton.isHidden = true
            self?.pauseCountdownButton.isHidden = true
            self?.continueCountdownButton.isHidden =  true
        }
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel) { _ in
            self.timerAnimationBorder.play()
            self.viewModel.startPomodoroTime()
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
