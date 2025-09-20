import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/index.dart';
import '../../../currency/presentation/bloc/currency_bloc.dart';
import '../../../currency/presentation/bloc/state/currency_state.dart';
import 'custom_head_title.dart';

class AmountSection extends StatelessWidget {
  const AmountSection({super.key, this.controller, this.onChanged, this.value});
  final TextEditingController? controller;
  final void Function(dynamic)? onChanged;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeadTitle(title: 'Amount'),
        const Height(12),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomFieldInput(
                controller: controller,
                keyboardType: TextInputType.number,
                hintText: '\$50,000',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(
                        value.replaceAll('\ ', '').replaceAll(',', ''),
                      ) ==
                      null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
            ),
            const Width(12),
            Expanded(
              child: BlocBuilder<CurrencyBloc, CurrencyState>(
                builder: (context, state) {
                  if (state is CurrencyLoaded) {
                    return CustomDropdownInput(
                      value: value,
                      onChanged: onChanged,
                      items: state.currencies
                          .map(
                            (currency) => DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency),
                            ),
                          )
                          .toList(),
                      hintText: "USD",
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const CustomText(title: 'USD'),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
