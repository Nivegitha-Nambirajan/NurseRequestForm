import 'package:flutter_dotenv/flutter_dotenv.dart';

const String env = String.fromEnvironment(
  'env',
  defaultValue: 'dev',
);

final variablesDev = {
  'baseUrl': dotenv.env['DEV_BASE_URL'],
};

final variablesProd = {
  'baseUrl': dotenv.env['PROD_BASE_URL'],
};

Map<String, dynamic> get environment {
  if (env == 'dev') {
    return variablesDev;
  }
  if (env == 'prod') {
    return variablesProd;
  }
  throw UnimplementedError('baseUrl: $env is unknown value');
}
