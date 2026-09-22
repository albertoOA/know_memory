
cmake_minimum_required(VERSION 2.8.3)
project(know_memory)

SET(OCRA_VERSION "1.0.0")
set(OCRA_DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/owl")

# include additional CMake macros
include("cmake/ontologies.cmake")

find_package(catkin REQUIRED COMPONENTS
  std_msgs
  message_generation
)

catkin_python_setup()

# add_service_files(
#   FILES
# )

generate_messages(
  DEPENDENCIES
  std_msgs
)

catkin_package(
    CATKIN_DEPENDS 
    rospy 
    message_runtime
)


install_ontology(
    URL "http://www.iri.upc.edu/groups/perception/OCRA/ont/ocra.owl"
    VERSION "${OCRA_VERSION}"
    DESTINATION "${OCRA_DESTINATION}"
    UPDATE "TRUE")

install_ontology(
    URL "http://www.iri.upc.edu/groups/perception/OCRA/ont/ocra_filling_a_tray.owl"
    VERSION "${OCRA_VERSION}"
    DESTINATION "${OCRA_DESTINATION}"
    UPDATE "TRUE")



install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch)

install(DIRECTORY owl/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/owl)
  
install(DIRECTORY prolog/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/prolog)
  
install(PROGRAMS
  scripts/urdf_to_sem
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
  
install(DIRECTORY src
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
