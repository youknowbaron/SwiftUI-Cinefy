//
//  Top10Badge.swift
//  Cinefy
//
//  Created by vobach on 18/05/2021.
//

import SwiftUI

struct Top10Badge: View {
    
    var top: Int = 10
    
    var body: some View {
        VStack(spacing: 0){
            Text("TOP")
                .font(.system(size: 8, weight: .medium))
            Text("\(top)")
                .font(.system(size: 12, weight: .bold))
        }
        .padding(3)
        .background(Color.red)
        .cornerRadius(2)
    }
}

struct Top10Badge_Previews: PreviewProvider {
    static var previews: some View {
        Top10Badge()
    }
}
