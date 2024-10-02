//
//  GlobalView.swift
//  Earthdawn Char Manager
//
//  Created by Ed Salter on 10/2/24.
//

import SwiftUI

struct GlobalView: View {
	@ObservedObject var viewModel: GlobalViewModel
	
    var body: some View {
		if let character = viewModel.character {
			Text(character.name!)
		}

    }
}

#Preview {
	GlobalView(viewModel: GlobalViewModel())
}
