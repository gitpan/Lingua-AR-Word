package Lingua::AR::Word;

use strict;
use utf8;
use Switch;


sub stem{

	my $stem;
	my $word=$_[0];
	
	#let's strip down every prefix and suffix I'm aware of
	if($word=~/^([وفب]*ال|[بيلمتوسن]*ت|[بلوكف]*م|[ال]*ل|[ولسف]*ي|[وفلب]*ا|)(.*?)(ات|وا|تا|ون|وه|ان|تي|ته|تم|كم|ه[نم]*|ها|ية|تك|نا|ي[نه]*|[ةهيا]|)$/)
	{
 		$word=$2;
       }

       #let's strip down all other unnecessary letters according to the length of the word
       switch(length($word)){
			case 3	{
				$stem=$word;
			}
			case 4	{
				$stem=&four($word);
			}
			case 5	{
				$stem=&five($word);
			}
			case 6	{
				$stem=&six($word);
			}
			else	{
				$stem="NotFound";
			}

       }
return $stem;
}

sub four{
	my $word=$_[0];
	
	if($word=~/(.)(.)(ا|ي|و)(.)/){
		$word=$1.$2.$4;
	}
	elsif ($word=~/(.)(ا|و|ط|ي)(.)(.)/){
		$word=$1.$3.$4;
	}
	else{
		$word="NotFound";
	}
}

sub five{
	my $word=$_[0];
	
	if($word=~/(.)(.)(ا)(ا)(.)/){
		$word=$1.$2.$5;
	}
	elsif ($word=~/(.)(ت|ي)(.)(ا)(.)/){
		$word=$1.$3.$5;
	}
	elsif ($word=~/(.)(و)(ا)(.)(.)/){
		$word=$1.$4.$5;
	}
	elsif ($word=~/(.)(ا)(.)(ي|و)(.)/){
		$word=$1.$3.$5;
	}
	elsif ($word=~/(.)(.)(.)(ا|ي|و)(.)/){
		$word=$1.$2.$3.$5;
		$word=&four($word);
	}
	elsif ($word=~/(.)(.)(ا|ي)(.)(.)/){
		$word=$1.$2.$4.$5;
		$word=&four($word);
	}
	else{
		$word="NotFound";
	}
}

sub six{
	my $word=$_[0];
	
	if($word=~/(.)(و)(ا)(.)(ي)(.)/){
		$word=$1.$4.$6;
	}
	elsif ($word=~/(.)(.)(ا)(.)(ي)(.)/){
		$word=$1.$2.$4.$6;
		$word=&four($word);
	}
	else{
		$word="NotFound";
	}
}

1;
__END__

=head1 NAME

Lingua::AR::Word::Stem - Perl extension for finding the stem of a given Arabic word

=head1 SYNOPSIS

  use Lingua::AR::Word::Stem;

$stem=Lingua::AR::Word::stem(ARABIC_WORD_IN_UTF8);

=head1 DESCRIPTION

This module will take care of finding the stem of an Arabic word, through chopping the prefixes and suffixes of the word and by taking away unnecessary letters in the middle of the word.


=head1 AUTHOR

Andrea Benazzo, E<lt>andy@slacky.itE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2005 Andrea Benazzo. All rights reserved.
 This program is free software; you can redistribute it and/or
 modify it under the same terms as Perl itself.


=cut
