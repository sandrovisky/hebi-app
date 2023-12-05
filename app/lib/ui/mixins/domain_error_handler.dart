import 'package:flutter/material.dart';

import './/domain/helpers/helpers.dart';
import './/ui/pages/pages.dart';

mixin DomainErrorHandler {
  Future<void> dialogDomainErrorHandler(
    BuildContext context,
    DomainError error,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => ErrorDialog(
        error: error,
        context: context,
      ).build(),
    );
  }
}
