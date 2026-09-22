#!/usr/bin/env python3
# coding=utf-8
# Author: Alberto Olivares Alarcos <aolivares@iri.upc.edu>, Institut de Robòtica i Informàtica Industrial, CSIC-UPC

import sys
import rospy

from know_memory.utils_module import generalUtils, rosprologUtils

if __name__ == "__main__":
    rospy.init_node("memory_generation_from_data_node", sys.argv)
    rospy.loginfo(rospy.get_name() + ": a know-demo node has been initialized.")
    
    general_utils_object = generalUtils()
    rosprolog_utils_object = rosprologUtils()

    if (rospy.has_param('~keep_node_running')):
        keep_node_running = rospy.get_param('~keep_node_running')
    else:
        keep_node_running = False

    if (rospy.has_param('~store_neem')):
        store_neem = rospy.get_param('~store_neem')
    else:
        store_neem = False
    
    if (rospy.has_param('~dataset_name')):
        dataset_name = rospy.get_param('~dataset_name')
    else:
        dataset_name = 'plans_general_properties'
    dataset_csv_file_name = dataset_name + '.csv'

    # read the properties of the target plans (demonstrations from data)
    plans_qualities_values_dict = general_utils_object.create_dict_from_csv_file(general_utils_object.csv_file_path,\
                                                                                  dataset_csv_file_name, ',')
    ##print(plans_qualities_values_dict)

    plan_triples_list = rosprolog_utils_object.plan_qualities_dict_to_triples_list(plans_qualities_values_dict)
    """ # for debugging
    for i in range(0, 25):
        print(plan_triples_list[i])
        print("\n")
    """
    ##print(plan_triples_list)

    typicallity_triples_list = rosprolog_utils_object.classify_plan_qualities_as_typical_or_atypical_and_generate_triples(plans_qualities_values_dict)
    plan_triples_list.extend(typicallity_triples_list)
    print(typicallity_triples_list)

    plan_assertion_query_text = rosprolog_utils_object.construct_query_text_for_multiple_triples_assertion(plan_triples_list, True)
    ##print(plan_assertion_query_text)

    rosprolog_utils_object.rosprolog_assertion_query(plan_assertion_query_text)


    # run some logic-based rules to assert new comparative relations between every pair of plans
    query_string_foo_ = "compare_all_existing_plans_in_pairs()."
    rosprolog_utils_object.rosprolog_assertion_query(query_string_foo_)

    # run some logic-based rules to assert new knowledge about the classification of plans as typical or atypical
    query_string_foo_ = "classify_all_plans_as_typical_or_atypical()."
    rosprolog_utils_object.rosprolog_assertion_query(query_string_foo_)

    # save the NEEM using in the name 'dataset_name' and the current time
    if store_neem:
        query_string_foo_ = "ros_package_path('know_memory', P1), \
            atom_concat(P1, '/neem/"+ dataset_name +"_' , P2), \
            get_time(T), atom_concat(P2, T, P3), mng_dump(roslog, P3)."
        rosprolog_utils_object.rosprolog_assertion_query(query_string_foo_)
    else:
        pass
    
    if keep_node_running:
        rospy.spin()
    else:
        pass

