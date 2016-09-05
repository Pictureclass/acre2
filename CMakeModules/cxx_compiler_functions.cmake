function (acre_set_linker_options)
    if(CMAKE_COMPILER_IS_GNUCXX)
        # This target defaults to 32-bit on linux
        SET(CMAKE_CXX_FLAGS "-std=c++11 -march=i686 -m32 -O2 -s -fPIC -fpermissive")
        
        if(ACRE_LINK_TYPE STREQUAL "static")
            set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
            set(CMAKE_SHARED_LINKER_FLAGS "-static-libgcc -static-libstdc++")
        endif()
    elseif(MSVC)
        if(ACRE_LINK_TYPE STREQUAL "static")
            set(CMAKE_CXX_FLAGS_DEBUG "/D _DEBUG /MTd /Zi /Ob0 /Od /RTC1" PARENT_SCOPE)
            set(CMAKE_CXX_FLAGS_MINSIZEREL     "/MT /O1 /Ob1 /D NDEBUG" PARENT_SCOPE)
            set(CMAKE_CXX_FLAGS_RELEASE       "/MT /O2 /Ob2 /D NDEBUG" PARENT_SCOPE)
            set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "/MT /Zi /O2 /Ob1 /D NDEBUG" PARENT_SCOPE)
        else()
            set(CMAKE_CXX_FLAGS_DEBUG "/D _DEBUG /MDd /Zi /Ob0 /Od /RTC1" PARENT_SCOPE)
            set(CMAKE_CXX_FLAGS_MINSIZEREL     "/MD /O1 /Ob1 /D NDEBUG" PARENT_SCOPE)
            set(CMAKE_CXX_FLAGS_RELEASE       "/MD /O2 /Ob2 /D NDEBUG" PARENT_SCOPE)
            set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "/MD /Zi /O2 /Ob1 /D NDEBUG" PARENT_SCOPE)
        endif()
        
        set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} /NODEFAULTLIB:libcmt.lib")
        set(CMAKE_EXE_LINKER_FLAGS_MINSIZEREL "${CMAKE_EXE_LINKER_FLAGS_MINSIZEREL} /NODEFAULTLIB:libcmt.lib")
        set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} /NODEFAULTLIB:libcmt.lib")
        set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "${CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO} /NODEFAULTLIB:libcmt.lib")
    endif()
endfunction()

function (acre_set_build_output ) 
    set(EXECUTABLE_OUTPUT_PATH "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}${ACRE_NAME}" PARENT_SCOPE)
    set(LIBRARY_OUTPUT_PATH  "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}${ACRE_NAME}" PARENT_SCOPE)
endfunction()
