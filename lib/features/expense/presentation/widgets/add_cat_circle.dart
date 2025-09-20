import '../../../../utils/index.dart';

class AddCatCircle extends StatelessWidget {
  const AddCatCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[300]!,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.add, color: Colors.grey[600], size: 24)],
          ),
        ),
        const Height(4),
        CustomText(
          title: 'Add Category',
          fontSize: 10,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
