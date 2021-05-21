//
//  CastDetailScreen.swift
//  Cinefy
//
//  Created by vobach on 20/05/2021.
//

import SwiftUI

struct DetailCastScreen: View {
    
    @StateObject private var viewModel: PeopleViewModel = PeopleViewModel(apiService: APIServiceImpl())
    
    var cast: Cast
    
    var body: some View {
        let cast = viewModel.detailCast ?? cast
        List {
            HeaderRow(cast: cast)
            
            if cast.birthday != nil ||
                cast.biography != nil ||
                cast.placeOfBirth != nil ||
                cast.deathday != nil {
                BiographyRow(biography: cast.biography,
                             birthDate: cast.birthday,
                             deathDate: cast.deathday,
                             placeOfBirth: cast.placeOfBirth)
            }
        }
        .navigationBarTitle(cast.name)
        .onAppear {
            viewModel.getDetailCast(id: cast.id)
        }
    }
}

