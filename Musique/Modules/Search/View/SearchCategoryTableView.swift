//
//  SearchCategoryTableView.swift
//  Musique
//
//  Created by Marat Guseynov on 14.06.2023.
//

import UIKit

class SearchCategoryTableView: UITableView {
    
    var cellsTableView = [SearchTracks]()
    var selectedIndexPath: IndexPath?
    var currentType: SearchType = .mix
    
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
    
    func switchCategoryCell(indexPath: IndexPath) -> UITableViewCell {
        print(currentType)
        switch currentType {
        case .mix:
            let cell = dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
            
            let track = cellsTableView[indexPath.row]
            guard let trackName = track.trackName, let artistName = track.artistName else { return cell }
            cell.configureCell(title: trackName,
                               subtitle: artistName,
                               imageUrlString: track.artworkUrl60)
            return cell
        case .musicArtist:
            let cell = dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
            
            let track = cellsTableView[indexPath.row]
            guard let trackName = track.trackName, let artistName = track.artistName else { return cell }
            cell.configureCell(title: artistName,
                               subtitle: trackName,
                               imageUrlString: track.artworkUrl60)
            return cell
        case .album:
            let cell = dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
            
            let track = cellsTableView[indexPath.row]
            guard let collectionName = track.collectionName,
                  let artistName = track.artistName else {
                return cell
            }
            cell.configureCell(title: collectionName,
                               subtitle: artistName,
                               imageUrlString: track.artworkUrl60)
            return cell
        case .song:
            let cell = dequeueReusableCell(withIdentifier: SearchCategoryTableViewCell.reuseID, for: indexPath) as! SearchCategoryTableViewCell
            
            let track = cellsTableView[indexPath.row]
            guard let trackName = track.trackName, let artistName = track.artistName else { return cell }
            cell.configureCell(title: trackName,
                               subtitle: artistName,
                               imageUrlString: track.artworkUrl60)
            return cell
        }
    }
}

extension SearchCategoryTableView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return switchCategoryCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    //MARK: - Header
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        headerView.backgroundColor = .clear
//        
//        let headerLabel = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 20, height: headerView.frame.height))
//        headerLabel.text = "Results"
//        headerLabel.font = UIFont.systemFont(ofSize: 18)
//        headerView.addSubview(headerLabel)
//        
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
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


