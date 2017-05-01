# Mastodon

A simple API for accessing Mastodon instances.

## Usage

A simple usage example:

    import 'package:Mastodon/Mastodon.dart';

    main() {
      // Using mastodon.cloud by default.
      var m = new Mastodon.usingAccessToken('an OAuth access token for this instance');
      for (Account a in m.findAccounts('myk*')) {
        print(a);
      }
    }

## Features and bugs

Please let me know about bugs at mykdavies@gmail.com, or fix them at github!