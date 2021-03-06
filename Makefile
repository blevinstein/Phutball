empty :=
space := $(empty) $(empty)

JARS = $(subst $(space),:,$(wildcard lib/*.jar))
BUILDPATH = src:test:${JARS}
TESTPATH = src:test:build:${JARS}
RUNPATH = build:${JARS}

SCALAC_FLAGS =

DRIVER = com.blevinstein.phutball.Driver

SCALA_SRCS = \
		$(wildcard src/*/*/*/*.scala) \
		$(wildcard src/*/*/*/*/*.scala) \
		$(wildcard test/*/*/*/*.scala) \
		$(wildcard test/*/*/*/*/*.scala)

TEST_SRCS = $(wildcard test/*/*/*/*Spec.scala) \
						$(wildcard test/*/*/*/*/*Spec.scala)
TESTS = $(subst /,.,$(subst test/,,$(subst .scala,,${TEST_SRCS})))

default: compile

compile: ${SCALA_SRCS}
	scalac -cp ${BUILDPATH} ${SCALAC_FLAGS} ${SCALA_SRCS} -d build

run: compile
	scala -cp ${RUNPATH} ${DRIVER}

shell:
	scala -cp ${RUNPATH}

style:
	scalastyle -c scalastyle-config.xml src

tests: compile
	scala -cp ${TESTPATH} org.scalatest.run ${TESTS}

clean:
	rm -rf build/*
