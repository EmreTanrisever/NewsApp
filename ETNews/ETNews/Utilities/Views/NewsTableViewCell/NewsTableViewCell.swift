//
//  NewsTableViewCell.swift
//  ETNews
//
//  Created by Emre Tanrısever on 17.03.2024.
//

import UIKit
import struct ETNetworkKit.NewsModel
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let newsPublishedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let newsSourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemRed
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configure()
    }
    
}

extension NewsTableViewCell {
    
    private func configure() {
        
        addItemToContentView(items: [
            newsImageView,
            newsTitleLabel,
            newsPublishedLabel,
            newsSourceLabel
        ])
        
        setConstraints()
    }
    
    private func addItemToContentView(items: [UIView]) {
        
        items.forEach { view in
            contentView.addSubview(view)
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            newsImageView.widthAnchor.constraint(equalToConstant: 100),
            
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            newsPublishedLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 4),
            newsPublishedLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -4),
            
            newsSourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsSourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

extension NewsTableViewCell {
    
    func setDataToCell(news: NewsModel) {
        
        guard let newsPublisedAt = news.publishedAt else { return }
        guard let sourceName = news.source.name else { return }
        
        DispatchQueue.main.async {
            
            self.newsTitleLabel.text = news.title
            self.newsPublishedLabel.text = " \(newsPublisedAt.dateFormetter()) "
            self.newsSourceLabel.text = " \(sourceName) "
            
            if let url = news.urlToImage {
                self.newsImageView.kf.setImage(with: URL(string: url))
            } else {
                self.newsImageView.image = UIImage(systemName: "photo")
            }
        }
    }
}
