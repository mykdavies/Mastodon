# Mastodon

A simple API for accessing Mastodon instances.

## Usage

A simple usage example:

    import 'package:Mastodon/Mastodon.dart';

    main() {
      var m = new Mastodon.usingAccessToken(properties['access_token']);
      for (Account a in m.findAccounts('myk*')) {
        print(a);
      }
    }

## Features and bugs

Please let me know about bugs at mykdavies@gmail.com, or fix them at github!