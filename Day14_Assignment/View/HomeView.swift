//
//  ContentView.swift
//  Day14_Assignment
//
//  Created by Rayaheen Mseri on 23/09/1446 AH.
//
import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = NewsHomeViewModel()
    @State var hasLoaded: Bool = false
    @State var selectedNews: News? = nil
    @EnvironmentObject var darkModeManager: DarkModeManager
    @State var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                // Adds a divider at the top for UI separation
                Divider()
                    .padding(.horizontal)
                    .padding(.top, 2)

                Spacer()

                // Show a loading indicator before fetching news
                if !hasLoaded {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .foregroundColor(.black)
                } else {
                    // Show message if no news is found
                    if !viewModel.isLoading && viewModel.news.isEmpty {
                        Text("No News Found")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                    } else {
                        ScrollView {
                            // Iterate over filtered news results and display them
                            ForEach(searchNews()) { news in
                                VStack {
                                    NewsSectionView(news: news, isDarkMode: darkModeManager.isDarkMode)
                                    Divider()
                                        .padding([.top, .bottom], 4)
                                }
                                .padding(.horizontal)
                                .onTapGesture {
                                    selectedNews = news
                                }
                            }

                            // Show "Load More" button if there are more pages to fetch
                            if !viewModel.news.isEmpty && viewModel.currentPage <= viewModel.totalPages {
                                Button(action: {
                                    viewModel.loadNews()
                                }) {
                                    Text("Load More")
                                        .font(.headline)
                                        .foregroundColor(darkModeManager.isDarkMode ? .black : .white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(darkModeManager.isDarkMode ? .white : .black)
                                        .cornerRadius(20)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("Today's News")
                            .font(.largeTitle)
                            .bold()
                            .padding(.trailing, 55)
                        Spacer()

                        // Toggle to switch between dark mode and light mode
                        Toggle(isOn: $darkModeManager.isDarkMode) {
                            Text("DarkMode")
                        }
                    }
                }
            }
        }
        .padding(.top, 5)
        .searchable(text: $searchText) // Enables search functionality
        .onAppear {
            // Load news only once when the view appears for the first time
            if !hasLoaded {
                viewModel.loadNews()
                hasLoaded = true
            }
        }
        // Show an alert if there is an error in fetching news
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.erorrMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
        // Set the preferred color scheme based on user selection
        .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
    }

    // Filters the news articles based on the search query
    func searchNews() -> [News] {
        if searchText.isEmpty {
            return viewModel.news
        } else {
            let filteredNews = viewModel.news.filter { $0.title?.lowercased().contains(searchText.lowercased()) == true }
            return filteredNews
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(DarkModeManager())
}
