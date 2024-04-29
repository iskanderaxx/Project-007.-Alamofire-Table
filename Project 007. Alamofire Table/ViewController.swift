
import UIKit
import Alamofire

final class ViewController: UIViewController {
    
    // MARK: - UI Elements & Oulets
    
    var cards: [Card] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "indentifier")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cards (Version 1)"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViewsHierarchy()
        setupLayout()
        fetchCards()
    }
    
    // MARK: - Setup & Layout
    
    private func setupViewsHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func fetchCards() {
        let request = AF.request("https://api.magicthegathering.io/v1/cards")
        request.responseDecodable(of: Cards.self) { (data) in
            guard let versionOne = data.value else { return }
            let cards = versionOne.cards
            self.cards = cards
            
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extesions

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "indentifier", for: indexPath) as! TableViewCell
        let cardForRow = cards[indexPath.row]
        cell.card = cardForRow
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        viewController.card = cards[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

