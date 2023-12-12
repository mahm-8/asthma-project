
import 'package:asthma/helper/imports.dart';

class ContainerImage extends StatelessWidget {
  const ContainerImage({super.key, required this.bloc});
  final UserBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: context.getWidth(divide: 2.7),
      top: context.getHeight(divide: 17),
      child: ClipOval(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is ErrorUploadState) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(state.msg),
                    );
                  });
            }
            if (state is UploadImageState) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is UploadImageState) {
              return Container(
                  color: ColorPaltte().newBlue,
                  height: 100,
                  width: 100,
                  child: Image.network(
                    state.url,
                    fit: BoxFit.cover,
                  ));
            }
            return Container(
              color: ColorPaltte().newBlue,
              height: 100,
              width: 100,
              child: bloc.user!.image != null
                  ? Image.network(
                      bloc.user!.image!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person_outline),
            );
          },
        ),
      ),
    );
  }
}
