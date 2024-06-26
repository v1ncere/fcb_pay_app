import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';

class UserImage extends StatelessWidget {
  const UserImage({required this.picker, super.key});
  final ImagePicker picker;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload an image of yourself holding your PITAKArd'),
        const SizedBox(height: 5),
        BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            if(state.userImageStatus.isInitial) {
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                    color: ColorString.emerald,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Icon(FontAwesomeIcons.cameraRetro, color: ColorString.white)
                  ),
                ),
                onTap: () => _settingModalBottomSheet(context),
              );
            }
            if (state.userImageStatus.isLoading) {
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                    color: ColorString.emerald,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: SpinKitChasingDots(
                      color: Colors.white,
                      size: 18,
                    )
                  )
                ),
                onTap: () => _settingModalBottomSheet(context)
              );
            }
            if (state.userImageStatus.isSuccess) {
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                    color: ColorString.emerald,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: FileImage(File(state.userImage!.path))
                    )
                  )
                ),
                onTap: () => _settingModalBottomSheet(context),
              );
            }
            if (state.userImageStatus.isError) {
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                    color: ColorString.guardsmanRed,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.triangleExclamation,
                          size: 18,
                          color: ColorString.white,
                        ),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorString.white,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ]
                    )
                  )
                ),
                onTap: () => _settingModalBottomSheet(context)
              );
            }
            return const SizedBox.shrink();
          }
        )
      ]
    );
  }

  Future<void> _settingModalBottomSheet(BuildContext context) async {
    context.read<SignUpBloc>().add(const HydrateStateChanged(isHydrated: true));
    showModalBottomSheet(
      backgroundColor: ColorString.eucalyptus,
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              title: Text(
                'Gallery', 
                style: TextStyle(
                  color: ColorString.white,
                  fontWeight: FontWeight.bold
                )
              ),
              onTap: () => _imageSelector(context, ImageSource.gallery)
            ),
            ListTile(
              title: Text(
                'Camera', 
                style: TextStyle(
                  color: ColorString.white,
                  fontWeight: FontWeight.bold
                )
              ),
              onTap: () => _imageSelector(context, ImageSource.camera)
            )
          ]
        );
      }
    );
  }

  Future<void> _imageSelector(BuildContext context, ImageSource source) async {
    await picker.pickImage(source: source).then((image) {
      if(image != null) {
        context.read<SignUpBloc>().add(UserImageChanged(image));
      }
      Navigator.of(context).pop();
    });
  }
}