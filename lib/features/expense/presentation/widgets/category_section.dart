import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/index.dart';
import '../../data/models/category_model.dart';
import '../bloc/event/expense_event.dart';
import '../bloc/expense_bloc.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key, required this.selectedCategory});
  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(title: 'Categories', fontSize: 16),
        const Height(12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<dynamic>(
            value: selectedCategory,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (value) {
              if (value != null) {
                context.read<ExpenseBloc>().add(UpdateCategory(value));
              }
            },
            items: categoriesList
                .map(
                  (category) => DropdownMenuItem<String>(
                    value: category.name,
                    child: Row(
                      children: [
                        Icon(category.icons, color: category.color, size: 20),
                        const Width(8),
                        CustomText(title: category.name),
                      ],
                    ),
                  ),
                )
                .toList(),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 40),
          ),
        ),
      ],
    );
  }
}
