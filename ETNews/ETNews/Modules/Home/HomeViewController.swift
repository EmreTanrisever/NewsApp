//
//  ViewController.swift
//  ETNews
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import UIKit
import ETNetworkKit

protocol HomeViewProtocol: AnyObject {
    func configure()
    func reloadData()
    func setBackgroundColor(color: UIColor)
    func setTitleToNavigationController(title: String)
    func startLoading()
    func stopLoading()
    func setRowHeight(set rowHeight: CGFloat)
}

final class HomeViewController: UIViewController {

    private lazy var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var viewWidth = view.frame.width
    private lazy var viewHeight = view.frame.height
    
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
}

// MARK: - HomeViewProtocol's functions
extension HomeViewController: HomeViewProtocol {
    
    func configure() {
        addItemToView(views: [newsTableView, spinner])
        setConstraints()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    func setBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    func setTitleToNavigationController(title: String) {
        self.title = title
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    func setRowHeight(set rowHeight: CGFloat) {
        newsTableView.rowHeight = rowHeight
    }
}

// MARK: - HomeViewController's functions
extension HomeViewController {
    
    private func addItemToView(views: [UIView]) {
        views.forEach { item in
            view.addSubview(item)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spinner.topAnchor.constraint(equalTo: view.topAnchor),
            spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    
}

// MARK: - TableView Data Source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.returnNewsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}


