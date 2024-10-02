//
//  GlobalViewModel.swift
//  Earthdawn Char Manager
//
//  Created by Ed Salter on 10/2/24.
//

import Foundation

class GlobalViewModel: ObservableObject {
	@Published var character: Character?
	
	init(character: Character? = nil) {
		self.character = character
	}
}
