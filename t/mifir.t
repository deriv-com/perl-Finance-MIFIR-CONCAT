use 5.014;
use warnings;
use strict;
use Test::More;
use Finance::MIFIR::CONCAT qw/mifir_concat/;
use utf8;
binmode(STDOUT,":utf8");
is mifir_concat({
        cc         => 'fr',
        date       => '17-03-1986',
        first_name => 'Elisabeth',
        last_name  => 'Doe',
    }
    ),
    'FR19860317ELISADOE##', 'Elisabeth Doe, born 17th March 1986, French national:';

is mifir_concat({
        cc         => 'se',
        date       => '02-12-1944',
        first_name => 'Robert',
        last_name  => 'O’Neal',
    }
    ),
    'SE19441202ROBERONEAL', 'Robert O\'Neal, born 2nd December 1944, national of Sweden and Canada';

is mifir_concat({
        cc         => 'AT',
        date       => '27-05-1955',
        first_name => 'Dr Joseph',
        last_name  => 'van der Strauss',
    }
    ),
    'AT19550527JOSEPSTRAU', 'Dr Joseph van der Strauss, born 27th May 1955, national of Austria and Germany';

is Finance::MIFIR::CONCAT::_process_name('Аркадий'),       'arkad', 'russian check';
is Finance::MIFIR::CONCAT::_process_name('Стругацкий'), 'strug', 'russian check';
is Finance::MIFIR::CONCAT::_process_name('АЙЗЕК'),           'aizek', 'russian check';
is Finance::MIFIR::CONCAT::_process_name('Азимов'),         'azimo', 'russian check';
is Finance::MIFIR::CONCAT::_process_name('Бьёрн'),           'biorn', 'russian check';
is Finance::MIFIR::CONCAT::_process_name('Страуструп'), 'strau', 'russian check';
is Finance::MIFIR::CONCAT::_process_name("Kirchg\x{e4}\x{df}ner"),'kirch', 'de check';
is Finance::MIFIR::CONCAT::_process_name('Abc’def'),'abcde', 'test ’ character';
is Finance::MIFIR::CONCAT::_process_name("gäßner"),'gasne', 'de check';
is Finance::MIFIR::CONCAT::_process_name("gẞner"),'gsner', 'de check';
is Finance::MIFIR::CONCAT::_process_name("gæner"),'ganer', 'de check';
is Finance::MIFIR::CONCAT::_process_name("gŒner"),'goner', 'de check';
is Finance::MIFIR::CONCAT::_process_name("gþner"),'gtner', 'de check';
is Finance::MIFIR::CONCAT::_process_name("gÞner"),'gtner', 'de check';

done_testing();
