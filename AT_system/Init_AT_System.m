function sys = Init_AT_System(type,Num,WperB,Wlen)
%INITSPINS Initialize a configuration of spins.
%   spin = INITSPINS(numSpinsPerDim, p) returns a configuration of spins
%   with |numSpinsPerDim| spins along each dimension and a proportion |p|
%   of them pointing upwards. |spin| is a matrix of +/- 1's.
%   Copyright 2020 Jinyeop Song.

sys=AT_System;
    sys.Tnum=Num;

%% linear 1D
if(type=="linear1D")
   
    p=1;
    eps=0.1;
    sys.type="linear1D";
    sys.WperB=WperB;
    sys.Wlen=Wlen;
    sys.Tnum=Num;
    sys.T=(rand(1,sys.Tnum)>p);

        sys.T_position=struct;
    sys.T_position.x=linspace(1,1*sys.Tnum,sys.Tnum);
    sys.T_position.y=zeros(1,sys.Tnum);
    sys.T_position.z=zeros(1,sys.Tnum);
    
    sys.B_relation=[];
    sys.B_position=struct;
    sys.B_position.x=[];
    sys.B_position.y=[];
    sys.B_position.z=[];

    bi=0;
    for i=1:sys.Tnum
        for j=(i+1):sys.Tnum
            if(DistanceBtwTwoTargets(sys,i,j)<1+eps)
                bi=bi+1;
                sys.B_relation = [sys.B_relation ; [i,j]];
                sys.B_position.x = [sys.B_position.x,(sys.T_position.x(i)+sys.T_position.x(j))/2];
                sys.B_position.y = [sys.B_position.y,(sys.T_position.y(i)+sys.T_position.y(j))/2];
                sys.B_position.z = [sys.B_position.z,(sys.T_position.z(i)+sys.T_position.z(j))/2];
            end
        end
    end
    sys.Bnum=size(sys.B_relation,1);
    sys.B=zeros(1,sys.Bnum);
    sys.B2W=zeros(1,sys.Bnum);
    
    for i=1:sys.Bnum
        for j=(i+1):sys.Bnum
            if(DistanceBtwTwoBivalents(sys,i,j)<Wlen+eps)
                bi=bi+1;
                sys.W_relation = [sys.W_relation ; [i,j]];
            end
        end
    end
    sys.Wnum=size(sys.W_relation,1);
    sys.W=zeros(1,sys.Wnum);
end
%% circle 1D 
if(type=="circular1D")
        p=1;
    eps=0.1;
    sys.type="linear1D";
    sys.WperB=WperB;
    sys.Wlen=Wlen;
    sys.Tnum=Num;
    sys.T=(rand(1,sys.Tnum)>p);
    sys.T_position=struct;
    sys.T_position.x=sys.Tnum/2/pi*cos(linspace(0,2*pi,sys.Tnum));
    sys.T_position.y=sys.Tnum/2/pi*sin(linspace(0,2*pi,sys.Tnum));
    sys.T_position.z=zeros(1,sys.Tnum);

    sys.B_relation=[];
    sys.B_position=struct;
    sys.B_position.x=[];
    sys.B_position.y=[];
    sys.B_position.z=[];

    bi=0;
    for i=1:sys.Tnum
        for j=(i+1):sys.Tnum
            if (DistanceBtwTwoTargets(sys,i,j)<(1+eps))
                bi=bi+1;
                sys.B_relation = [sys.B_relation ; [i,j]];
                sys.B_position.x = [sys.B_position.x,(sys.T_position.x(i)+sys.T_position.x(j))/2];
                sys.B_position.y = [sys.B_position.y,(sys.T_position.y(i)+sys.T_position.y(j))/2];
                sys.B_position.z = [sys.B_position.z,(sys.T_position.z(i)+sys.T_position.z(j))/2];
            end
        end
    end
    sys.Bnum=size(sys.B_relation,1);
    sys.B=zeros(1,sys.Bnum);
    sys.B2W=zeros(1,sys.Bnum);
    
    for i=1:sys.Bnum
        for j=(i+1):sys.Bnum
            if (DistanceBtwTwoBivalents(sys,i,j)<(Wlen+eps))
                bi=bi+1;
                sys.W_relation = [sys.W_relation ; [i,j]];
            end
        end
    end
    sys.Wnum=size(sys.W_relation,1);
    sys.W=zeros(1,sys.Wnum);
end

