/*
 * Copyright (c) 2015, Michael Mitterer (office@mikemitterer.at),
 * IT-Consulting and Development Limited.
 *
 * All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
@TestOn("vm")
library docker.integration.test;

import 'package:test/test.dart';
import 'package:docker/mock.dart';
import 'package:docker/docker.dart';

main() {
  initTestContainer();

  group('A group of tests', () {

    final Docker docker = new Docker();

    setUp(() { });

    test('> Names', () {
        final Container containerAll = new Container.withDocker(allContainerIDs(),docker);
        expect(containerAll.names.length,greaterThan(0));

        final Container containerActive = new Container.withDocker(runningContainerIDs(),docker);
        expect(containerActive.names.length,greaterThanOrEqualTo(0));

    }); // end of 'Names' test

    test('> Version', () {
        expect(docker.version().contains("Version:"), isTrue);
    }); // end of 'Version' test

    test('> Start Hello-World', () {
        final String out = docker.run([ "hello-world" ]);
        expect(out, contains("Hello from Docker!"));

        //docker.start([ "hello-world" ]);
        
    }); // end of 'Start' test

  });
}
