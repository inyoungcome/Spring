use Template;

my $tt = Template->new({
        INCLUDE_PATH => './',
        INTERPOLATE => 1,
    }) || die "$Template::ERROR\n";

my $vars = {
    name => 'ycq',
    debt => '3 riffs and a sole',
    deadline => 'the next chorus',
};

$tt->process('myfile', $vars) || die $tt->error(), "\n";



#use Template;
#
#my $config = {
#    INCLUDE_PATH => './',  # or list ref
#    INTERPOLATE  => 1,               # expand "$var" in plain text
#    POST_CHOMP   => 1,               # cleanup whitespace
#    PRE_PROCESS  => 'header',        # prefix each template
#    EVAL_PERL    => 1,               # evaluate Perl code blocks
#};
#
#
##create Template object
#    my $template = Template->new($config);
#
#    # define template variables for replacement
#    my $vars = {
#        var1  => $value,
#        var2  => \%hash,
#        var3  => \@list,
#        var4  => \&code,
#        var5  => $object,
#    };
#
#    # specify input filename, or file handle, text reference, etc.
#    my $input = 'myfile';
#
#    # process input template, substituting variables
#    $template->process($input, $vars)
#    || die $template->error();
#
