
grammar Parser {
    rule  TOP  { I <love> <lang> }
    token love { '♥' | love }
    token lang { < Perl Rust Go Python Ruby > }
}

say Parser.parse: 'I ♥ Perl';
# OUTPUT: ｢I ♥ Perl｣ love => ｢♥｣ lang => ｢Perl｣

say Parser.parse: 'I love Rust';
# OUTPUT: ｢I love Rust｣ love => ｢love｣ lang => ｢Rust｣

