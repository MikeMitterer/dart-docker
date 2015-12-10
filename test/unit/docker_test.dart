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

library docker.unit.test;

import 'package:test/test.dart';
import 'package:docker/mock.dart';
import 'package:docker/docker.dart';

main() {
  initTestContainer();

  group('A group of tests', () {

    final Docker mockedDocker = new DockerMock();

    setUp(() { });

    test('> Names', () {
        final Container containerAll = new Container.withDocker(allContainerIDs(docker: mockedDocker),mockedDocker);
        expect(containerAll.names.length,23);

        final Container containerActive = new Container.withDocker(runningContainerIDs(docker: mockedDocker),mockedDocker);
        expect(containerActive.names.length,2);

    }); // end of 'Names' test

    test('> Stop', () {
        expect(mockedDocker.stop([ "b594630d731a"] ), "b594630d731a");
        expect(mockedDocker.stop([ "name_b594630d731a"] ), "name_b594630d731a");
        expect(mockedDocker.stop([ "does_not_exist"] ), "does_not_exist");
    }); // end of 'Start' test

    test('> Start', () {
        expect(mockedDocker.start([ "b594630d731a"] ), "b594630d731a");
        expect(mockedDocker.start([ "name_b594630d731a"] ), "name_b594630d731a");
        expect(() => mockedDocker.start([ "does_not_exist"] ), throwsArgumentError);
    }); // end of 'Start' test

  });
}
