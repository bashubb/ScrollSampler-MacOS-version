//
//  StringExtension.swift
//  ScrollSamplerMac
//
//  Created by HubertMac on 24/04/2024.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
