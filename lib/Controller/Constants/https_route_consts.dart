// ignore_for_file: constant_identifier_names

class Constants {
  static const String BASE_URL = 'http://192.168.43.170:8000/api/';
  static const String OWNERS_LOGIN_URL = 'owners/login';
  static const String OWNERS_REGISTER_URL = 'owners/register';
  static const String EMPLOYEES_LOGIN_URL = 'employees/login';
  static const String EMPLOYEES_REGISTER_URL = 'employees/register';
  static const String GET_EMPLOYEES_BY_OWNERUSERNAME =
      'employees/getEmployeesByOwnerUsername';

  static const String GET_INCOME_BY_EMPLOYEES = 'incomes/getByEmployee';
  static const String GET_INCOME_BY_DATE = 'incomes/getByEmployeeAndDate';
  static const String GET_INCOME_BY_GAME = 'incomes/getByEmployeeAndGame';
  static const String GET_INCOME_BY_DATE_AND_GAME =
      'incomes/getByEmployeeAndDateAndGame';
  static const String GET_INCOME_BY_DATE_RANGE =
      'incomes/getByEmployeeAndDateRange';
  static const String GET_INCOME_BY_GAME_AND_DATE_RANGE =
      'incomes/getByEmployeeAndGameAndDateRange';

  static const String GET_INCOME_BY_WEEKLY_DATE =
      'incomes/getByEmployeeAndWeeklyDate';

  static const String ADD_INCOME = 'incomes';
  static const String isLightTheme = 'isLightTheme';
}
