//
//  Created by Alex.M on 06.06.2022.
//

import Foundation
import SwiftUI

struct PermissionActionView: View {
  
  enum PermissionType {
    case library(PermissionsService.PhotoLibraryPermissionStatus)
    case camera(PermissionsService.CameraPermissionStatus)
  }
  
  @Environment(\.mediaPickerTheme) private var theme
  
  let type: PermissionType
  
  @State private var showSheet = false
  
  var body: some View {
    ZStack {
      if showSheet {
        LimitedLibraryPickerProxyView(isPresented: $showSheet) {
          DispatchQueue.main.async {
            PermissionsService.shared.updatePhotoLibraryAuthorizationStatus()
          }
        }
        .frame(width: 1, height: 1)
      }
      
      switch type {
      case .library(let status):
        buildLibraryActionView(status)
      case .camera(let status):
        buildCameraActionView(status)
      }
    }
  }
}

private extension PermissionActionView {
  
  @ViewBuilder
  func buildLibraryActionView(_ status: PermissionsService.PhotoLibraryPermissionStatus) -> some View {
    switch status {
    case .authorized, .unknown:
      EmptyView()
    case .limited:
      PermissionsErrorView(text: theme.text.error.limitedLibraryPermission) {
        showSheet = true
      }
    case .unavailable:
      goToSettingsButton(text: theme.text.error.unavailableLibraryPermission)
    }
  }
  
  @ViewBuilder
  func buildCameraActionView(_ status: PermissionsService.CameraPermissionStatus) -> some View {
    switch status {
    case .authorized, .unknown:
      EmptyView()
    case .unavailable:
      goToSettingsButton(text: theme.text.error.unavailableCameraPermission)
    }
  }
  
  func goToSettingsButton(text: String) -> some View {
    PermissionsErrorView(
      text: text,
      action: {
        DispatchQueue.main.async {
          guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
          if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
          }
        }
      }
    )
  }
}
