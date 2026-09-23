#!/usr/bin/env python3
# coding=utf-8
# Author: Alberto Olivares Alarcos <aolivares@iri.upc.edu>, Institut de Robòtica i Informàtica Industrial, CSIC-UPC

import sys
import rospy

from know_memory.utils_module import generalUtils, rosprologUtils

if __name__ == "__main__":
    rospy.init_node("graph_memory_export_from_knowledge_base", sys.argv)
    rospy.loginfo(rospy.get_name() + ": a know-memory node has been initialized.")
    
    general_utils_object = generalUtils()
    rosprolog_utils_object = rosprologUtils()

    if (rospy.has_param('~keep_node_running')):
        keep_node_running = rospy.get_param('~keep_node_running')
    else:
        keep_node_running = False

    if (rospy.has_param('~dataset_name')):
        dataset_name = rospy.get_param('~dataset_name')
    else:
        dataset_name = 'plans_general_properties'


    # query to export an already loaded knowledge base as an RDF knowledge graph
    query_string_foo_= "use_module(library(semweb/rdf_db)), findall(triple(S, P, O), \
                       ( triple(S, P, O), nonvar(S), nonvar(P), nonvar(O), ground(S), ground(P), ground(O) ), \
                       TripleList), forall(member(triple(Su, Pr, Ob), TripleList), (number(Ob) \
                       -> rdf_assert(Su, Pr, literal(Ob), my_temp_graph) ; rdf_assert(Su, Pr, Ob, my_temp_graph))), \
                       ros_package_path('know_memory', P1), \
                       atom_concat(P1, '/rdf/"+ dataset_name +"_episodic_memory_knowledge_graph_' , P2), \
                       get_time(T), atom_concat(P2, T, P3), atom_concat(P3, '.rdf' , P4), \
                       rdf_save(P4, [graph(my_temp_graph)]), rdf_retractall(_, _, _, my_temp_graph)."
    
    rosprolog_utils_object.rosprolog_assertion_query(query_string_foo_)
    
    if keep_node_running:
        rospy.spin()
    else:
        pass