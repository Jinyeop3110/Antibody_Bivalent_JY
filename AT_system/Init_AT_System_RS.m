function sys = Init_AT_System_RS(type, L, density, WperB, Wlen)

% RandomSurface AT system initiation , Jul-20-2020

%   Copyright 2020 Jinyeop Song.

sys=AT_System;

%% randomUniformFlat2D
if(type=="randomUniformFlat2D")

    sys.type="randomUniformFlat2D";
    p=1;
    eps=0.05;
    sys.WperB=WperB;
    sys.Wlen=Wlen;
    sys.Tnum=floor((L)*density);
    sys.T=(rand(1,sys.Tnum)>p);

    sys.T_position=struct;
    sys.T_position.x=(L^0.5)*rand(sys.Tnum,1);
    sys.T_position.y=(L^0.5)*rand(sys.Tnum,1);
    sys.T_position.z=zeros(sys.Tnum,1);
    
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

%% randomUniformSphere2D
if(type=="randomUniformSphere2D")

    
    
    
    sys.type="randomUniformSphere2D";
    p=1;
    eps=0.05;
    sys.WperB=WperB;
    sys.Wlen=Wlen;
    sys.Tnum=floor((L)*density);
    sys.T=(rand(1,sys.Tnum)>p);

    sys.T_position=struct;
    theta=acos(1-2*rand(sys.Tnum,1));
    phi=2*3.141592*rand(sys.Tnum,1);
    radius=(L/4/3.141592)^0.5;
    sys.T_position.x=radius*sin(theta).*cos(phi);
    sys.T_position.y=radius*sin(theta).*sin(phi);
    sys.T_position.z=radius*cos(theta);
    
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

%% randomQuasiFlat2D
if(type=="randomQuasiFlat2D")
    p=1;
    eps=0.05;
    sys.type="randomQuasiFlat2D";    
    sys.WperB=WperB;
    sys.Wlen=Wlen;
    sys.Tnum=floor((L)*density);
    sys.T=(rand(1,sys.Tnum)>p);
    sys.T_position=struct;
    
    p = haltonset(2,'Skip',1e3,'Leap',1e2);
    p = scramble(p,'RR2');
    X0 = net(p,sys.Tnum);

    sys.T_position.x=(L^0.5)*X0(:,1);
    sys.T_position.y=(L^0.5)*X0(:,2);
    sys.T_position.z=zeros(sys.Tnum,1);
    

    
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
            if DistanceBtwTwoBivalents(sys,i,j)<(Wlen+eps)
                disp(Wlen)
                disp(DistanceBtwTwoBivalents(sys,i,j))
                bi=bi+1;
                sys.W_relation = [sys.W_relation ; [i,j]];
            end
        end
    end
    sys.Wnum=size(sys.W_relation,1);
    sys.W=zeros(1,sys.Wnum);
end

%% randomQuasiSphere2D
if(type=="randomQuasiSphere2D")
    eps=0.05;
    p=1;
    sys.type="randomQuasiSphere2D";
    sys.WperB=WperB;
    sys.Tnum=floor((L)*density);
    sys.T=(rand(1,sys.Tnum)>p);
    sys.T_position=struct;
    
    p = haltonset(2,'Skip',1e3,'Leap',1e2);
    p = scramble(p,'RR2');
    X0 = net(p,sys.Tnum);

    sys.T_position.x=(L^0.5)*X0(:,1);
    
    theta=acos(1-2*X0(:,1));
    phi=2*3.141592*X0(:,2);
    radius=(L/4/3.141592)^0.5;
    sys.T_position.x=radius*sin(theta).*cos(phi);
    sys.T_position.y=radius*sin(theta).*sin(phi);
    sys.T_position.z=radius*cos(theta);
    
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
