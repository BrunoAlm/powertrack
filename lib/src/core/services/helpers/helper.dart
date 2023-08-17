import 'package:flutter/material.dart';

class Helper {
  static String formatDouble(double value) {
    String stringValue = value.toStringAsFixed(2);
    return stringValue.replaceAll('.', ',');
  }

  /// Gera um ID com base no horário
  static String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  /// Formata o tempo de uso do equipamento
  static String formatHour(DateTime time) {
    String totalTime = '';
    String minute = time.minute.toString();
    int hour = time.hour;
    if (minute.length == 1) {
      minute = '0$minute';
    }
    totalTime = '$hour:${minute}h';

    if (time.minute == 0) {
      totalTime = '${hour}h';
    }
    if (hour == 0) {
      totalTime = '${minute}min';
    }
    return totalTime;
  }

  static ScaffoldFeatureController notImplementedSnackbar(
          BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(text),
        ),
      );

  /// Mostra um dialog com os erros do appwrite filtrados
  static appwriteErrorDialog(
          {required String message,
          required int code,
          required BuildContext context}) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Mensagem: $message'), Text('Código: $code')],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
          ],
        ),
      );
}

class ThemeHelper {
  static List<BoxShadow> lightShadow = [
    const BoxShadow(
      color: Color.fromARGB(80, 0, 0, 0),
      blurRadius: 9,
      offset: Offset(0, 0),
      spreadRadius: 0,
    )
  ];
  static List<BoxShadow> darkShadow = [
    const BoxShadow(
      color: Color.fromARGB(24, 0, 0, 0),
      blurRadius: 6,
      offset: Offset(0, 1),
      spreadRadius: 0,
    )
  ];

  static List<BoxShadow> shadow(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ThemeHelper.lightShadow
          : ThemeHelper.darkShadow;
}
