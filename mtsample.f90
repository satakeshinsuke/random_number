  program mtsample
    implicit none
    integer(kind=4), parameter :: N=624
    integer(kind=4) :: seed,i,nrnd
    real(kind=8),allocatable :: rnd(:)
    integer(kind=4) :: mti,initialized,mt(0:N-1)
    character(len=1) :: yesno
    real(kind=8) :: genrand_real1
    common /mt_state1/ mti,initialized
    common /mt_state2/ mt
!
    print *,"input seed number (0 to continue)"
    read(5,*) seed
    if(seed>0) then
       call init_genrand(seed)
    else
       call mt_initln
       open(7,file="mt_cont.dat",action="read")
       read(7,*) mti,initialized,mt
       close(7)
    end if
!
    print *,"input number to be generated"
    read(5,*) nrnd
    allocate(rnd(nrnd))
!
    do i=1,nrnd
       rnd(i)=genrand_real1() ! [0,1]-real8
    end do
!
    open(8,file="mt_rand.txt",action="write")
    write(8,'(f18.15)')rnd(:)
!
    print *,"record the MT status? (y/n)"
    read(5,*) yesno
    if(yesno=="y") then
       open(7,file="mt_cont.dat",action="write")
       write(7,*) mti,initialized,mt
       close(7)
    end if
!
  end program mtsample
       
       
    
