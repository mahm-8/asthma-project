import 'package:asthma/helper/imports.dart';

class TapWidget extends StatelessWidget {
  const TapWidget({super.key, required this.bloc});
  final UserBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: context.getWidth(divide: 20),
      top: context.getHeight(divide: 8),
      child: Container(
        padding: const EdgeInsets.only(top: 60),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorPaltte().conlightBlue),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Text(
              bloc.user!.name!,
              style: const TextStyle().bold24,
            ),
            Text(bloc.user!.id!.toString()),
            const Divider(),
            TabBar(
                indicatorColor: ColorPaltte().darkBlue,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  Tab(
                    child: Text(
                      AppLocalizations.of(context)!.personal,
                      style: TextStyle(color: ColorPaltte().darkBlue),
                    ),
                  ),
                  Tab(
                    child: Text(
                      AppLocalizations.of(context)!.qrCode,
                      style: TextStyle(color: ColorPaltte().darkBlue),
                    ),
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
