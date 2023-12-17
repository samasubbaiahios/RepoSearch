//
//  AvatarViewModel.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import Foundation
import Combine

class AvatarViewModel: ObservableObject {

    @Published private(set) var avatarURL: URL?
    @Published private(set) var avatarTitle: String
    
    public init(avatarURL: URL? = nil, avatarTitle: String) {
        self.avatarURL = avatarURL
        self.avatarTitle = avatarTitle
    }
    
}
