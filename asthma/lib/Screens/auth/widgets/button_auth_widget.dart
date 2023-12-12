import 'package:asthma/helper/imports.dart';

class ButtonAuthWidget extends StatelessWidget {
  const ButtonAuthWidget({
    super.key,
    this.onPressed,
    required this.text,
  });
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: ColorPaltte().newDarkBlue,
          minimumSize: Size(
              context.getWidth() > 600
                  ? context.getWidth(divide: 3)
                  : context.getWidth(divide: 1.2),
              50)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
