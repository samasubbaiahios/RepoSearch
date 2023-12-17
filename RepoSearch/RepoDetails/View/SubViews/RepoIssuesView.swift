//
//  RepoIssuesView.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/17/23.
//

import SwiftUI

struct RepoIssuesView: View {
    let issues: Issues?
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image("issues")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text("Issues")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            ForEach(issues ?? [], id: \.id) { issue in
                IssueView(issueModel: issue)
            }
        }
    }
}

struct IssueView: View {
    let issueModel: Issue
    var body: some View {
        HStack(alignment: .center) {
            Image("bug")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 8.0) {
                Text(issueModel.title ?? "-")
                    .font(.headline)
                Text(issueModel.state ?? "open")
                    .font(.subheadline)
                    .foregroundColor(issueModel.state == "open" ? .red:.secondary)
                SectionalView(sectionName: "Created: ", details: issueModel.createdAt?.toDateString() ?? "-")
                    .padding(.vertical, 0)
                SectionalView(sectionName: "Last Updated:", details: issueModel.updatedAt?.toDateString() ?? "-")
            }
            Spacer()
            Badge(text: issueModel.comments.description, imageName: "ellipses.bubble")
                .padding(.trailing, 8.0)
                .foregroundColor(.orange)
            .font(.callout)
            .padding(.bottom)
            
        }
        .padding(.top, 16.0)
    }
}

struct Badge: View {
    let text: String
    let imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}


