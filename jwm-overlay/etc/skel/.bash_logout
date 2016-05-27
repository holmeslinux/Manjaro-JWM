#
# ~/.bash_logout
#
#
#!/bin/sh

static=cudli20y.default.backup
link=cudli20y.default
volatile=/dev/shm/palemoon-$USER

IFS=
set -efu

cd ~/.moonchild\ productions/pale\ moon

if [ ! -r $volatile ]; then
	mkdir -m0700 $volatile
fi

if [ "$(readlink $link)" != "$volatile" ]; then
	mv $link $static
	ln -s $volatile $link
fi

if [ -e $link/.unpacked ]; then
	rsync -av --delete --exclude .unpacked ./$link/ ./$static/
else
	rsync -av ./$static/ ./$link/
	touch $link/.unpacked
fi
