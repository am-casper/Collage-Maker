import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:furrl/domain/model/image_model.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';

part 'edit_frame_event.dart';
part 'edit_frame_state.dart';

class EditFrameBloc extends Bloc<EditFrameEvent, EditFrameState> {
  EditFrameBloc() : super(EditFrameState.initial()) {
    on<Initialize>(_onInitialize);
    on<AddImagesEvent>(_onAddImages);
    on<SaveCollageEvent>(_onSaveCollage);
    on<UpdateImagePositionEvent>(_onUpdateImagePosition);
    on<UpdateImageScaleEvent>(_onUpdateImageScale);
    on<UpdateImageIndexEvent>(_onUpdateImageIndex);
  }

  FutureOr<void> _onAddImages(
      AddImagesEvent event, Emitter<EditFrameState> emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;
    List<ImageModel> selectedImages = [];
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(ImageModel(
          url: xfilePick[i].path,
          positionX: 0,
          positionY: 100,
          scale: 1,
        ));
      }
      for (var i = 0; i < selectedImages.length; i++) {
        File? img = File(selectedImages[i].url);
        img = await _cropImage(img);
        selectedImages[i] = ImageModel(
          url: img!.path,
          positionX: selectedImages[i].positionX,
          positionY: selectedImages[i].positionY,
          scale: selectedImages[i].scale,
        );
      }
      emit(EditFrameState(images: selectedImages, isImageSelected: true));
    } else {
      emit(const EditFrameState(images: [], isImageSelected: false));
    }
  }

  FutureOr<void> _onSaveCollage(
      SaveCollageEvent event, Emitter<EditFrameState> emit) async {
    if (state.images.isEmpty) {
      emit(const EditFrameState(images: [], isImageSelected: false));
      return;
    }
    try {
      Box<List<ImageModel>> imagesBox = Hive.box<List<ImageModel>>('images');
      Permission permission;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        permission = androidInfo.version.sdkInt <= 32
            ? Permission.storage
            : Permission.photos;
      } else {
        permission = Permission.photos;
      }
      bool isStoragePermissionGranted = await permission.status.isGranted;
      if (!isStoragePermissionGranted) {
        isStoragePermissionGranted = await permission.request().isGranted;
      }
      if (isStoragePermissionGranted) {
        event.controller.captureAndSave("storage/emulated/0/DCIM/Furrl",
            fileName: "collage1.png");
      }
      imagesBox.put('images', state.images);
      emit(SaveCollageSuccess(
          isUploadSuccess: true,
          images: state.images,
          isImageSelected: state.isImageSelected));
    } catch (e) {
      debugPrint(e.toString());
      emit(SaveCollageSuccess(
          isUploadSuccess: false,
          images: state.images,
          isImageSelected: state.isImageSelected));
    }
  }

  FutureOr<void> _onUpdateImagePosition(
      UpdateImagePositionEvent event, Emitter<EditFrameState> emit) {
    List<ImageModel> updatedImages = state.images;
    ImageModel selectedImage = ImageModel(
        url: updatedImages[event.index].url,
        positionX: event.positionX,
        positionY: event.positionY,
        scale: updatedImages[event.index].scale);
    updatedImages[event.index] = selectedImage;
    emit(EditFrameState(images: updatedImages, isImageSelected: true));
  }

  FutureOr<void> _onUpdateImageScale(
      UpdateImageScaleEvent event, Emitter<EditFrameState> emit) {
    ImageModel selectedImage = state.images[event.index];
    selectedImage = ImageModel(
      url: selectedImage.url,
      positionX: selectedImage.positionX,
      positionY: selectedImage.positionY,
      scale: event.scale,
    );
    List<ImageModel> updatedImages = state.images;
    updatedImages[event.index] = selectedImage;
    emit(EditFrameState(images: updatedImages, isImageSelected: true));
  }

  FutureOr<void> _onInitialize(Initialize event, Emitter<EditFrameState> emit) {
    if (File("storage/emulated/0/DCIM/Furrl/collage1.png").existsSync()) {
      Box<List<ImageModel>> imagesBox = Hive.box<List<ImageModel>>('images');
      emit(EditFrameState(
          images: imagesBox.get('images') ?? [], isImageSelected: true));
    } else {
      emit(const EditFrameState(images: [], isImageSelected: false));
    }
  }

  FutureOr<void> _onUpdateImageIndex(
      UpdateImageIndexEvent event, Emitter<EditFrameState> emit) {
    List<ImageModel> updatedImages = state.images;
    ImageModel selectedImage = ImageModel(
        url: updatedImages[event.index].url,
        positionX: updatedImages[event.index].positionX,
        positionY: updatedImages[event.index].positionY,
        scale: updatedImages[event.index].scale);

    for (var i = 0; i < updatedImages.length - event.index - 1; i++) {
      int a = i + event.index;
      updatedImages[a] = ImageModel(
          url: updatedImages[a + 1].url,
          positionX: updatedImages[a + 1].positionX,
          positionY: updatedImages[a + 1].positionY,
          scale: updatedImages[a + 1].scale);
    }
    updatedImages[updatedImages.length - 1] = selectedImage;
    emit(EditFrameState(images: updatedImages, isImageSelected: true));
  }

  Future<File?> _cropImage(File img) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: img.path,
    );
    return File(croppedImage!.path);
  }
}
