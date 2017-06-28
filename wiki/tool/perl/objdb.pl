use DBI;
use Config::General;

#读取配置文件
$conf = Config::General->new("rcfile");
my %config = $conf->getall;

$table = $config{tablename};

@tables = split('=', $table);

#数据库配置
%const = (DATE=>"String",NUMBER=>"Double",VARCHAR2=>"String");
$host="10.153.89.100";
$sid="JFZYDB";
$user="cssp_cc";
$passwd="cssp_cc123";

$dbh = DBI->connect("dbi:Oracle:host=$host;sid=$sid", $user, $passwd) || die "Can't Connect db;$DBI::errstr\n";

print "Connect Done\n";

@AoA = ();
#$sth = $dbh->prepare($statement) || die "Can't Prepare $statement:$dbh::errstr\n";
#$rvh = $sth->execute || die "Can't execute query:$sth::errstr\n";
foreach $tb (@tables) {

    print "Table's Name = $tb\n";
    $statement="select column_name,data_type from dba_tab_columns where table_name='$tb' and owner='CSSP_CC'";
    print "\$statement = $statement\n";
    $sth = $dbh->prepare($statement) || die "Can't Prepare $statement:$dbh::errstr\n";
    $rvh = $sth->execute || die "Can't execute query:$sth::errstr\n";
    print $rvh;
    
##一次性将查询记录全部获取

    my $alldata = $sth->fetchall_arrayref||die "fetchall error:$sth:errstr\n";

##解析查询结果

    my($i,$j);


    for $i (0 .. $#{$alldata}){
        my $obj = {};
        my $dbvar;
        my $var = $alldata->[$i][0];
        @var = split("_", lc($var));
        $first=shift @var;
        foreach (@var) {
            $_=ucfirst($_);
        }
        #print "@var\n";
        #print ucfirst(lc($var[1]));
        $dbvar = join("",$first,@var);
        $key = $alldata->[$i][1]; 
        push @AoA,[$const{($alldata->[$i][1])} ,$dbvar];
        #print "@var \n";
        #print "$alldata->[$i][$j]\t";

        #print "\n";
    } 

    for $ref (@AoA){
        print "private @$ref;";
        print "\n";
    }


#print "$alldata[0][1] $alldata[0][0]\n";

##每次获取单行记录 fetchrow_array()
#my @refdate = $sth->fetchrow_array();
#$size=$#refdate;
#print "@refdate\n Size=$size";
#print "Size=$size \$refdate[0]=$refdate[0] \$refdate[1]=$refdata[-1]";

#my @refdate = $sth->fetchrow_array();
#$size=@refdate;
#print "@refdate\n";
#print "Size=$size \$refdate[0]=$refdate[0] \$refdate[1]=$refdata[1]";
    $sth->finish;
}

$rv = $dbh->disconnect;

