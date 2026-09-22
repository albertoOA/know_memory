/*
  Copyright (C) Alberto Olivares Alarcos
  All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.
      * Neither the name of the <organization> nor the
        names of its contributors may be used to endorse or promote products
        derived from this software without specific prior written permission.
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  @author Alberto Olivares Alarcos
  @license BSD
*/

:- register_ros_package(knowrob).
:- register_ros_package(know_memory).

% register ROS packages to resolve IRI prefixes to local paths
:- ros_package_iri(know_memory, 'http://www.iri.upc.edu/groups/perception/OCRA/ont').

:- use_module(library('semweb/rdf_db'), 
    [ rdf_equal/2, rdf_register_ns/3 ]).

:- rdf_register_ns('ocra', 'http://www.iri.upc.edu/groups/perception/OCRA/ont/ocra.owl#', [keep(true)]).
:- rdf_register_ns('ocra_filling_a_tray', 'http://www.iri.upc.edu/groups/perception/OCRA/ont/ocra_filling_a_tray.owl#', [keep(true)]).
:- rdf_register_ns('ocra_cloth', 'http://www.iri.upc.edu/groups/perception/OCRA/ont/ocra_cloth.owl#', [keep(true)]).
:- rdf_register_ns('ocra_home', 'http://www.iri.upc.edu/groups/perception/OCRA/ont/ocra_home.owl#', [keep(true)]).
:- rdf_register_ns('ocra_common', 'http://www.iri.upc.edu/groups/perception/OCRA/ont/ocra_common.owl#', [keep(true)]).
:- rdf_register_ns('ocra_plan', 'http://www.iri.upc.edu/groups/perception/OCRA/ont/ocra_plan.owl#', [keep(true)]).
:- rdf_register_ns('map', 'http://www.iri.upc.edu/groups/perception/OCRA/maps/filling_a_tray.owl#', [keep(true)]).
:- rdf_register_ns('generic_map', 'http://www.iri.upc.edu/groups/perception/ont/maps/generic_map.owl#', [keep(true)]).

:- mng_drop(roslog, triples). /*to delete manually asserted triples using the rosprolog_commandline, which remain in the MongoDB*/

% load init files in sub-directories
:- use_directory('prolog_reasoning').
