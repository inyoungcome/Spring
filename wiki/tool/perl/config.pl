use Config::General;

$conf = Config::General->new("rcfile");
my %config = $conf->getall;

$table = $config{tablename};

@tables = split('=', $table);



