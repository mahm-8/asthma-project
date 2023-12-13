import 'package:asthma/helper/imports.dart';

class ContainMessage extends StatelessWidget {
  const ContainMessage({
    super.key,
    required this.isMine,
    required this.message,
  });
  final bool isMine;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerLeft : Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: isMine ? ColorPaltte().newDarkBlue : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isMine
                      ? const Radius.circular(0)
                      : const Radius.circular(20),
                  bottomRight: isMine
                      ? const Radius.circular(20)
                      : const Radius.circular(0),
                )),
            child: Text(
              message.trim(),
              style: TextStyle(color: isMine ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
