
import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    // MARK: - UI Elements & Oulets
    
    var card: Card?
    
//    private lazy var chosenSettingName: UILabel = {
//        let name = UILabel()
//        name.textColor = .black
//        name.font = UIFont.systemFont(ofSize: 15)
//        return name
//    }()
//    
//    public var chosenSettingIcon: UIImageView = {
//        let icon = UIImageView()
//        icon.clipsToBounds = true
//        return icon
//    }()
//    
//    private lazy var commentLabel: UILabel = {
//        let name = UILabel()
//        name.textColor = .black
//        name.textAlignment = .center
//        name.numberOfLines = 5
//        name.text = "Далее дизайн будет улучшаться :)"
//        name.clipsToBounds = true
//        name.font = UIFont.systemFont(ofSize: 15, weight: .bold)
//        return name
//    }()
    
    // MARK: - Lifecycle
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupHierarchy()
//        setupLayout()
//        useModelData()
//    }
    
    // MARK: - Setup & Layout
    
//    private func setupHierarchy() {
//        [chosenSettingName, chosenSettingIcon, commentLabel].forEach {
//            view.addSubview($0)
//        }
//    }
//    
//    private func setupLayout() {
//        chosenSettingName.snp.makeConstraints { make in
//            make.centerX.equalTo(chosenSettingIcon)
//            make.top.equalTo(chosenSettingIcon.snp.bottom).offset(10)
//        }
//        
//        chosenSettingIcon.snp.makeConstraints { make in
//            make.centerX.centerY.equalTo(view)
//            make.height.equalTo(90)
//            make.width.equalTo(90)
//        }
//        
//        commentLabel.snp.makeConstraints { make in
//            make.centerX.equalTo(chosenSettingName)
//            make.top.equalTo(chosenSettingName.snp.bottom).offset(20)
//        }
//    }
//    
//    private func useModelData() {
//        chosenSettingName.text = setting?.name
//        chosenSettingIcon.image = setting?.icon
//    }
}
