package Finance::MIFIR::CONCAT;
use 5.014;
use warnings;
use strict;

use Date::Utility;
use Exporter 'import';
use File::ShareDir;
use Text::Iconv;
use YAML qw/LoadFile/;
use utf8;

our $VERSION = '0.01';
our @EXPORT = qw(concat mifir_concat);

=head1 NAME

Finance::MIFIR::CONCAT - provides CONCAT code generation out of client data according to MIFIR rules

=head1 SYNOPSIS

    use Finance::MIFIR::CONCAT;

    print Finance::MIFIR::CONCAT::concat({
        cc          => 'DE',
        date        => '1960-01-01',
        first_name  => 'Jack',
        last_name   => 'Daniels',
    });

    or

    use Finance::MIFIR::CONCAT qw/mifir_concat/;
    print mifir_concat({
        cc          => 'DE',
        date        => '1960-01-01',
        first_name  => 'Jack',
        last_name   => 'Daniels',
    });

=cut

my $converter = Text::Iconv->new("UTF-8", "ASCII//TRANSLIT//IGNORE");
our $config       = LoadFile(File::ShareDir::dist_file('Finance-MIFIR-CONCAT', 'mifir.yml'));
our $romanization = LoadFile(File::ShareDir::dist_file('Finance-MIFIR-CONCAT', 'romanization.yml'));

sub concat {
    my $args = shift;
    my $cc   = $args->{cc};
    my $date = Date::Utility->new($args->{date})->date_yyyymmdd;
    $date =~ s/\-//g;
    my $first_name = _process_name($args->{first_name});
    my $last_name  = _process_name($args->{last_name});
    return uc($cc . $date . $first_name . $last_name);
}

sub _process_name {
    my ($str) = @_;
    $str = lc($str);
    $str =~ s/$_/$romanization->{$_}/g for keys %$romanization;
    $str =~ s/$_\s+//g for (@{$config->{titles}}, @{$config->{prefixes}});
    $str =~ s/’//g;    # our iconv does not handle this correctly, it returns empty string if we have it
    $str = $converter->convert($str);
    $str =~ s/[^a-z]//g;
    $str = substr($str . '######', 0, 5);
    return $str;
}

*mifir_concat = \&concat;

1;
