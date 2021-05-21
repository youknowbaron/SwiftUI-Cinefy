//
//  Avatar.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct AvatarView: View {
    
    var url: String?
    var size: CGFloat = 32
    
    var body: some View {
        
        if let path = url {
            WebImage(url: URL(string: path.addImageUrl())!)
                .resizable()
                .frame(width: size, height: size)
                .scaledToFill()
                .cornerRadius(5)
        } else {
            Image("placeholderavatar")
                .resizable()
                .frame(width: size, height: size)
                .scaledToFill()
                .cornerRadius(5)
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(url: "")
    }
}
