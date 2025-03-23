//
//  NewsSectionView.swift
//  Day14_Assignment
//
//  Created by Rayaheen Mseri on 23/09/1446 AH.
//


import SwiftUI

@ViewBuilder
func NewsSectionView(news: News, isDarkMode: Bool) -> some View {
    Section {
        HStack {
            // Check if the news item has a valid image URL
            if let imageUrl = news.urlToImage, let url = URL(string: imageUrl) {
                // Load the image asynchronously with AsyncImage
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    // Show a progress view while the image loads
                    ProgressView()
                }
                .frame(width: 130, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 2)) // Rounded corners for the image
            } else {
                // If there is no image, show a fallback icon
                VStack {
                    Image(systemName: "exclamationmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(isDarkMode ? .white : .gray.opacity(0.2)) 
                }
                .frame(width: 130, height: 130)
            }
            
            // Display the title and description of the news
            VStack(alignment: .leading) {
                Text(news.title ?? "")
                    .font(.headline)
                Text(news.description ?? "")
                    .font(.caption)
            }
            .frame(height: 130)
            
        }
    }
}
