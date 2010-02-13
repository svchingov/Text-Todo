#===============================================================================
#
#         FILE:  special_tags.t
#
#  DESCRIPTION:  Test special tags
#
#       AUTHOR:  Andrew Fresh (AAF), andrew@cpan.org
#      COMPANY:  Red River Communications
#      CREATED:  01/09//10 17:43
#     REVISION:  $AFresh1: special_tags.t,v 1.5 2010/01/15 19:50:15 andrew Exp $
#===============================================================================

use strict;
use warnings;

use Test::More tests => 8;

my $class;
BEGIN { 
	$class = 'Text::Todo::Entry';
	use_ok( $class, "use $class" ) 
}

diag("Testing special tags in $class $Text::Todo::Entry::VERSION");

my %sample = (
    text     => '(B) @home @work send email to andrew@cpan.org DUE:2011-01-01 +say_thanks',

    known_tags => {
        context => '@',
        project => '+',
        due_date => 'DUE:',
    },

    priority  => 'B',
    contexts  => [ 'home', 'work' ],
    projects  => ['say_thanks'],
    due_dates => ['2011-01-01'],
);

my $e = new_ok($class, [ {text => $sample{text}, tags => { due_date => 'DUE:' }} ]);

is_deeply( $e->known_tags, $sample{known_tags}, 'check known_tags' );

is( $e->text,     $sample{text},     'Make sure entry matches' );
is( $e->priority, $sample{priority}, 'check priority' );
is_deeply( [ $e->contexts ], $sample{contexts}, 'check contexts' );
is_deeply( [ $e->projects ], $sample{projects}, 'check projects' );

is_deeply( [ $e->due_dates ], $sample{due_dates}, 'check due_dates');

#done_testing();
