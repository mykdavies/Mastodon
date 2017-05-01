# Mastodon

A simple API for accessing Mastodon instances.

## Usage

A simple usage example:

    import 'package:mastodon/mastodon.dart';

    main() {
      // Using mastodon.cloud instance by default.
      var m = new Mastodon.usingAccessToken('an OAuth access token for this instance');
      for (Account a in m.findAccounts('myk*')) {
        print(a);
      }
    }

## Features and bugs

Incomplete and not well tested, so it is full of them.

Fix them at https://github.com/mykdavies/Mastodon!