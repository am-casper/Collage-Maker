part of 'edit_frame_bloc.dart';

// ignore: must_be_immutable
class EditFrameState extends Equatable {
  final List<ImageModel> images;
  final bool isImageSelected;
  const EditFrameState({required this.images, required this.isImageSelected});
  EditFrameState.initial()
      : images = [],
        isImageSelected = false;

  @override
  List<Object> get props => [identityHashCode(this)];
}

class SaveCollageSuccess extends EditFrameState {
  final bool isUploadSuccess;
  const SaveCollageSuccess(
      {required this.isUploadSuccess,
      required super.images,
      required super.isImageSelected});
  @override
  List<Object> get props => [isUploadSuccess];
}
