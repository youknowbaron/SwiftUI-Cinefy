//
//  BiographyRow.swift
//  Cinefy
//
//  Created by vobach on 20/05/2021.
//

import SwiftUI

struct BiographyRow : View {
    let biography: String?
    let birthDate: String?
    let deathDate: String?
    let placeOfBirth: String?
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if biography != nil {
                Text("Biography")
                    .font(.system(size: 16, weight: .medium))
                Text(biography!)
                    .foregroundColor(.subTextColor)
                    .font(.body)
                    .lineLimit(isExpanded ? 1000 : 4)
            }
            Button(action: {
                self.isExpanded.toggle()
            }) {
                Text(isExpanded ? "Less": "Read more").foregroundColor(.highlightColor)
            }
            if birthDate != nil {
                Text("Birthday")
                    .font(.system(size: 16, weight: .medium))
                Text(birthDate!)
                    .foregroundColor(.subTextColor)
                    .font(.body)
                    .lineLimit(1)
            }
            if placeOfBirth != nil {
                Text("Place of birth")
                    .font(.system(size: 16, weight: .medium))
                Text(placeOfBirth!)
                    .foregroundColor(.subTextColor)
                    .font(.body)
                    .lineLimit(1)
            }
            if deathDate != nil {
                Text("Day of death")
                    .font(.system(size: 16, weight: .medium))
                Text(deathDate!)
                    .foregroundColor(.secondary)
                    .font(.body)
                    .lineLimit(1)
            }
        }
    }
}
