import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furrl/presentation/edit_frame/bloc/edit_frame_bloc.dart';
import 'package:furrl/presentation/view_frame/view_frame_screen.dart';
import 'package:furrl/utils/furrl_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';

class EditFrameScreen extends StatelessWidget {
  const EditFrameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    return Scaffold(
      appBar: furrlAppBar("Edit Frame", context),
      backgroundColor: const Color(0xFFF3F5F7),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top,
          child: BlocProvider(
            create: (context) => EditFrameBloc()..add(Initialize()),
            child: BlocConsumer<EditFrameBloc, EditFrameState>(
              listener: (context, state) {
                if (!state.isImageSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No Image Selected"),
                    ),
                  );
                }
                if (state is SaveCollageSuccess) {
                  if (state.isUploadSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Collage Saved"),
                      ),
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const ViewFrameScreen()),
                        (route) => false);
                    // Bloc
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Failed to Save Collage"),
                      ),
                    );
                  }
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 0,
                    ),
                    Screenshot(
                      controller: screenshotController,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.68,
                        color: Colors.white,
                        child: state.images.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // getImages(context);
                                        context
                                            .read<EditFrameBloc>()
                                            .add(AddImagesEvent());
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF7E59E7),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Add Images",
                                            style: GoogleFonts.montserrat(
                                                color: const Color(0xFF7E59E7),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Stack(
                                children: [
                                  ...List.generate(
                                    state.images.length,
                                    (index) {
                                      var img = state.images[index];
                                      return Positioned(
                                        top: img.positionY,
                                        left: img.positionX,
                                        child: LongPressDraggable(
                                          feedback: Transform.scale(
                                            scale: img.scale,
                                            child: Image.file(
                                              File(img.url),
                                            ),
                                          ),
                                          childWhenDragging: Container(),
                                          onDragEnd: (details) {
                                            context.read<EditFrameBloc>().add(
                                                UpdateImagePositionEvent(
                                                    index: index,
                                                    positionX:
                                                        details.offset.dx,
                                                    positionY:
                                                        details.offset.dy -
                                                            2 * kToolbarHeight -
                                                            3 *
                                                                MediaQuery.of(
                                                                        context)
                                                                    .padding
                                                                    .top));
                                          },
                                          child: GestureDetector(
                                            onDoubleTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext ctx) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Delete Image"),
                                                    content: const Text(
                                                        "Are you sure you want to delete this image?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(ctx);
                                                        },
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(ctx);
                                                          context
                                                              .read<
                                                                  EditFrameBloc>()
                                                              .add(DeleteImageEvent(
                                                                  index:
                                                                      index));
                                                        },
                                                        child: const Text(
                                                            "Delete"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            onTap: () {
                                              context.read<EditFrameBloc>().add(
                                                  UpdateImageIndexEvent(
                                                      index: index));
                                            },
                                            onScaleUpdate: (details) {
                                              context.read<EditFrameBloc>().add(
                                                  UpdateImageScaleEvent(
                                                      index: index,
                                                      scale: details.scale *
                                                          img.scale));
                                            },
                                            child: Transform.scale(
                                              scale: img.scale,
                                              child: Image.file(
                                                File(img.url),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                if (state.images.length < 4) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Add atleast 4 images"),
                                    ),
                                  );
                                  return;
                                }
                                context.read<EditFrameBloc>().add(
                                    SaveCollageEvent(
                                        controller: screenshotController));
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF7E59E7),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  "Save",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12.5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF7E59E7),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF7E59E7)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
