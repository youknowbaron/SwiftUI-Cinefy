//
//  NetworkImage.swift
//  Cinefy
//
//  Created by vobach on 20/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct NetworkImage: View {
    
    var url: String?
    
    var body: some View {
        ZStack {
            if url != nil {
                WebImage(url: URL(string: url!.addImageUrl())!)
                    .resizable()
                    .frame(width: 100, height: 150)
                    .scaledToFill()
            } else {
                Rectangle()
                    .cornerRadius(10)
                    .frame(width: 100, height: 150)
                    .foregroundColor(.gray)
                    .opacity(0.1)
            }
        }
    }
}

struct NetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImage()
    }
}
