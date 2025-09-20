import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../features/expense/data/models/expense_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        amount REAL NOT NULL,
        originalAmount REAL NOT NULL,
        currency TEXT NOT NULL,
        date TEXT NOT NULL,
        receiptPath TEXT,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<void> init() async {
    await database;
  }

  Future<int> insertExpense(ExpenseModel expense) async {
    final db = await instance.database;
    return await db.insert('expenses', expense.toJson());
  }

  Future<List<ExpenseModel>> getExpenses({
    int limit = 10,
    int offset = 0,
    String? filter,
  }) async {
    final db = await instance.database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (filter != null) {
      final now = DateTime.now();
      DateTime startDate;

      switch (filter) {
        case 'This Month':
          startDate = DateTime(now.year, now.month, 1);
          break;
        case 'Last 7 Days':
          startDate = now.subtract(const Duration(days: 7));
          break;
        default:
          startDate = DateTime(2020, 1, 1);
      }

      whereClause = 'WHERE date >= ?';
      whereArgs.add(startDate.toIso8601String());
    }

    final result = await db.rawQuery(
      '''
      SELECT * FROM expenses 
      $whereClause
      ORDER BY date DESC 
      LIMIT ? OFFSET ?
    ''',
      [...whereArgs, limit, offset],
    );

    return result.map((json) => ExpenseModel.fromJson(json)).toList();
  }

  Future<Map<String, double>> getSummary({String? filter}) async {
    final db = await instance.database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (filter != null) {
      final now = DateTime.now();
      DateTime startDate;

      switch (filter) {
        case 'This Month':
          startDate = DateTime(now.year, now.month, 1);
          break;
        case 'Last 7 Days':
          startDate = now.subtract(const Duration(days: 7));
          break;
        default:
          startDate = DateTime(2020, 1, 1);
      }

      whereClause = 'WHERE date >= ?';
      whereArgs.add(startDate.toIso8601String());
    }

    final result = await db.rawQuery('''
      SELECT SUM(amount) as totalExpenses FROM expenses $whereClause
    ''', whereArgs);

    final totalExpenses = result.first['totalExpenses'] as double? ?? 0.0;

    return {
      'totalIncome': 10840.00,
      'totalExpenses': totalExpenses,
      'totalBalance': 10840.00 - totalExpenses,
    };
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
