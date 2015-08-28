# Put the library into rubys search-path
CURRENTPATH = File.expand_path(File.dirname(__FILE__))
LIBPATH = File.join(File.expand_path(CURRENTPATH), 'lib')

$LOAD_PATH.unshift(LIBPATH) unless $LOAD_PATH.include?(LIBPATH)
