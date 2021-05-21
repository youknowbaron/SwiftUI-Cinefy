//
//  HeaderRow.swift
//  Cinefy
//
//  Created by vobach on 20/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeaderRow: View {
    
    var cast: Cast
    
    var body: some View {
        HStack(alignment: .top) {
            
            NetworkImage(url: cast.profilePath)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Known for")
                    .font(.system(size: 16, weight: .medium))
                if let knowForDepartment = cast.knownForDepartment {
                    Text(knowForDepartment)
                }
//                Text(cast.alsoKnownAs)
//                    .foregroundColor(.subTextColor)
//                    .lineLimit(nil)
            }
            .padding(.leading, 8)
                .padding(.top, 8)
        }
    }
}

