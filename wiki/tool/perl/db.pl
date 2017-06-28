use DBI;

$host="10.153.89.100";
$sid="JFZYDB";
$user="cssp_cc";
$passwd="cssp_cc123";

$statement="select column_name,data_type from dba_tab_columns where table_name='TEST' and owner='CSSP_CC'";
$dbh = DBI->connect("dbi:Oracle:host=$host;sid=$sid", $user, $passwd) || die "Can't Connect db;$DBI::errstr\n";

print "Connect Done\n";

$sth = $dbh->prepare($statement) || die "Can't Prepare $statement:$dbh::errstr\n";
$rvh = $sth->execute || die "Can't execute query:$sth::errstr\n";

##一次性将查询记录全部获取

my $alldata = $sth->fetchall_arrayref||die "fetchall error:$sth:errstr\n";
my($i,$j);
for $i (0 .. $#{$alldata}){
    for $j (0 .. $#{$alldata->[$i]}){
       my $var = $alldata->[$i][$j];
       @var = split("_", lc($var));
       $first=shift @var;
       foreach (@var) {
           $_=ucfirst($_);
       }
       print "@var\n";
       #print ucfirst(lc($var[1]));
       print join("",$first,@var,"\n");
       #print "@var \n";
       #print "$alldata->[$i][$j]\t";
   }
   print "\n";
  } 
print "$alldata[0][1] $alldata[0][0]\n";

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

$rv = $dbh->disconnect;

