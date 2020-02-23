

ExternalProject_Add(CGAL
    URL https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-5.0.1/CGAL-5.0.1.tar.xz
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_CXX_FLAGS="-std=c++1y"
               -DCGAL_HEADER_ONLY=ON
               -DCMAKE_CXX_FLAGS_RELEASE=-DCGAL_NDEBUG
               -DWITH_examples=ON
               -DWITH_demos=ON
               -DWITH_tests=ON

)

SetProjectDependencies(TARGET CGAL)

