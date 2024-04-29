
import UIKit

// MARK: - Protocols

protocol CardsViewProtocol: AnyObject {
    func reloadData()
    func showCardDetail(_ card: Card)
}

final class ViewController: UIViewController, CardsViewProtocol {
    
    // MARK: - Data
    
    var presenter: CardsPresenterProtocol?
    
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
        
        presenter = CardsPresenter(view: self)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Setup & Layout
    
    private func setupViewsHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() { tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showCardDetail(_ card: Card) {
        let viewController = DetailViewController()
        viewController.card = card
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Extesions

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "indentifier", for: indexPath) as! TableViewCell
        presenter?.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
    }
}

