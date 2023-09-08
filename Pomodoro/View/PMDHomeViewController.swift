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
        label.isUserInteractionEnabled = true
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
    
    lazy var settingTimeIntervalChoosePicker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.layer.cornerRadius = 16
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        return pickerView
    }()
    
    lazy var pickerViewDoneButton : UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 26
        button.titleLabel?.font = UIFont.remThin(size: 20)
        button.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.isUserInteractionEnabled = true
        return button
    
    }()
    
    lazy var menuIcon : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu_icon"), for: .normal)
        button.addTarget(self, action: #selector(menuIconClicked), for: .touchUpInside)
        return button
    }()
        
    let selectableTimeIntervalsArray : [String : TimeInterval] = ["25:00 / 05:00" : 2, "30:00 / 05:00" : 3, "40:00 / 05:00" : 4 , "50:00 / 10:00" : 5]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        setViewConstraints()
        setCountdownLabelTapGesture()
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
        
        settingTimeIntervalChoosePicker.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        pickerViewDoneButton.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(settingTimeIntervalChoosePicker.snp.bottom).offset(-100)
        }
        
        menuIcon.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(20)
        
        }

    }
    
    func setCountdownLabelTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(countdownLabelTapped))
        countdownLabel.addGestureRecognizer(tap)
    }
    
    func setSubviews(){
        view.addSubview(headerLabel)
        view.addSubview(timerAnimationBorder)
        view.addSubview(countdownLabel)
        view.addSubview(startCountdownButton)
        view.addSubview(pauseCountdownButton)
        view.addSubview(stopCountdownButton)
        view.addSubview(continueCountdownButton)
        view.addSubview(settingTimeIntervalChoosePicker)
        view.addSubview(pickerViewDoneButton)
        view.addSubview(menuIcon)
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
    
    @objc func countdownLabelTapped(){
        settingTimeIntervalChoosePicker.isHidden = false
        pickerViewDoneButton.isHidden = false
    }
    
    @objc func doneButtonClicked(){
        settingTimeIntervalChoosePicker.isHidden = true
        pickerViewDoneButton.isHidden = true
    }
    
    @objc func menuIconClicked(){
      
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
        viewModel.pomodoroAlertTrigger = { [weak self] in
            self?.showTimerCompletedAlert()
        }
        viewModel.pomodoroBreakAlertTrigger = { [weak self] in
            self?.showBreakTimerCompletedAlert()
        }
    }
    
    func showTimerCompletedAlert() {
        let alert = UIAlertController(title: "Pomo time is over!", message: "\(Int((viewModel.pomodoroRemainingTime / 60) + 1)) minutes completed. Click OK to begin the \(Int((viewModel.pomodoroRemainingBreakTime / 60) + 1)) minute break period.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "TAMAM", style: .default) { [weak self] _ in
            self?.viewModel.startPomodoroBreakTime()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showBreakTimerCompletedAlert() {
        let alert = UIAlertController(title: "Break Time Is Over!", message: "The \(Int((viewModel.pomodoroRemainingTime / 60) + 1)) minute break period is complete. Click OK to begin the \(Int((viewModel.pomodoroRemainingTime / 60) + 1)) minute pomodoro period.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.viewModel.startPomodoroTime()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func stopPomodoroAlert(){
        let alert = UIAlertController(title: "Finish Pomodoro Period?", message: "The Pomodoro period will be stopped. Click Finish to continue.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Finish", style: .default) { [weak self] _ in
            self?.viewModel.stopPomodoroTime()
            self?.viewModel.resetPomodoroTime()
            self?.startCountdownButton.isHidden = false
            self?.stopCountdownButton.isHidden = true
            self?.pauseCountdownButton.isHidden = true
            self?.continueCountdownButton.isHidden =  true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.timerAnimationBorder.play()
            self.viewModel.startPomodoroTime()
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension PMDHomeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectableTimeIntervalsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let keysArray = selectableTimeIntervalsArray.compactMap{$0.key}
        let sortedKeysArray = keysArray.sorted()
        return String(sortedKeysArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Compact Map metodu dictionary bir arraydaki key ve value değerlerini ayırıp yeni bir array oluşturur. Bu sayede key ve value değerlerini ayrı ayrı kullanabiliriz.
        
        let keysArray = selectableTimeIntervalsArray.compactMap{$0.key}
        let valuesArray = selectableTimeIntervalsArray.compactMap{$0.value}
        
        //Sorted yapmazsak array random sıralanıyor ve seçilen değer doğru olmuyor.
        let sortedKeysArray = keysArray.sorted()
        let sortedValuesArray = valuesArray.sorted()
        
        let newPomodoroTime = sortedValuesArray[row]
        countdownLabel.text = String(sortedKeysArray[row])
        viewModel.pomodoroRemainingTime = newPomodoroTime
        viewModel.chosenPomodoroRemainingTime = newPomodoroTime
        
        //Eğer seçilen zaman aralığı 50 dakika ise mola süresini 10 dakikaya güncelliyoruz
        if viewModel.chosenPomodoroRemainingTime == selectableTimeIntervalsArray["50:00 / 10:00"] {
            viewModel.set50MinutesPomodoroTimeBreak()
        }
    }
    
    
}
