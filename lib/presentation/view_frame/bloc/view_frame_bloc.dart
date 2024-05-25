import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:furrl/domain/model/image_model.dart';
import 'package:hive/hive.dart';

part 'view_frame_event.dart';
part 'view_frame_state.dart';

class ViewFrameBloc extends Bloc<ViewFrameEvent, ViewFrameState> {
  ViewFrameBloc() : super(const ViewFrameState(images: [])) {
    on<ViewFrameEvent>(_checkFrameSaved);
  }

  FutureOr<void> _checkFrameSaved(
      ViewFrameEvent event, Emitter<ViewFrameState> emit) {
    emit(const LoadingState(images: []));
    if (File("storage/emulated/0/DCIM/Furrl/collage1.png").existsSync()) {
      Box<List<ImageModel>> imagesBox = Hive.box<List<ImageModel>>('images');
      emit(ViewFrameState(images: imagesBox.get('images') ?? const []));
      return null;
    }
    emit(const ViewFrameState(images: []));
  }
}
