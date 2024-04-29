
import UIKit
import Alamofire
import SnapKit

// MARK: - Model

struct Item {
    var title: String
}

struct Characters: Decodable {
    let characters: [Character]
}

struct Character: Decodable {
    let name: String
    let role: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case role
        case imageURL = "image_url"
    }
}

class ViewController: UIViewController {
    
    // MARK: - UI Elements & Oulets
    
    var characters: [Character] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "indentifier001")
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Anime"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViews()
        setupLayout()
//        fetchSeries()
        fetchCharacter()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
//    func fetchSeries() {
//        let request = AF.request("https://api.jikan.moe/v4/anime/38000")
//        request.responseJSON { (data) in
//            print(data)
//        }
//    }
    
    func fetchCharacter() {
        let request = AF.request("https://api.jikan.moe/v3/manga/50/characters")
        request.responseDecodable(of: Characters.self) { (data) in
            guard let base = data.value else { return }
            let characters = base.characters
            self.characters = characters
            
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
        // 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "indentifier001", for: indexPath) as! TableViewCell
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}

