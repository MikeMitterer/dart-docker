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

class Docker {
    static const String _EXECUTABLE = "docker";

    /// Synchronously run an [executable].
    ///
    /// If [quiet] is false, [log]s the stdout. The stderr is always logged.
    ///
    /// Returns the stdout.
    ///
    /// All other optional parameters are forwarded to [Process.runSync].
    static String call(final List<String> arguments, { DockerRunOptions runOptions, bool quiet: false } ) {
        final Logger _logger = new Logger('docker.Docker');

        if (!quiet) _logger.info("${_EXECUTABLE} ${arguments.join(' ')}");
        if (runOptions == null) runOptions = new DockerRunOptions();

        ProcessResult result = Process.runSync(_EXECUTABLE, arguments,
            workingDirectory: runOptions.workingDirectory,
            environment: runOptions.environment,
            includeParentEnvironment: runOptions.includeParentEnvironment,
            runInShell: runOptions.runInShell,
            stdoutEncoding: runOptions.stdoutEncoding,
            stderrEncoding: runOptions.stderrEncoding);

        if (!quiet) {
            if (result.stdout != null && result.stdout.isNotEmpty) {
                _logger.info(result.stdout.trim());
            }
        }

        if (result.stderr != null && result.stderr.isNotEmpty) {
            _logger.shout(result.stderr);
        }

        if (result.exitCode != 0) {
            throw <String,dynamic>{
                "executable" : _EXECUTABLE,
                "exitCode" : result.exitCode,
                "stdout" : result.stdout,
                "stderr" : result.stderr
            };
        }

        return result.stdout;
    }

    static String ps(final List<String> arguments, { DockerRunOptions runOptions, bool quiet: false } ) {
        _addArgument("ps",arguments);
        return call(arguments,runOptions: runOptions, quiet: quiet);
    }

    static String inspect(final List<String> arguments, { DockerRunOptions runOptions, bool quiet: false } ) {
        _addArgument("inspect",arguments);
        return call(arguments,runOptions: runOptions, quiet: quiet);
    }

    static String start(final List<String> arguments, { DockerRunOptions runOptions, bool quiet: false } ) {
        _addArgument("start",arguments);
        return call(arguments,runOptions: runOptions, quiet: quiet);
    }

    static String stop(final List<String> arguments, { DockerRunOptions runOptions, bool quiet: false } ) {
        _addArgument("stop",arguments);
        return call(arguments,runOptions: runOptions, quiet: quiet);
    }

    static String run(final List<String> arguments, { DockerRunOptions runOptions, bool quiet: false } ) {
        _addArgument("run",arguments);
        return call(arguments,runOptions: runOptions, quiet: quiet);
    }

    //- private -----------------------------------------------------------------------------------

    static void _addArgument(final String argument,final List<String> arguments) {
        if(arguments != null && arguments.length > 0 && arguments.first != argument) {
            arguments.insert(0,argument);
        }
    }
}
