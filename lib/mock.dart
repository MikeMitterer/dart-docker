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
     
library docker.mock;

import 'package:docker/docker.dart';

/// Test-Structure
class _MockContainer {

    final String id;

    /// Generated from given id - something like /name_b594630d731a
    final String name;

    /// Generated from given id - something like test/name_b594630d731a
    final String image;

    final bool active;

    _MockContainer(final String id,final bool active) : this.id = id, this.active = active,
            name = "/name_${id}", image = "test/name_${id}";
}

final List<_MockContainer> _testContainer = new List<_MockContainer>();

/// Mocks the [Docker]-Class
class DockerMock extends Docker {

    const DockerMock();

    String call(List<String> arguments, { DockerRunOptions runOptions, bool quiet: false }) {
        switch(arguments.first) {
            case "ps":
                final List<String> ids = new List<String>();
                if(arguments.length >= 2 && arguments[1] == "-q") {
                    _testContainer.where((final _MockContainer container) => container.active)
                        .forEach((final _MockContainer container) {
                        ids.add(container.id);
                    });
                    return ids.join("\n");
                }
                if(arguments.length >= 3 && arguments[1] == "-a" && arguments[2] == "-q") {
                    _testContainer.forEach((final _MockContainer container) {
                        ids.add(container.id);
                    });
                    return ids.join("\n");
                }
                break;

            case "inspect":
                if(arguments.length >= 3 && arguments[1] == "--format='{{.Name}}'") {
                    final String id = arguments[2];
                    return _testContainer.firstWhere((final _MockContainer container) => container.id == id)
                        .name;
                }
                break;

            case "stop":
                if(arguments.length >= 2) {
                    return arguments[1];
                }
                break;

            case "start":
            case "run":
                if(arguments.length >= 2) {
                    final String arg = arguments[1];
                    final _MockContainer container = _testContainer.firstWhere((final _MockContainer container) => container.id == arg,
                        orElse: () {
                            return _testContainer.firstWhere((final _MockContainer container) => container.name == "/${arg}",
                                orElse: () {
                                    throw new ArgumentError("Error response from daemon: no such id: $arg");
                                });
                        });
                    return container.id == arg ? arg : container.name.replaceFirst("/","");
                }
                break;
        }
        throw new ArgumentError("DockerMock.call(${arguments.join(",")}) ist not supported!");
    }

    //- private -----------------------------------------------------------------------------------

}

void initTestContainer() {
    if(_testContainer.length > 0) {
        return;
    }
    _testContainer.add(new _MockContainer("b594630d731a",false));
    _testContainer.add(new _MockContainer("0582daf5b733",false));
    _testContainer.add(new _MockContainer("0d1fb21c575d",false));
    _testContainer.add(new _MockContainer("12fb6bc83d50",false));
    _testContainer.add(new _MockContainer("502017b7bfd0",false));
    _testContainer.add(new _MockContainer("9a76c1d7f0d8",false));
    _testContainer.add(new _MockContainer("35d66e3f6d4d",false));
    _testContainer.add(new _MockContainer("7328de073b81",false));
    _testContainer.add(new _MockContainer("4cae1c73037f",false));
    _testContainer.add(new _MockContainer("4b38cdbe61b5",false));
    _testContainer.add(new _MockContainer("0b2fd57032b5",false));
    _testContainer.add(new _MockContainer("b134c47e9680",false));
    _testContainer.add(new _MockContainer("be7eea4783fc",false));
    _testContainer.add(new _MockContainer("8dc00b617229",false));
    _testContainer.add(new _MockContainer("067776f490ae",false));
    _testContainer.add(new _MockContainer("c8cb8abeab4f",false));
    _testContainer.add(new _MockContainer("1dc5c5c5d018",false));
    _testContainer.add(new _MockContainer("6c18f30c69f7",false));
    _testContainer.add(new _MockContainer("0cb214aeca27",false));
    _testContainer.add(new _MockContainer("62d64c7b0524",false));
    _testContainer.add(new _MockContainer("fc1488998e1e",false));
    _testContainer.add(new _MockContainer("aead9c2f0438",true));
    _testContainer.add(new _MockContainer("dbbe73e68b65",true));
}


