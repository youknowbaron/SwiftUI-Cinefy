//
//  PeopleRow.swift
//  Cinefy
//
//  Created by vobach on 21/05/2021.
//

import SwiftUI

struct PeopleRow: View {
    
    var cast: Cast
    
    var body: some View {
        NetworkImage(url: cast.profilePath)
        
        VStack(alignment: .leading, spacing: 4) {
            
            Text(cast.name)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.highlightColor)
                .lineLimit(1)
            
            Text("Known for")
                .font(.system(size: 16, weight: .medium))
            
            if let knowForDepartment = cast.knownForDepartment {
                Text(knowForDepartment)
            }
        }
        .padding(.leading, 8)
            .padding(.top, 8)
    }
}
