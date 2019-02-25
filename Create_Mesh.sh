###beachte Voreinstellung des RRZN in der folgenden Zeile ist nicht "bash" sondern "ksh"
#PBS -S /bin/ksh
#PBS -N Create_Mesh #JOBNAME
#PBS -j oe
#PBS -l nodes=1:ppn=6
#PBS -l walltime=2:00:00,mem=24gb
#PBS -M MAIL.MAIL@mail.mail
#PBS -m abe
#PBS -W x=PARTITION:tfd:taurus:haku:tane:lena

### provide ANSYS through modules call: 
. $MODULESHOME/init/ksh
module load ANSYS/18.0

### change to work dir:
cd $PBS_O_WORKDIR

### create host string for cfx in parallel mode
while read line; do
    HOSTLIST+="$line",
done < $PBS_NODEFILE

HOSTLIST="${HOSTLIST%?}"

export ANSWAIT=1

### start program for distributed parallel run;
icemcfd -batch -script $PBS_O_WORKDIR/RPLNAME.rpl
