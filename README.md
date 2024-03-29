# Mastodon

A simple API for accessing Mastodon instances.

## Usage

A simple usage example:

    import 'package:mastodon/mastodon.dart';

    main() {
      // Create your instance. Doesn't actually log on until you call a method.
      var m = new Mastodon.usingAccessToken(
        'an OAuth access token for this instance', 
        instance: 'mastodon.somewhere',
      );
      for (Account a in m.findAccounts('myk')) {
        print(a);
      }
    }
    
See `mastodon_test.dart` for more clues.

## Features and bugs

This package is intended to help with the building of simple bots.

Reasonably complete, but not well tested, so it is likely full of bugs.

Fix them at https://github.com/mykdavies/Mastodon!

Alternatively, you might want to look at Luke Piaghetti's (currently halted) 
https://pub.dev/packages/mastodon_dart for something richer and more reliable.


## Todo

- Rate limiting mechanism not implemented. 