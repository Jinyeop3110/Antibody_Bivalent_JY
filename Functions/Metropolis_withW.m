function sys = Metropolis_withW(sys, Kd1, Kd2, Kd2_eff, pA)
numIters = 2^10 * numel(sys.Tnum);

p_iter2=ceil(size(sys.W_relation,1)/sys.Tnum);
p1=min(pA/Kd1,1);
p2=min(Kd1/pA,1);
p3=min(1/Kd2_eff,1);
p4=min(Kd2_eff,1);
for iter1 = 1 : numIters
    % Pick a random target
    Ind = randi(sys.Bnum);
    % convert target
    if sys.B(Ind)==0
        if sys.T(sys.B_relation(Ind,1))==0 & sys.T(sys.B_relation(Ind,2))==0
            if rand()<p1
                sys.B(Ind)=1;
                sys.T(sys.B_relation(Ind,1))=1;
                sys.T(sys.B_relation(Ind,2))=1;
                %sys.T2B(sys.B_relation(Ind,1))=Ind;
                %sys.T2B(sys.B_relation(Ind,2))=Ind;
            end
        end
    elseif sys.B(Ind)==1
        if sys.B2W(Ind)==0
            if rand()<p2
                sys.B(Ind)=0;
                sys.T(sys.B_relation(Ind,1))=0;
                sys.T(sys.B_relation(Ind,2))=0;
                %sys.T2B(sys.B_relation(Ind,1))=0;
                %sys.T2B(sys.B_relation(Ind,2))=0;
            end
        end
    end
    
    b = find(sys.B>0);
    if ~isempty(b)
        
        BInd1=b(randi(size(b)));
        [bi,wi] = NearBivalent(sys,BInd1);
        for Iter2 = 1: p_iter2
            if isempty(bi)
               break; 
            end
            Ind=randi(size(bi,1));
            BInd2=bi(Ind);
            WInd=wi(Ind);
            if sys.B(BInd2)==1
                if sys.W(WInd)==0 & sys.B2W(BInd1)<sys.WperB & sys.B2W(BInd2)<sys.WperB
                    if rand()<p3
                        sys.W(WInd)=1;
                        sys.B2W(BInd1)=sys.B2W(BInd1)+1;
                        sys.B2W(BInd2)=sys.B2W(BInd2)+1;
                    end
                elseif sys.W(WInd)==1
                    if rand()<p4
                        sys.W(WInd)=0;
                        sys.B2W(BInd1)=sys.B2W(BInd1)-1;
                        sys.B2W(BInd2)=sys.B2W(BInd2)-1;
                    end
                end
            end
        end
        
        
        
    end
    
    
    
    
    
    
end
