cmake_minimum_required(VERSION 2.8.3)

project(rexarm_description)

find_package(catkin REQUIRED)

catkin_package()

install(DIRECTORY robots/
    DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/robots
)
install(DIRECTORY launch/
    DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
)
install(DIRECTORY config/
    DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/config
)
