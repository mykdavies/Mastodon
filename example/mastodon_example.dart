// Copyright (c) 2017, mike. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:mastodon/mastodon.dart';

main() {
  final Mastodon m = new Mastodon();
  print(m.getInstance());
}
