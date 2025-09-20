import '../../../../utils/index.dart';

class CustomHeadTitle extends StatelessWidget {
  const CustomHeadTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(title: title, fontSize: 16);
  }
}
