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

/// Helper for Docker cmdline operations.
///
/// Mainly thought as a helper-library for Grinder
///
///     @Task("Stops containers")
///     dockerStopp() {
///         ["db-webappbase-test", "db-mobiad-test"].forEach((final String container) {
///             log("Stopping container: $container");
///             new Docker()..stop([container ],quiet: true);
///         });
///     }
///
///     @Task("Start container")
///     @Depends(dockerStopp)
///     dockerStart() {
///         new Docker()..stop([ "db-webappbase-test" ],quiet: true);
///     }
///
///     @Task("Check if container runs and if container is available")
///     containerCheck() async {
///         final Docker docker = new Docker();
///
///         [ "db-mobiad-test"].forEach((final String name) => docker.stop([ name ]));
///         docker.start([ containerNameToCheck] );
///
///         final Container container = new Container(runningContainerIDs());
///         if(!container.names.contains(containerNameToCheck)) {
///
///             container.names.forEach((final String name) {
///                 log("Active containers: -${name}-");
///             });
///
///             throw new ArgumentError("${containerNameToCheck} must be running for this test!");
///         }
///     }
///
library docker;

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:validate/validate.dart';

part "docker/DockerRunOptions.dart";
part "docker/Docker.dart";
part "docker/Container.dart";
