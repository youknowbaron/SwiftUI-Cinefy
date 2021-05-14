//
//  PlaceholderImage.swift
//  Cinefy
//
//  Created by vobach on 14/05/2021.
//

import SwiftUI

struct PlaceholderImage: View {
    var body: some View {
        Image(systemName: "photo.fill").resizable()
            .cornerRadius(30)
            .aspectRatio(2/1, contentMode: .fill)
    }
}

struct PlaceholderImage_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImage()
    }
}
