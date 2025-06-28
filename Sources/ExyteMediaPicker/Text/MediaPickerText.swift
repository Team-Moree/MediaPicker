//
//  MediaPickerText.swift
//  ExyteMediaPicker
//
//  Created by 홍성준 on 6/28/25.
//

import Foundation

public struct MediaPickerText: Sendable {
  public let main: Main
  public let error: Error

  public init(
    main: Main = .init(),
    error: Error = .init()
  ) {
    self.main = main
    self.error = error
  }
}

extension MediaPickerText {
  
  public struct Main: Sendable {
    public let emptyData: String
    
    public init(
      emptyData: String = "Empty data"
    ) {
      self.emptyData = emptyData
    }
  }
  
  public struct Error: Sendable {
    public let limitedLibraryPermission: String
    public let unavailableLibraryPermission: String
    public let unavailableCameraPermission: String
    
    public init(
      limitedLibraryPermission: String = "Setup Photos access to see more photos here",
      unavailableLibraryPermission: String = "Allow Photos access in settings to see photos here",
      unavailableCameraPermission: String = "Allow Camera access in settings to see live preview"
    ) {
      self.limitedLibraryPermission = limitedLibraryPermission
      self.unavailableLibraryPermission = unavailableLibraryPermission
      self.unavailableCameraPermission = unavailableCameraPermission
    }
  }
}
