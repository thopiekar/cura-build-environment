if(BUILD_OS_LINUX)
    set(savitar_cmake_command PATH=${CMAKE_INSTALL_PREFIX}/bin/:$ENV{PATH} LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib/ PYTHONPATH=${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/:${CMAKE_INSTALL_PREFIX}/lib/python3.5:${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages/ ${CMAKE_COMMAND})
else()
    set(savitar_cmake_command ${CMAKE_COMMAND})
endif()

ExternalProject_Add(cgal-swig-bindings
    GIT_REPOSITORY https://github.com/CGAL/cgal-swig-bindings.git
    GIT_TAG origin/master
    GIT_SHALLOW 1
    CMAKE_COMMAND ${savitar_cmake_command}
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_CXX_FLAGS="-std=c++1y"
               -DCGAL_HEADER_ONLY=ON
               -DPYTHON_EXECUTABLE=${Python3_EXECUTABLE}

)

SetProjectDependencies(TARGET cgal-swig-bindings DEPENDS CGAL Python)

