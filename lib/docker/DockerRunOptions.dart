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
     
part of docker;

/// Arguments passed to [Docker.run].
/// See [Docker.run] for more details.
class DockerRunOptions {
    // final Logger _logger = new Logger('docker.DockerRunOptions');

    final String workingDirectory;
    final Map<String, String> environment;
    final bool includeParentEnvironment;
    final bool runInShell;
    final Encoding stdoutEncoding;
    final Encoding stderrEncoding;

    DockerRunOptions({this.workingDirectory,
    this.environment,
    this.includeParentEnvironment: true,
    this.runInShell: false,
    this.stdoutEncoding: SYSTEM_ENCODING,
    this.stderrEncoding: SYSTEM_ENCODING});

    /// Create a clone with updated values in one step.
    /// For omitted parameters values of the original instance are copied.
    DockerRunOptions clone({String workingDirectory,
    Map<String, String> environment,
    bool includeParentEnvironment,
    bool runInShell,
    Encoding stdoutEncoding,
    Encoding stderrEncoding}) {
        Map<String, String> env;
        if (environment != null) {
            env = new Map.from(environment);
        }
        else {
            env = this.environment != null ? new Map.from(this.environment) : {};
        }
        return new DockerRunOptions(
            workingDirectory:
            workingDirectory != null ? workingDirectory : this.workingDirectory,
            environment: env,
            includeParentEnvironment: includeParentEnvironment != null
                ? includeParentEnvironment
                : this.includeParentEnvironment,
            runInShell: runInShell != null ? runInShell : this.runInShell,
            stdoutEncoding:
            stdoutEncoding != null ? stdoutEncoding : this.stdoutEncoding,
            stderrEncoding:
            stderrEncoding != null ? stderrEncoding : this.stderrEncoding);
    }
}