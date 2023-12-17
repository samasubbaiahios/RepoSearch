//
//  AvatarView.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import SwiftUI

struct AvatarView: View {
    @ObservedObject var viewModel: AvatarViewModel
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.avatarURL) { image in
                image.resizable()
                    
            } placeholder: {
                ProgressView().progressViewStyle(.circular)
                Image("avatar")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            .frame(width: 64, height: 64)
            .clipShape(.circle)
            
            Text(viewModel.avatarTitle)
                .font(.title3)
                .lineLimit(3)
                .padding(.vertical, 8.0)
        }
    }
}

//#Preview {
//    AvatarView()
//}
