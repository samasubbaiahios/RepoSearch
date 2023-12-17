//
//  RepoListCell.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import SwiftUI

struct RepoCell: View {
    let repoDetails: RepoModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image("repo")
                .resizable()
                .frame(width: 40.0, height: 40.0)
            VStack(alignment: .leading, spacing: 0) {
                Text(repoDetails.name ?? "")
                    .font(.headline)
                    .padding(.bottom, 8.0)
                
                Text(repoDetails.fullName ?? "")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                .font(.callout)
            }
            .padding(.leading, 8.0)
        }
        .padding(.top, 4.0)
    }
}
