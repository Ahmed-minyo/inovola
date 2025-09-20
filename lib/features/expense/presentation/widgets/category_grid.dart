import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/index.dart';
import '../../data/models/category_model.dart';
import '../bloc/event/expense_event.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/state/expense_state.dart';
import 'add_cat_circle.dart';
import 'custom_head_title.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, required this.state});
  final ExpenseState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeadTitle(title: 'Categories'),
        const Height(12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: categoriesList.length + 1,
          itemBuilder: (context, index) {
            if (index < categoriesList.length) {
              final category = categoriesList[index];
              final isSelected = category.name == state.selectedCategory;

              return GestureDetector(
                onTap: () {
                  context.read<ExpenseBloc>().add(
                    UpdateCategory(category.name),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? category.color.withValues(alpha: 0.2)
                            : Colors.grey[100],
                        border: isSelected
                            ? Border.all(color: category.color, width: 2)
                            : null,
                      ),
                      child: Icon(
                        category.icons,
                        color: isSelected ? category.color : Colors.grey[600],
                        size: 24,
                      ),
                    ),
                    const Height(4),
                    CustomText(
                      title: category.name,
                      fontSize: 10,
                      color: isSelected ? AppColors.blueColor : Colors.black,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return AddCatCircle();
            }
          },
        ),
      ],
    );
  }
}
