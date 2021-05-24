//
//  ShimmerMovieRow.swift
//  Cinefy
//
//  Created by vobach on 24/05/2021.
//

import SwiftUI

struct ShimmerMovieRow: View {
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(.overlayColor)
                .frame(width: 100, height: 150)
                .cornerRadius(5)
            
            VStack(alignment: .leading, spacing: 8) {
                Rectangle()
                    .foregroundColor(.overlayColor)
                    .frame(width: 100, height: 18)
                    .padding(.vertical, 2)
                
                Rectangle()
                    .foregroundColor(.overlayColor)
                    .frame(width: 140, height: 22)
                    .padding(.vertical, 2)
                
                HStack {
                    HStack {
                        Spacer()
                    }
                    .frame(height: 16)
                    .background(Color.overlayColor)
                    
                    Rectangle().frame(width: 30, height: 16)
                        .foregroundColor(.clear)
                }
                
                HStack {
                    Spacer()
                }
                .frame(height: 16)
                .background(Color.overlayColor)
                
                Rectangle()
                    .foregroundColor(.overlayColor)
                    .frame(width: 180, height: 16)
                    .padding(.vertical, 2)
                
            }.padding(.leading, 8)
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
}

struct ShimmerMovieRow_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerMovieRow()
    }
}
