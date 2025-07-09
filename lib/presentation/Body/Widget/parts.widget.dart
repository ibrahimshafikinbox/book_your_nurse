import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/presentation/Body/Widget/show_dialog.dart';
import 'package:medical_app/presentation/Body/list_of_symptoms.dart';
import 'package:zoom_widget/zoom_widget.dart';
import '../../../generated/l10n.dart';
import '../Body_cubit/body_cubit.dart';
class PartsWidget extends StatelessWidget {
  const PartsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BodyCubit, BodyState>(
      builder: (context, state) {
        return Zoom(
          backgroundColor: Colors.white,
          scrollWeight: 5,
          opacityScrollBars: 1,
          colorScrollBars: Colors.white,
          doubleTapZoom: false,
          initTotalZoomOut: true,
          child: Center(
            child: Container(
              width: 196,
              height: 537.22,
              color: Colors.white,
              child: Stack(
                children: [
                  Image.asset("Image/partspngfigma/Vectorbody.png"),
                  Positioned(
                    top: 1,
                    left: 2,
                    child: Image.asset("Image/partspngfigma/skeleton.png"),
                  ),
                  Positioned(
                    left: 78.04,
                    top: 4.20,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/Brain.png",
                              text: S.of(context).DoyouwanttochoosetheBrain,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "Brain",
                                      titleappBar: S.of(context).Brain,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("Image/partspngfigma/Brain.png"),
                    ),
                  ),
                  Positioned(
                    left: 92.16,
                    top: 57.91,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/throut.png",
                              text: S.of(context).DoyouwanttochooseLarynx,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "Larynx",
                                      titleappBar: S.of(context).Larynx,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("Image/partspngfigma/throut.png"),
                    ),
                  ),
                  Positioned(
                    left: 86.24,
                    top: 34.43,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/nose.png",
                              text: S.of(context).DoyouwanttochoosetheNose,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "Nose",
                                      titleappBar: S.of(context).Nose,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("Image/partspngfigma/nose.png"),
                    ),
                  ),
                  Positioned(
                    left: 59.21,
                    top: 70.8,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/Group 658.png",
                              text: S.of(context).DoyouwanttochoosetheLungs,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "Lungs",
                                      titleappBar: S.of(context).Lungs,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("Image/partspngfigma/Group 658.png"),
                    ),
                  ),
                  Positioned(
                    left: 86.66,
                    top: 137.44,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/heart.png",
                              text: S.of(context).DoyouwanttochoosetheHeart,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "Heart",
                                      titleappBar: S.of(context).Heart,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("Image/partspngfigma/heart.png"),
                    ),
                  ),
                  Positioned(
                    left: 60.67,
                    top: 170.43,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/Liver.png",
                              text: S.of(context).DoyouwanttochoosetheLiver,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "Liver",
                                      titleappBar: S.of(context).Liver,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("Image/partspngfigma/Liver.png"),
                    ),
                  ),
                  Positioned(
                    left: 118.18,
                    top: 176.16,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/Group166.png", // Corrected path
                              text: S.of(context).DoyouwanttochoosetheSpleen,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "Spleen",
                                      titleappBar: S.of(context).Spleen,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("Image/partspngfigma/Group166.png"), // Corrected path
                    ),
                  ),
                  Positioned(
                    left: 77,
                    top: 162.13,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/stmoach.png",
                              text: S.of(context).DoyouwanttochoosetheStomach,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "Stomach",
                                      titleappBar: S.of(context).Stomach,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("Image/partspngfigma/stmoach.png"),
                    ),
                  ),
                  Positioned(
                    left: 61.36,
                    top: 197.23,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/Group 167.png",
                              text: S.of(context).DoyouwanttochoosetheLargeandsmallintestine,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "Smallandlargeintestine",
                                      titleappBar: S.of(context).Smallandlargeintestine,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("Image/partspngfigma/Group 167.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
