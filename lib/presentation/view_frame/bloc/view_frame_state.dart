part of 'view_frame_bloc.dart';

class ViewFrameState extends Equatable {
  final List<ImageModel> images;
  const ViewFrameState({required this.images});
  @override
  List<Object?> get props => [images];
}

class LoadingState extends ViewFrameState {
  const LoadingState({required super.images});
}
