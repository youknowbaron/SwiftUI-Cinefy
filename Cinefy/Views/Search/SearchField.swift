//
//  SearchField.swift
//  Cinefy
//
//  Created by vobach on 19/05/2021.
//

import SwiftUI
import Combine

public struct SearchField : View {
    @ObservedObject var searchTextWrapper: SearchViewModel
    let placeholder: String
    @Binding var isSearching: Bool
    var dismissButtonTitle: String
    var dismissButtonCallback: (() -> Void)?
    
    private var searchCancellable: Cancellable? = nil
    
    init(searchTextWrapper: SearchViewModel,
                placeholder: String,
                isSearching: Binding<Bool>,
                dismissButtonTitle: String = "Cancel",
                dismissButtonCallback: (() -> Void)? = nil) {
        self.searchTextWrapper = searchTextWrapper
        self.placeholder = placeholder
        self._isSearching = isSearching
        self.dismissButtonTitle = dismissButtonTitle
        self.dismissButtonCallback = dismissButtonCallback
        
        self.searchCancellable = searchTextWrapper.searchSubject.sink(receiveValue: { value in
            isSearching.wrappedValue = !value.isEmpty
        })
    }
    
    public var body: some View {
        GeometryReader { reader in
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: "magnifyingglass")
                TextField(self.placeholder,
                          text: self.$searchTextWrapper.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                if !self.searchTextWrapper.searchText.isEmpty {
                    Button(action: {
                        self.searchTextWrapper.searchText = ""
                        self.isSearching = false
                        self.dismissButtonCallback?()
                    }, label: {
                        Text(self.dismissButtonTitle).foregroundColor(.pink)
                    })
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
            //            .preference(key: OffsetTopPreferenceKey.self,
            //                        value: reader.frame(in: .global).minY)
            .padding(4)
        }.frame(height: 44)
    }
}
