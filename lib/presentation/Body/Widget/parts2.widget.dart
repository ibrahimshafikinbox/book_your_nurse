import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_app/presentation/Body/Widget/show_dialog.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../../generated/l10n.dart';
import '../Body_cubit/body_cubit.dart';
import '../list_of_symptoms.dart';

class ManWidget extends StatelessWidget {
  const ManWidget({super.key});

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
              width: 250,
              height: 545,
              color: Colors.white,
              child: Stack(
                children: [
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/body.png",
                    width: 230,
                    height: 536,
                    left: 6.33,
                    top: 12.6,
                  ),
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/shadow.png",
                    width: 150,
                    height: 300,
                    left: 53,
                    top: 186.4,
                  ),
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/leftface.png",
                    width: 100,
                    height: 100,
                    left: 55,
                    top: 45,
                  ),
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/shadowleftface.png",
                    width: 100,
                    height: 100,
                    left: 60,
                    top: 45,
                  ),
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/skull.png",
                    width: 100,
                    height: 100,
                    left: 78,
                    top: 45,
                  ),
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/rightface.png",
                    width: 100,
                    height: 100,
                    right: 50,
                    top: 45,
                  ),
                  _buildpngAsset(
                      imagePath: "Image/partspngfigma/eyes.png",
                      width: 56,
                      height: 18,
                      left: 103,
                      top: 85,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/eye.png",
                              text: S.of(context).Doyouwanttochooseeyes,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: "EYE",
                                      titleappBar: S.of(context).EYE,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }),
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/lungs1.png",
                    width: 130,
                    height: 205,
                    right: 55.87,
                    top: 145.45,
                  ),
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/Chestbones.png",
                    width: 166,
                    height: 190,
                    right: 40.87,
                    top: 180.45,
                  ),
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/heartbig.png",
                    width: 60,
                    height: 69,
                    left: 118.45,
                    top: 257.76,
                  ),
                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/Breast.png",
                    width: 100,
                    height: 200,
                    right: 35.87,
                    top: 160,
                  ),
                  _buildpngAsset(
                      imagePath: "Image/partspngfigma/Arteriesandbloodveins.png",
                      right: 25,
                      width: 200,
                      top: 110,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/Arteriesandbloodveins.png",
                              text: S
                                  .of(context)
                                  .DoyouwanttochoosArteriesandbloodveins,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: 'Arteriesandveins',
                                      titleappBar:
                                          S.of(context).Arteriesandbloodveins,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }),

                  _buildpngAsset(
                    imagePath: "Image/partspngfigma/Thighbone.png",
                    left: 50,
                    width: 155,
                    top: 375,
                  ),
                  _buildpngAsset(
                      imagePath: "Image/partspngfigma/kidney.png",
                      left: 92,
                      top: 355,
                      width: 70,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/kidneySingle.png",
                              text: S.of(context).DoyouwanttochooseKidney,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: 'Kidney',
                                      titleappBar: S.of(context).Kidney,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }),
                  _buildpngAsset(
                      imagePath: "Image/partspngfigma/Malereproductivesystem11.png",
                      left: 98,
                      top: 440,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowDialog(
                              path: "Image/partspngfigma/Malereproductivesystem11.png",
                              text:
                              S.of(context).DoyouwanttochooseMalereproductivesystem,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Listsymptoms(
                                      name: 'Malereproductivesystem',
                                      titleappBar: S.of(context).Malereproductivesystem,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Positioned _buildpngAsset({
    required String imagePath,
    double? width,
    double? height,
    double? left,
    double? right,
    required double top,
    void Function()? onTap,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          imagePath,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
