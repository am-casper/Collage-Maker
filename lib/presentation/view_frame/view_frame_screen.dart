import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furrl/presentation/edit_frame/edit_frame_screen.dart';
import 'package:furrl/presentation/view_frame/bloc/view_frame_bloc.dart';
import 'package:furrl/utils/furrl_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewFrameScreen extends StatelessWidget {
  const ViewFrameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewFrameBloc()..add(ViewFrameEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F5F7),
        appBar: furrlAppBar("View Frame", context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Image.asset("assets/icons/pfp.png"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Jenny Wilson",
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                          "Lorem Ipsum is simply dummy text of printing and typesetting industry lorem ipsum news.",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      Text("#Organic  |  #ClassyAffair  |  #Multicolor  |",
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF7E59E7)),
                          textAlign: TextAlign.center),
                      Text("#Oversized  |  #Miminalism",
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF7E59E7)),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Frames",
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocConsumer<ViewFrameBloc, ViewFrameState>(
                        builder: (context, state) {
                          return state.images.isNotEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.68,
                                  child: Stack(children: [
                                    ...List.generate(state.images.length,
                                        (index) {
                                      var img = state.images[index];
                                      return Positioned(
                                        top: img.positionY,
                                        left: img.positionX,
                                        child: Transform.scale(
                                          scale: img.scale,
                                          child: Image.file(
                                            File(img.url),
                                          ),
                                        ),
                                      );
                                    }),
                                  ]),
                                )
                              : const Text("No Frame Created");
                        },
                        listener:
                            (BuildContext context, ViewFrameState state) {},
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditFrameScreen()));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF7E59E7),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: BlocBuilder<ViewFrameBloc, ViewFrameState>(
                            builder: (context, state) {
                              return Text(
                                state.images.isNotEmpty
                                    ? "Edit Frame"
                                    : "Create Frame",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF7E59E7)),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
