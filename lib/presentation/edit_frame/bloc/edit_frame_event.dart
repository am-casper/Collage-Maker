part of 'edit_frame_bloc.dart';

abstract class EditFrameEvent extends Equatable {}

class Initialize extends EditFrameEvent{

  @override
  List<Object?> get props => [];
}

class AddImagesEvent extends EditFrameEvent {

  AddImagesEvent();
  @override
  List<Object?> get props => [];
}

class SaveCollageEvent extends EditFrameEvent {
  final ScreenshotController controller;

  SaveCollageEvent({required this.controller});
  @override
  List<Object?> get props => [controller];
}

class UpdateImagePositionEvent extends EditFrameEvent {
  final int index;
  final double positionX;
  final double positionY;

  UpdateImagePositionEvent(
      {required this.index, required this.positionX, required this.positionY});
  @override
  List<Object?> get props => [index, positionX, positionY];
}

class UpdateImageScaleEvent extends EditFrameEvent {
  final int index;
  final double scale;

  UpdateImageScaleEvent({required this.index, required this.scale});
  @override
  List<Object?> get props => [index, scale];
}

class UpdateImageIndexEvent extends EditFrameEvent {
  final int index;

  UpdateImageIndexEvent({required this.index});
  @override
  List<Object?> get props => [index];
}