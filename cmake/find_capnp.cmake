option (ENABLE_CAPNP "Enable Cap'n Proto" ON)

if (ENABLE_CAPNP)
	set (CAPNP_PATHS "/usr/local/opt/capnp/lib")
	set (CAPNP_INCLUDE_PATHS "/usr/local/opt/capnp/include")
	find_library (CAPNP capnp PATHS ${CAPNP_PATHS})
	find_library (CAPNPC capnpc PATHS ${CAPNP_PATHS})
	find_library (KJ kj PATHS ${CAPNP_PATHS})
	set (CAPNP_LIBS ${CAPNP} ${CAPNPC} ${KJ})

	find_path (CAPNP_INCLUDE_DIR NAMES capnp/schema-parser.h PATHS ${CAPNP_INCLUDE_PATHS})
	if (CAPNP_INCLUDE_DIR AND CAPNP_LIBS)
	    include_directories (${CAPNP_INCLUDE_DIR})
	    set(USE_CAPNP 1)
	endif ()
endif ()

if (USE_CAPNP)
    message (STATUS "Using capnp=${USE_CAPNP}: ${CAPNP_INCLUDE_DIR} : ${CAPNP_LIBS}")
else ()
    message (STATUS "Build without capnp (support for Cap'n Proto format will be disabled)")
endif ()
