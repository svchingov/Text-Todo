use strict;
use warnings;

use Test::More tests => 4;

use Text::Todo::Test;

#
# check aborted list output on \c escape sequence
#
test_set_content data => <<'EOF';
first todo
second todo run C:\WINDOWS\sysnative\cscript.exe
third todo
EOF
    ;
test_todo_session 'aborted list output on backslash-c', <<'EOF';
>>> todo.sh list
1 first todo
2 second todo run C:\WINDOWS\sysnative\cscript.exe
3 third todo
--
TODO: 3 of 3 tasks shown

>>> todo.sh list 2
2 second todo run C:\WINDOWS\sysnative\cscript.exe
--
TODO: 1 of 3 tasks shown
EOF
    ;
#
# check various escape sequences
#
test_set_content data => <<'EOF';
first todo with \\, \a and \t
second todo with \r\n line break
third todo with \x42\x55\x47 and \033[0;31m color codes \033[0;30m
EOF
    ;
test_todo_session 'various escape sequences', <<'EOF';
>>> todo.sh list
1 first todo with \\, \a and \t
2 second todo with \r\n line break
3 third todo with \x42\x55\x47 and \033[0;31m color codes \033[0;30m
--
TODO: 3 of 3 tasks shown
EOF
    ;
#
# check embedding of actual color sequence
#
test_set_content data => <<'EOF';
A task with [0;31m actual color [0;30m
EOF
    ;
test_todo_session 'embedding of actual color sequence', <<'EOF';
>>> todo.sh list
1 A task with [0;31m actual color [0;30m
--
TODO: 1 of 1 tasks shown
EOF
    ;
#done_testing();

