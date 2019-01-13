//
//  SignupSurveyViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

enum SurveyAnswerType: Int {
    case negative = 0
    case half_nagative = 1
    case nuetral = 2
    case half_positive = 3
    case postitive = 4
}

class SignupSurveyViewController: BaseSignupStepsViewController {
    private let labelCount = UILabel()
    private let labelQuestion = UILabel()
    private let labelAnswer = UILabel()
    private let sliderAnswer = UISlider()
    
    private let buttonPrevious = UIButton(type: .custom)
    private let buttonNext = UIButton(type: .custom)
    
    private let depth: Int
    private var currentPage = 0
    
    private var dataArray = [SurveyData]()
    
    private var constraintWide: NSLayoutConstraint!
    private var constraintNarrow: NSLayoutConstraint!
    
    init(navigationViewEffect effect: UIVisualEffect? = nil, depth dCode: Int) {
        depth = dCode
        super.init(navigationViewEffect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelCount.translatesAutoresizingMaskIntoConstraints = false
        labelCount.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelCount.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        headerView.addSubview(labelCount)
        
        labelCount.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        labelCount.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        labelQuestion.translatesAutoresizingMaskIntoConstraints = false
        labelQuestion.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelQuestion.font = UIFont.systemFont(ofSize: 32 * QUtils.optimizeRatio(), weight: .bold)
        labelQuestion.textAlignment = .center
        labelQuestion.numberOfLines = 0
        labelQuestion.lineBreakMode = .byWordWrapping
        self.view.addSubview(labelQuestion)
        
        labelQuestion.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 64 * QUtils.optimizeRatio()).isActive = true
        labelQuestion.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25 * QUtils.optimizeRatio()).isActive = true
        labelQuestion.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25 * QUtils.optimizeRatio()).isActive = true
        labelQuestion.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        labelAnswer.translatesAutoresizingMaskIntoConstraints = false
        labelAnswer.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        labelAnswer.clipsToBounds = true
        labelAnswer.textAlignment = .center
        labelAnswer.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        labelAnswer.font = UIFont.systemFont(ofSize: 24 * QUtils.optimizeRatio(), weight: .semibold)
        labelAnswer.layer.cornerRadius = 30 * QUtils.optimizeRatio()
        self.view.addSubview(labelAnswer)
        
        labelAnswer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelAnswer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        labelAnswer.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.65).isActive = true
        labelAnswer.heightAnchor.constraint(equalToConstant: labelAnswer.layer.cornerRadius * 2).isActive = true
        
        sliderAnswer.translatesAutoresizingMaskIntoConstraints = false
        sliderAnswer.isContinuous = true
        sliderAnswer.minimumTrackTintColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 0.6)
        sliderAnswer.value = 2
        sliderAnswer.maximumValue = 4
        sliderAnswer.thumbTintColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        sliderAnswer.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(sliderAnswer)
        
        sliderAnswer.topAnchor.constraint(equalTo: labelAnswer.bottomAnchor, constant: 30 * QUtils.optimizeRatio()).isActive = true
        sliderAnswer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30 * QUtils.optimizeRatio()).isActive = true
        sliderAnswer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30 * QUtils.optimizeRatio()).isActive = true
        
        let unit = (self.view.frame.size.width - 60 * QUtils.optimizeRatio()) / 4
        for i in 0 ..< 5 {
            let note = UIView()
            note.translatesAutoresizingMaskIntoConstraints = false
            note.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            self.view.addSubview(note)
            
            note.topAnchor.constraint(equalTo: sliderAnswer.bottomAnchor, constant: 10 * QUtils.optimizeRatio()).isActive = true
            note.centerXAnchor.constraint(equalTo: sliderAnswer.leadingAnchor, constant: unit * CGFloat(i)).isActive = true
            note.widthAnchor.constraint(equalToConstant: 1).isActive = true
            note.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
        
        buttonPrevious.translatesAutoresizingMaskIntoConstraints = false
        buttonPrevious.clipsToBounds = true
        buttonPrevious.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .normal)
        buttonPrevious.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), for: .highlighted)
        buttonPrevious.setTitle("이전", for: .normal)
        buttonPrevious.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonPrevious.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonPrevious.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonPrevious.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonPrevious.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonPrevious)
        
        buttonPrevious.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -7 * QUtils.optimizeRatio()).isActive = true
        buttonPrevious.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonPrevious.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        buttonPrevious.heightAnchor.constraint(equalToConstant: buttonPrevious.layer.cornerRadius * 2).isActive = true
        
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        buttonNext.clipsToBounds = true
        buttonNext.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonNext.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)), for: .highlighted)
        buttonNext.setTitle("다음", for: .normal)
        buttonNext.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonNext.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonNext.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonNext.layer.cornerRadius = buttonPrevious.layer.cornerRadius
        buttonNext.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonNext)
        
        buttonNext.topAnchor.constraint(equalTo: buttonPrevious.topAnchor).isActive = true
        constraintWide = buttonNext.leadingAnchor.constraint(equalTo: buttonPrevious.leadingAnchor)
        constraintWide.isActive = true
        constraintNarrow = buttonNext.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 8 * QUtils.optimizeRatio())
        constraintNarrow.isActive = false
        buttonNext.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonNext.heightAnchor.constraint(equalTo: buttonPrevious.heightAnchor).isActive = true
        
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        (self.navigationController as? SignupNavigationViewController)?.navigatingView.step = depth + 2
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonPrevious:
            guard currentPage > 0 else { break }
            currentPage -= 1
            loadQuestion()
            break
            
        case buttonNext:
            guard currentPage < dataArray.count - 1 else {
                let alertController = AlertPopupViewController(withTitle: "안내", message: "\(labelTitle.text ?? "") 설문이 완료되었습니다.\n다음 단계로 진행하시겠습니까?")
                alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "아니오", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "예", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                    self.gotoNextStep()
                }))
                self.view.addSubview(alertController.view)
                self.addChild(alertController)
                alertController.show()
                break
            }
            currentPage += 1
            loadQuestion()
            break
            
        default:
            break
        }
    }
    
    private func reloadData() {
        let loadSurveys = {() -> Void in
            SurveyManager.shared.reloadSurveys { (isSucceed) in
                guard isSucceed else { return }
                
                guard let codesArray = AppDataManager.shared.data["survey1"],
                    let titleString = codesArray[self.depth].code_name,
                    let key = codesArray[self.depth].code,
                    let array = SurveyManager.shared.dataDict[key]  else { return }
                
                self.dataArray.removeAll()
                self.dataArray.append(contentsOf: array)
                
                self.labelTitle.text = titleString
                
                self.loadQuestion()
                
                self.view.layoutIfNeeded()
            }
        }
        
        guard AppDataManager.shared.data.count == 0 else {
            loadSurveys()
            return
        }
        
        AppDataManager.shared.reloadData { (complete) in
            loadSurveys()
        }
    }
    
    private func loadQuestion() {
        let data = dataArray[currentPage]
        
        labelCount.text = "\(currentPage + 1) / \(dataArray.count)"
        
        buttonPrevious.isHidden = currentPage == 0
        constraintWide.isActive = currentPage == 0
        constraintNarrow.isActive = currentPage > 0
        
        labelQuestion.text = data.text
        sliderAnswer.value = 2
        
        sliderValueChanged(sliderAnswer)
        
        self.view.layoutIfNeeded()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        sender.setValue(sender.value.rounded(), animated: false)
        
        let answers = ["아니다", "조금 아니다", "보통", "조금 그렇다", "그렇다"]
        labelAnswer.text = "\(answers[Int(sender.value)])"
    }
    
    private func gotoNextStep() {
        let viewController = SignupStepViewController(step: depth + 2)
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
}

extension SignupSurveyViewController: SignupStepViewControllerDelegate {
    func signupStepViewController(doneProgress viewController: SignupStepViewController) {
        guard let codesArray = AppDataManager.shared.data["survey1"] else { return }
        
        guard depth < codesArray.count - 1 else {
            let viewController = SignupSelectFavorLooksViewController()
            self.navigationController?.pushViewController(viewController, animated: false)
            
            viewController.dismiss(animated: true, completion: nil)
            return
        }
        
        let viewController = SignupSurveyViewController(depth: depth + 1)
        self.navigationController?.pushViewController(viewController, animated: false)
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func signupStepViewController(titleOf viewController: SignupStepViewController) -> String? {
        guard let codesArray = AppDataManager.shared.data["survey1"] else { return nil }
        guard depth < codesArray.count - 1 else { return "이상형 외모 설정" }
        return AppDataManager.shared.data["survey1"]?[depth + 1].code_name
    }
}
