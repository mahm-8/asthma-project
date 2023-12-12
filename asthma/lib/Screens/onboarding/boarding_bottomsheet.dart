

import 'package:asthma/helper/imports.dart';

import 'onboarding_screen.dart';

class BoardingBottomsheet extends StatelessWidget {
  const BoardingBottomsheet({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 260, bottom: 15),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorPaltte().newDarkBlue,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 45,
          width: MediaQuery.of(context).size.width * 0.30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if (pageIndex != 3) {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  } else {
                    if (pageIndex == 3) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const LoadingScreen())),
                          (route) => false);
                    }
                  }
                },
                child: Text(
                  pageIndex != 3 ? "NEXT" : "START",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              )
            ],
          )),
    );
  }
}
