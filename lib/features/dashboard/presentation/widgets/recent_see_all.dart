import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../utils/export_utils.dart';
import '../../../../utils/index.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/state/dashboard_state.dart';

class RecentSeeAll extends StatelessWidget {
  const RecentSeeAll({super.key, required this.expenses});

  final List expenses;

  @override
  Widget build(BuildContext context) {
    void exportData(String format) async {
      final state = context.read<DashboardBloc>().state;
      if (state is DashboardLoaded && state.expenses.isNotEmpty) {
        try {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );

          final file = format == 'CSV'
              ? await ExportUtils.exportToCSV(state.expenses)
              : await ExportUtils.exportToPDF(state.expenses);

          Navigator.pop(context);
          await ExportUtils.shareFile(
            file,
            'Expense Report ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
          );

          showToast(msg: ('$format export completed!'));
        } catch (e) {
          Navigator.pop(context);
          showToast(msg: ('Export failed: $e'));
        }
      }
    }

    void showExportDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Export Expenses In'),
          actions: [
            CustomButton(
              widthH: width(context) * 0.3,
              text: 'CSV',
              onTap: () {
                Navigator.pop(context);
                exportData('CSV');
              },
            ),

            CustomButton(
              widthH: width(context) * 0.3,
              text: 'PDF',
              onTap: () {
                Navigator.pop(context);
                exportData('PDF');
              },
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomText(
            title: 'Recent Expenses',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          TextButton(
            onPressed: expenses.isNotEmpty ? () => showExportDialog() : null,
            child: const CustomText(title: 'see all'),
          ),
        ],
      ),
    );
  }
}
