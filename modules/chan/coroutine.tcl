#! /usr/bin/tclsh

# # ## ### ##### ######## #############
# copyright
#
#     2018
#
#     Poor Yorick
# # ## ### ##### ######## #############

package require coroutine


proc [namespace current] chan {
	if {![string match ::* $chan]} {
		set chan [uplevel 1 [list ::namespace which $chan]]
	}
	$chan .specialize
	foreach name {
		gets read
	} {
		$chan .method $name coroutine::$name
	}
	return $chan
}


proc gets {_ args} {
	$_ .vars chan
	tailcall ::coroutine::util::gets $chan {*}$args
}


proc read {_ args} {
	$_ .vars chan
	tailcall ::coroutine::util::read $chan {*}$args
}
