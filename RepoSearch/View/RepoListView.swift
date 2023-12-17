//
//  ContentView.swift
//  RepoSearch
//
//  Created by Venkata Sama on 12/16/23.
//

import SwiftUI

struct RepoListView: View {
    @ObservedObject var viewModel = RepoListViewModel()
    var body: some View {
        NavigationView {
            
            List {
//                SearchBarView(placeholder: "Search movies", text: "")
//                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
//                if self.movieSearchState.movies != nil {
//                    ForEach(self.movieSearchState.movies!) { movie in
//                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
//                            VStack(alignment: .leading) {
//                                Text(movie.title)
//                                Text(movie.yearText)
//                            }
//                        }
//                    }
//                }
                
            }
            .onAppear(perform: viewModel.fetchTopStories)
            .navigationBarTitle("Search")
        }
    }
}
struct SearchBarView: UIViewRepresentable {

    let placeholder: String
    @Binding var text: String
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: self.$text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

}
#Preview {
    RepoListView()
}
