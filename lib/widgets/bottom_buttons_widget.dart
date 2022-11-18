import 'package:flutter/material.dart';
import 'package:learn_numbers/widgets/button_help_widget.dart';
import 'package:learn_numbers/widgets/button_play_widget.dart';
import 'package:learn_numbers/widgets/switcher_sound_widget.dart';

class BottomButtonWidget extends StatelessWidget {
  const BottomButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          children: const [
            // ButtonPlayWidget(),
            SwitchSoundWidget(),
            ButtonHelpWidget(),
          ],
        ),
      ),
    );
  }
}
