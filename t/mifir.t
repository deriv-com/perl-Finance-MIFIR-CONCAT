use 5.014;
use warnings;
use strict;
use Test::More;
use Finance::MIFIR::CONCAT qw/mifir_concat/;
use utf8;

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

is Finance::MIFIR::CONCAT::_process_name('ßŚáŹł'), 'ssazl', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ĄŴÇĎŇ'), 'awcdn', 'character check';
is Finance::MIFIR::CONCAT::_process_name('êŽǍţš'), 'ezats', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ěęŐÒñ'), 'eeoon', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ĝœëşĚ'), 'goese', 'character check';
is Finance::MIFIR::CONCAT::_process_name('åÝćųĺ'), 'aycul', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ĵăżÔť'), 'jazot', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ÄĥÆÜĘ'), 'ahaue', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ÁďľĐą'), 'adlda', 'character check';
is Finance::MIFIR::CONCAT::_process_name('àÕìÍÂ'), 'aoiia', 'character check';
is Finance::MIFIR::CONCAT::_process_name('řïůŰÖ'), 'riuuo', 'character check';
is Finance::MIFIR::CONCAT::_process_name('õŒØŁȚ'), 'ooolt', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ĽÃĤæè'), 'lahae', 'character check';
is Finance::MIFIR::CONCAT::_process_name('éĞğçț'), 'eggct', 'character check';
is Finance::MIFIR::CONCAT::_process_name('űŃģÿó'), 'ungyo', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ÊúĻčÅ'), 'eulca', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ĉâÀŮő'), 'caauo', 'character check';
is Finance::MIFIR::CONCAT::_process_name('îŨĹĢÙ'), 'iulgu', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ıŢÎýŝ'), 'itiys', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ŤŕòŲČ'), 'trouc', 'character check';
is Finance::MIFIR::CONCAT::_process_name('íśÏșÛ'), 'isisu', 'character check';
is Finance::MIFIR::CONCAT::_process_name('đûËŵĈ'), 'duewc', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ùüžĴð'), 'uuzjd', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ŜŠÈŔã'), 'ssera', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ĆŶäȘũ'), 'cyasu', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ÚŞǎöĂ'), 'usaoa', 'character check';
is Finance::MIFIR::CONCAT::_process_name('þŻÓøẞ'), 'tzoos', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ôļŘķň'), 'olrkn', 'character check';
is Finance::MIFIR::CONCAT::_process_name('źĶŷÉń'), 'zkyen', 'character check';
is Finance::MIFIR::CONCAT::_process_name('ÌÞŸĜÑ'), 'itygn', 'character check';


done_testing();
