###############################################
#
# Makefile
#
###############################################

.DEFAULT_GOAL := run

open:
	open StackUI.xcodeproj

build:
	xcodebuild -project BookStore.xcodeproj -scheme BookStore -destination "generic/platform=iOS" build

github:
	open http://github.com/mlavergn/stackui

st:
	open -a SourceTree .