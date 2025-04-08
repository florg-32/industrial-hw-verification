#  File Name:         RunAllTests.pro
#  Revision:          STANDARD VERSION
#
#  Maintainer:        Jim Lewis      email:  jim@synthworks.com
#  Contributor(s):
#     Jim Lewis      jim@synthworks.com
#
#
#  Description:
#        Run all OSVVM Libraries Verification Component tests   
#
#  Developed for:
#        SynthWorks Design Inc.
#        VHDL Training Classes
#        11898 SW 128th Ave.  Tigard, Or  97223
#        http://www.SynthWorks.com
#
#  Revision History:
#    Date      Version    Description
#     1/2020   2020.01    Updated Licenses to Apache
#     1/2019   2019.01    Compile Script for OSVVM
#
#
#  This file is part of OSVVM.
#  
#  Copyright (c) 2019 - 2022 by SynthWorks Design Inc.  
#  
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#  
#      https://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

SetCoverageAnalyzeEnable true
# SetCoverageAnalyzeOptions  "options go here"  ; # see Scripts/VendorScripts_<name>.tcl for defaults
SetCoverageSimulateEnable true
# SetCoverageSimulateOptions "options go here"  ; # see Scripts/VendorScripts_<name>.tcl for defaults

include OsvvmLibraries.pro

# Turn Analyze coverage off so we do not collect coverage on testbenches
SetCoverageAnalyzeEnable false

if {[DirectoryExists AXI4]} { 
  include ./AXI4/Axi4/RunDemoTests.pro
  include ./AXI4/AxiStream/RunDemoTests.pro
}
if {[DirectoryExists UART]} { 
  include ./UART/RunDemoTests.pro
}
if {[DirectoryExists Ethernet]} { 
  include ./Ethernet/RunDemoTests.pro
}
SetCoverageSimulateEnable false
