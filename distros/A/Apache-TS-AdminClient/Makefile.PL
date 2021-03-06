# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 5.006;
use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Apache::TS::AdminClient',
    VERSION_FROM => 'lib/Apache/TS/AdminClient.pm',    # finds $VERSION
    LICENSE      => 'apache',
    PREREQ_PM    => {
        "IO::Socket::UNIX" => 0,
        "IO::Select"       => 0,
        "Carp"             => 0,

    },    # e.g., Module::Name => 1.1
    (   $] >= 5.005
        ?    ## Add these new keywords supported since 5.005
            (
            ABSTRACT_FROM => 'lib/Apache/TS/AdminClient.pm',
            AUTHOR => 'Traffic Server Dev Team <dev@trafficserver.apache.org>'
            )
        : ()
    ),
);
