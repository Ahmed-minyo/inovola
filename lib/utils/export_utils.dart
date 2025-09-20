import 'dart:io';
import 'package:csv/csv.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../../features/expense/data/models/expense_model.dart';

class ExportUtils {
  static const _csvConverter = ListToCsvConverter();

  static Future<File> exportToCSV(List<ExpenseModel> expenses) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
      '${directory.path}/expenses_${DateTime.now().millisecondsSinceEpoch}.csv',
    );

    final headers = [
      'Date',
      'Category',
      'Amount (USD)',
      'Original Amount',
      'Currency',
      'Receipt',
    ];
    final rows = expenses
        .map(
          (expense) => [
            DateFormat('yyyy-MM-dd').format(expense.date),
            expense.category,
            expense.amount.toStringAsFixed(2),
            expense.originalAmount.toStringAsFixed(2),
            expense.currency,
            expense.receiptPath ?? 'No receipt',
          ],
        )
        .toList();

    final csvData = _csvConverter.convert([headers, ...rows]);
    await file.writeAsString(csvData);
    return file;
  }

  static Future<File> exportToPDF(List<ExpenseModel> expenses) async {
    final pdf = pw.Document();
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
      '${directory.path}/expenses_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                'Expense Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 20),
              child: pw.Text(
                'Generated on ${DateFormat('MMM dd, yyyy').format(DateTime.now())}',
                style: const pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey700,
                ),
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total Expenses:',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '\${total.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue800,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(1.5),
                3: const pw.FlexColumnWidth(1.5),
                4: const pw.FlexColumnWidth(1),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    _buildPdfCell('Date', isHeader: true),
                    _buildPdfCell('Category', isHeader: true),
                    _buildPdfCell('Amount (USD)', isHeader: true),
                    _buildPdfCell('Original Amount', isHeader: true),
                    _buildPdfCell('Currency', isHeader: true),
                  ],
                ),
                ...expenses.map(
                  (expense) => pw.TableRow(
                    children: [
                      _buildPdfCell(
                        DateFormat('MMM dd, yyyy').format(expense.date),
                      ),
                      _buildPdfCell(expense.category),
                      _buildPdfCell('\${expense.amount.toStringAsFixed(2)}'),
                      _buildPdfCell(expense.originalAmount.toStringAsFixed(2)),
                      _buildPdfCell(expense.currency),
                    ],
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    );

    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildPdfCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 12 : 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  static Future<void> shareFile(File file, String title) async {
    await Share.shareXFiles([XFile(file.path)], subject: title);
  }
}
