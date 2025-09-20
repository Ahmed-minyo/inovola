import '../utils/index.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String? title;
  final bool backButton;

  @override
  final Size preferredSize;

  const CustomAppBar({
    super.key,
    this.actions,
    this.title,
    this.backButton = true,
  }) : preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: actions,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: backButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
              onPressed: () => Navigator.pop(context),
            )
          : SizedBox(),
      title: CustomText(
        title: title ?? "",
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
    );
  }
}
