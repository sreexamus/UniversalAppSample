//
//  DashboardCellViewModel.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 4/17/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import UIKit

protocol Thumbnail {
    func configureThumbnail()
}

enum DashboardTileType: String {
    case finance
    case retirement
    case relation
    case accounts
}

struct Failure {
    let headerText: String
    let thumbnail: Thumbnail?
    let tileType: DashboardTileType
    let hudKey: Bool
}

protocol NavigationTileViewModel {
    func getReuseIdentifier() -> String
    var overrideDefaultSize: ((CGFloat, CGFloat?) -> CGSize?)? { get }
}

enum TileViewModel: NavigationTileViewModel {
    var overrideDefaultSize: ((CGFloat, CGFloat?) -> CGSize?)? {
        return nil
    }
    
    case displayAsEmpty(DisplayItems)
    case display(DisplayItems)
    case failure(Failure)

    
    struct DisplayItems {
        let headerText: String?
        let subheaderText: String?
        let captionText: String?
        let thumbnail: Thumbnail?
        let tileType: DashboardTileType
        let opaKey: Bool
        let ctaKey: Bool
        let hudKey: Bool
        let tapAction: () -> Void
        let isSelectable: Bool
        
        init(headerText: String?,
             tileType: DashboardTileType,
             subheaderText: String? = nil,
             captionText: String? = nil,
             thumbnail: Thumbnail?,
             opaKey: Bool = false,
             ctaKey: Bool = false,
             hudKey: Bool = false,
             tapAction: @escaping (() -> Void),
             isSelectable: Bool = true) {
            self.headerText = headerText
            self.tileType = tileType
            self.subheaderText = subheaderText
            self.captionText = captionText
            self.thumbnail = thumbnail
            self.opaKey = opaKey
            self.ctaKey = ctaKey
            self.hudKey = hudKey
            self.tapAction = tapAction
            self.isSelectable = isSelectable
        }
    }
    
    func getTileType() -> DashboardTileType {
        switch self {
        case .displayAsEmpty(let displayItems): return displayItems.tileType
        case .display(let displayItems): return displayItems.tileType
        case .failure(let failure): return failure.tileType
        }
    }
    
    func getReuseIdentifier() -> String {
        if case .accounts = getTileType() {
            return CellReuseIdentifier.AccountsDashboardFooterCell.rawValue
        }
        
        return CellReuseIdentifier.AccountsDashboardCell.rawValue
    }
}
