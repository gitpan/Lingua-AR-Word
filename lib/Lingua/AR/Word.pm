package Lingua::AR::Word;

use strict;
use warnings;
use utf8;
use Switch;


use Lingua::AR::Word::Stem;	#needed to find the stem
use Lingua::AR::Word::Encode;	#needed to encode into ArabTeX


our $VERSION = '1.5.2';


sub new{

	my $class=$_[0];

	my $this={
		_word=>$_[1],
		_stem=>"",
		_translation=>"",
		_arabtex=>""
	};

	$this->{_stem}=&stem($this->{_word});
	$this->{_arabtex}=&encode($this->{_word});

	bless($this,$class);
}



sub get_word{
	"WORD: $_[0]->{_word}\n";
}

sub get_stem{
	"STEM: $_[0]->{_stem}\n";

}

sub get_arabtex{
	"ARABTEX: $_[0]->{_arabtex}\n";

}




1;
__END__

=head1 NAME

Lingua::AR::Word - Perl extension for getting the stem and ArabTeX encoding of Arabic words

=head1 SYNOPSIS

use utf8;
use Lingua::AR::Word;


my $word=Lingua::AR::Word->new(ARABIC_WORD_IN_UTF8);


open FOUTPUT, ">>TEST" or die "Cannot create TEST: $!\n";
binmode(FOUTPUT,":utf8");

print FOUTPUT $word->get_word();
print FOUTPUT $word->get_stem();
print FOUTPUT $word->get_arabtex();


close FOUTPUT;


=head1 DESCRIPTION

In order to work on an Arabic word, you need to create the object Lingua::AR::Word, passing the Arabic word encoded in utf8 to the constructor.
You will then be able to get the stem through get_stem().
You will get the ArabTeX translittered form through get_arabtex().
If you also want the translation, you'll need to create the $db object (described in the Lingua::AR::Db module), so that it may look for its meaning in the correct Database.

Remember that input-output directly to shell will not be useful as long as your shell doesn't support utf8 encoded characters.
In the example above, for example, I piped the output to another file AND I forced its writing in utf8.



=head1 SEE ALSO

You may find more info about ArabTeX encoding at ftp://ftp.informatik.uni-stuttgart.de/pub/arabtex/arabtex.htm



=head1 AUTHOR

Andrea Benazzo, E<lt>andy@slacky.itE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2005 Andrea Benazzo. All rights reserved.
 This program is free software; you can redistribute it and/or
 modify it under the same terms as Perl itself.


=cut
