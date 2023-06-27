//
//  SearchCategoryTableView.swift
//  Musique
//
//  Created by Marat Guseynov on 14.06.2023.
//

import UIKit

protocol SearchTableViewProtocol: AnyObject {
    func presentPlayer(track: [SearchTracks]?, indexPath: IndexPath?)
}

class SearchCategoryTableView: UITableView {
    
    var cellsTableView = [SearchTracks]()
    var selectedIndexPath: IndexPath?
    weak var searchDelegate: SearchTableViewProtocol?
    
    weak var myDelegate: PresentDelagate?
    
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .mBlack
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        super.register(SearchCategoryTableViewCell.self, forCellReuseIdentifier: SearchCategoryTableViewCell.reuseID)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTableView(cells: [SearchTracks]) {
        self.cellsTableView = cells
    }
    
//    func switchCategoryCell(type: SearchType) -> UITableViewCell {
//        switch type {
//        case .mix:
//            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
//
//            let track = cellsTableView[indexPath.row]
//            cell.configureCell(model: track)
//            return cell
//
//        case .musicArtist:
//            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
//
//            let track = cellsTableView[indexPath.row]
//            cell.configureCell(model: track)
//            return cell
//        case .album:
//            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
//
//            let track = cellsTableView[indexPath.row]
//            cell.configureCell(model: track)
//            return cell
//        case .song:
//            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
//
//            let track = cellsTableView[indexPath.row]
//            cell.configureCell(model: track)
//            return cell
//        }
//    }
}

extension SearchCategoryTableView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
        
        let track = cellsTableView[indexPath.row]
        guard let name = track.artistName, let subtitle = track.trackName else {
            return cell
        }
        cell.configureCell(title: name,
                           subtitle: subtitle,
                           imageUrlString: track.artworkUrl60)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    //MARK: - Header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .mBlack
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 20, height: headerView.frame.height))
        headerLabel.text = "Header Title"
        headerLabel.font = UIFont.systemFont(ofSize: 18)
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension SearchCategoryTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myDelegate?.presentVC(track: cellsTableView, indexPath: indexPath)
        
        if let selectedIndexPath = selectedIndexPath, selectedIndexPath == indexPath {
            // Ячейка уже выбрана, нет необходимости повторно выделять её
            return
        }

        if let cell = tableView.cellForRow(at: indexPath) as? SearchCategoryTableViewCell {
            cell.cellView.backgroundColor = UIColor.systemGray6// Выбранный цвет фона ячейки
        }
        if let selectedIndexPath = selectedIndexPath, let selectedCell = tableView.cellForRow(at: selectedIndexPath) as? SearchCategoryTableViewCell {
            selectedCell.cellView.backgroundColor = .mBlack // Сброс цвета предыдущей выбранной ячейки
        }
        selectedIndexPath = indexPath
    }
}


