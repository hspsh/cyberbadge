include $(wildcard *.deps)

%.stl: %.scad
	openscad -m make -o $@ -d $@.deps $<