%% Square 2D
if(type=="square2D")
        p=1;
    eps=0.1;
    sys.type="square2D";
    Num=round(Num^0.5);
    sys.WperB=WperB;
    sys.Wlen=Wlen;
    sys.Tnum=Num*Num;
    sys.T=(rand(1,sys.Tnum)>p);

    sys.T_position=struct;
    [X,Y]=meshgrid(linspace(1,1*Num,Num),linspace(1,1*Num,Num));
    sys.T_position.x=X(:);
    sys.T_position.y=Y(:);
    sys.T_position.z=zeros(1,sys.Tnum);
    
    sys.B_relation=[];
    sys.B_position=struct;
    sys.B_position.x=[];
    sys.B_position.y=[];
    sys.B_position.z=[];

    bi=0;
    for i=1:sys.Tnum
        for j=(i+1):sys.Tnum
            if(DistanceBtwTwoTargets(sys,i,j)<(1+eps))
                bi=bi+1;
                sys.B_relation = [sys.B_relation ; [i,j]];
                sys.B_position.x = [sys.B_position.x,(sys.T_position.x(i)+sys.T_position.x(j))/2];
                sys.B_position.y = [sys.B_position.y,(sys.T_position.y(i)+sys.T_position.y(j))/2];
                sys.B_position.z = [sys.B_position.z,(sys.T_position.z(i)+sys.T_position.z(j))/2];
            end
        end
    end
    sys.Bnum=size(sys.B_relation,1);
    sys.B=zeros(1,sys.Bnum);
    sys.B2W=zeros(1,sys.Bnum);
    
    for i=1:sys.Bnum
        for j=(i+1):sys.Bnum
            if(DistanceBtwTwoBivalents(sys,i,j)<Wlen+eps)
                bi=bi+1;
                sys.W_relation = [sys.W_relation ; [i,j]];
            end
        end
    end
    sys.Wnum=size(sys.W_relation,1);
    sys.W=zeros(1,sys.Wnum);
end
%% Triangular Sphere 2D
if(type=="triangularSphere2D")



    p=1;
    eps=0.1;
    sys.type="triangularSphere2D";
    sys.WperB=WperB;
    sys.Wlen=Wlen;
    sys.Tnum=Num;
    sys.T=(rand(1,sys.Tnum)>p);

        sys.T_position=struct;
    [V,Tri,~,Ue]=ParticleSampleSphere('N',Num);
    r_eff=(1*sys.Tnum/4/pi*(3^0.5/2))^0.5;
    V=r_eff*V;
    sys.T_position.x=V(:,1)';
    sys.T_position.y=V(:,2)';
    sys.T_position.z=V(:,3)';
    
    sys.B_relation=[];
    sys.B_position=struct;
    sys.B_position.x=[];
    sys.B_position.y=[];
    sys.B_position.z=[];

    bi=0;
    for i=1:sys.Tnum
        for j=(i+1):sys.Tnum
            if(DistanceBtwTwoTargets(sys,i,j)<1+eps)
                bi=bi+1;
                sys.B_relation = [sys.B_relation ; [i,j]];
                sys.B_position.x = [sys.B_position.x,(sys.T_position.x(i)+sys.T_position.x(j))/2];
                sys.B_position.y = [sys.B_position.y,(sys.T_position.y(i)+sys.T_position.y(j))/2];
                sys.B_position.z = [sys.B_position.z,(sys.T_position.z(i)+sys.T_position.z(j))/2];
            end
        end
    end
    sys.Bnum=size(sys.B_relation,1);
    sys.B=zeros(1,sys.Bnum);
    sys.B2W=zeros(1,sys.Bnum);
    
    for i=1:sys.Bnum
        for j=(i+1):sys.Bnum
            if(DistanceBtwTwoBivalents(sys,i,j)<Wlen+eps)
                bi=bi+1;
                sys.W_relation = [sys.W_relation ; [i,j]];
            end
        end
    end
    sys.Wnum=size(sys.W_relation,1);
    sys.W=zeros(1,sys.Wnum);
end
%% Cubic Sphere 2D
if(type=="cubicSphere2D")


    p=1;
    eps=0.1;
    sys.WperB=WperB;
    sys.Wlen=Wlen;
    sys.T=(rand(1,sys.Tnum)>p);
    sys.type="cubicSphere2D";
    fv=QuadCubeMesh;
    while size(fv.vertices,1)<Num
        fv=SubdivideSphericalMesh(fv,1);
    end
    sys.Tnum=size(fv.vertices,1);

    sys.T_position=struct;
    V=fv.vertices;
    r_eff=(1*sys.Tnum/4/pi)^0.5;
    V=r_eff*V;
    sys.T_position.x=V(:,1)';
    sys.T_position.y=V(:,2)';
    sys.T_position.z=V(:,3)';
    sys.B_relation=[];
    sys.B_position=struct;
    sys.B_position.x=[];
    sys.B_position.y=[];
    sys.B_position.z=[];

    bi=0;
    for i=1:sys.Tnum
        for j=(i+1):sys.Tnum
            if(DistanceBtwTwoTargets(sys,i,j)<1+eps)
                bi=bi+1;
                sys.B_relation = [sys.B_relation ; [i,j]];
                sys.B_position.x = [sys.B_position.x,(sys.T_position.x(i)+sys.T_position.x(j))/2];
                sys.B_position.y = [sys.B_position.y,(sys.T_position.y(i)+sys.T_position.y(j))/2];
                sys.B_position.z = [sys.B_position.z,(sys.T_position.z(i)+sys.T_position.z(j))/2];
            end
        end
    end
    sys.Bnum=size(sys.B_relation,1);
    sys.B=zeros(1,sys.Bnum);
    sys.B2W=zeros(1,sys.Bnum);
    
    for i=1:sys.Bnum
        for j=(i+1):sys.Bnum
            if(DistanceBtwTwoBivalents(sys,i,j)<Wlen+eps)
                bi=bi+1;
                sys.W_relation = [sys.W_relation ; [i,j]];
            end
        end
    end
    sys.Wnum=size(sys.W_relation,1);
    sys.W=zeros(1,sys.Wnum);
end
%% etc
if(type=="etc")
end

disp(sys)
end

