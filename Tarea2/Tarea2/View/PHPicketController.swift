import Photos
import PhotosUI


// MARK: - PHPicker Configurations (PHPickerViewControllerDelegate)
extension PerfilViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
         picker.dismiss(animated: true, completion: .none)
         results.forEach { result in
               result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
               guard let image = reading as? UIImage, error == nil else { return }
               DispatchQueue.main.async {
                   self.PerfilImageView.image = image
                   // TODO: - Here you get UIImage
               }
          }
       }
  }

   /// call this method for `PHPicker`
   func openPHPicker() {
       var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
       phPickerConfig.selectionLimit = 1
       phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
       let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
       phPickerVC.delegate = self
       present(phPickerVC, animated: true)
   }
}
