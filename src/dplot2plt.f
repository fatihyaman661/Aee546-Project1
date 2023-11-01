      subroutine dplot2plt(fn)
c-------------------------------------------------------------------
c... Converts dplot output to Tecplot input
c                        by c               Dr. Ismail
c..H. TUNCER c                    Fall 2000
c-------------------------------------------------------------------
      character*30 argi,fn,fni,fno,title
      dimension node(3,100000),neigh(3,100000),xy(2,100000)
      logical ok

c..get the argument list
c      call getarg(1,argi)
c      if( argi .eq. '') then
c        print*, '>>> Enter the rootname of the dpl file: '
c        read (*,*) fn
c      else
c        read(argi,*) fn
c      endif
      nl=len_trim(fn)
      fni=fn(1:nl)
      fno=fn(1:(nl-4))//'.plt'

      inquire(FILE=fni,EXIST=ok) 
      if( .not. ok ) then
        print*, ' ERROR: File does NOT exist: ',fni
        stop
      endif

      open(1,file=fni,form='formatted')
      read(1,*) title
      read(1,*) ncell,n1,n2
      read(1,*) (nt,node(1,n),  node(2,n), node(3,n),
     >              neigh(1,n),neigh(2,n),neigh(3,n),nc,n=1,ncell)
      read(1,*) nnode
      read(1,*) r1,r2,r3,r4,r5,r6
      read(1,*) (xy(1,n),xy(2,n),r1,r2,r3,r4,nc, n=1,nnode)
      close(1)

      open(1,file=fno,form='formatted')
      write(1,100) nnode,ncell
      write(1,101) (xy(1,n),xy(2,n),n=1,nnode)
      write(1,102) (node(1,n),node(2,n),node(3,n),n=1,ncell)
      close(1)

  100 format (' VARIABLES= "X", "Y"'/
     +        ' ZONE N=', I8,' E=', I8,' F=FEPOINT  ET=triangle' )
  101 format (2(1x,e12.5))
  102 format (3(1x,i7))


      end
