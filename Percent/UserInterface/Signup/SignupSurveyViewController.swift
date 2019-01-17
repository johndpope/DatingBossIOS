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

private let kTagButtonNote = 1001

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
    
    private var coverView = UIView()
    
    init(navigationViewEffect effect: UIVisualEffect? = nil, depth dCode: Int? = nil) {
        var depthValue = dCode ?? 0
        
        if dCode == nil, let lastData = SurveyManager.shared.answers.last, let type1_cd = lastData.type1_cd {
            if type1_cd == "10" {
                depthValue = 0
            } else if type1_cd == "20" {
                depthValue = 1
            } else if type1_cd == "30" {
                depthValue = 2
            }
        }
        
        depth = depthValue
        
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
        labelAnswer.lineBreakMode = .byWordWrapping
        labelAnswer.layer.cornerRadius = 30 * QUtils.optimizeRatio()
        self.view.addSubview(labelAnswer)
        
        labelAnswer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelAnswer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        labelAnswer.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.65).isActive = true
        labelAnswer.heightAnchor.constraint(equalToConstant: labelAnswer.layer.cornerRadius * 2).isActive = true
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.isUserInteractionEnabled = true
        self.view.addSubview(containerView)
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(self.recognizedTapGestureOnSlider(_:)))
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        containerView.topAnchor.constraint(equalTo: labelAnswer.bottomAnchor, constant: 10 * QUtils.optimizeRatio()).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        sliderAnswer.translatesAutoresizingMaskIntoConstraints = false
        sliderAnswer.isContinuous = true
        sliderAnswer.minimumTrackTintColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 0.6)
        sliderAnswer.setThumbImage(UIImage(named: "img_signup_slider"), for: .normal)
        sliderAnswer.value = 2
        sliderAnswer.maximumValue = 4
        sliderAnswer.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: .valueChanged)
        containerView.addSubview(sliderAnswer)
        
        sliderAnswer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20 * QUtils.optimizeRatio()).isActive = true
        sliderAnswer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30 * QUtils.optimizeRatio()).isActive = true
        sliderAnswer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30 * QUtils.optimizeRatio()).isActive = true
        
        let unit = (self.view.frame.size.width - 88 * QUtils.optimizeRatio()) / 4
        for i in 0 ..< 5 {
            let note = UIView()
            note.translatesAutoresizingMaskIntoConstraints = false
            note.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            containerView.addSubview(note)
            
            note.topAnchor.constraint(equalTo: sliderAnswer.bottomAnchor, constant: 10 * QUtils.optimizeRatio()).isActive = true
            note.centerXAnchor.constraint(equalTo: sliderAnswer.leadingAnchor, constant: 14 * QUtils.optimizeRatio() + unit * CGFloat(i)).isActive = true
            note.widthAnchor.constraint(equalToConstant: 1).isActive = true
            note.heightAnchor.constraint(equalToConstant: 10).isActive = true
            note.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20 * QUtils.optimizeRatio()).isActive = true
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
        
        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(coverView)
        
        coverView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        coverView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        coverView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        coverView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
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
                alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
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
                
                let typeCode = SurveyManager.shared.answers.last?.type2_cd
                
                self.dataArray.removeAll()
                for i in 0 ..< array.count {
                    let item = array[i]
                    self.dataArray.append(item)
                    
                    if typeCode != nil, typeCode == item.type2_cd {
                        self.currentPage = i
                    }
                }
                
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
        var data = dataArray[currentPage]
        
        var value = 2
        
        var index: Int?
        var answers = SurveyManager.shared.answers
        for i in 0 ..< answers.count {
            let item = answers[i]
            guard item.type2_cd == data.type2_cd ?? "fakeId" else { continue }
            index = i
            
            dataArray[currentPage] = item
            data = item
            break
        }
        
        if index == nil {
            data.answer = 2
            answers.append(data)
        } else {
            value = data.answer ?? 2
            answers[index!] = data
        }
        
        SurveyManager.shared.answers = answers
        SurveyManager.shared.commitSurveyAnswer()
        
        labelCount.text = "\(currentPage + 1) / \(dataArray.count)"
        
        buttonPrevious.isHidden = currentPage == 0
        constraintWide.isActive = currentPage == 0
        constraintNarrow.isActive = currentPage > 0
        
        labelQuestion.text = data.text
        sliderAnswer.value = Float(value)
        
        sliderValueChanged(sliderAnswer)
        
        coverView.isHidden = true
        
        self.view.layoutIfNeeded()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        sender.setValue(sender.value.rounded(), animated: false)
        
        let ansStrings = ["아니다", "조금 아니다", "보통", "조금 그렇다", "그렇다"]
        labelAnswer.text = "\(ansStrings[Int(sender.value)])"
        
        let data = dataArray[currentPage]
        
        var index: Int?
        var answers = SurveyManager.shared.answers
        for i in 0 ..< answers.count {
            let item = answers[i]
            guard item.type2_cd == data.type2_cd ?? "fakeId" else { continue }
            index = i
            break
        }
        
        if index != nil {
            data.answer = Int(sender.value)
            answers[index!] = data
        }
        
        SurveyManager.shared.answers = answers
        SurveyManager.shared.commitSurveyAnswer()
    }
    
    @objc private func recognizedTapGestureOnSlider(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view).x
        
        let unit = (self.view.frame.size.width - 88 * QUtils.optimizeRatio()) / 4
        let normalize = ((location - 44 * QUtils.optimizeRatio() + (unit / 2)) / unit).rounded(.down)
        
        let gap = location - (normalize * unit) - 44 * QUtils.optimizeRatio()
        
        if gap > -38 * QUtils.optimizeRatio(), gap < 38 * QUtils.optimizeRatio() {
            sliderAnswer.value = Float(normalize)
            sliderValueChanged(sliderAnswer)
        }
    }
    
    private func gotoNextStep() {
        guard depth > 1 else {
            let viewController = SignupStepViewController(step: self.depth + 3)
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
            return
        }
        
        LoadingIndicatorManager.shared.showIndicatorView()
        
        var surveyList = [[String:Any]]()
        for survey in SurveyManager.shared.answers {
            var dict = [String:Any]()
            dict["survey_idx"] = survey.survey_idx
            dict["answer"] = (survey.answer ?? 2) + 1
            surveyList.append(dict)
        }
        
        var params = [String:Any]()
        params["surveyList"] = surveyList
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Survey + "\(MyData.shared.mem_idx)", params: params) { (isSucceed, errMessage, response) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            guard let responseData = response as? [String:Any],
                let status = responseData["Status"] as? String,
                status == "OK"  else {
                    InstanceMessageManager.shared.showMessage(kStringErrorUnknown, margin: self.buttonNext.frame.size.height + 8 * QUtils.optimizeRatio())
                    return
            }
            
            var params = [String:Any]()
            params["sign_up_fl"] = "l"
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Account.ChangeStatus + "\(MyData.shared.mem_idx)", method: .patch, params: params, completion: nil)
            
            let viewController = SignupStepViewController(step: 5)
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
        }
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
