classdef AT_System
   properties
      type AT_SystemType %2D trigonal, 1D linear, etc..
      Tnum {mustBeNumeric}
      T 
      W
      T_position
      W_relation
      T2W
      WperT
   end
   methods
       function r = CalculateBindingNum(sys)
           r = sum(sys.T);
       end
       function r = CalculateBindingEfficiency(sys)
           r = sum(sys.T)/sys.Tnum;
       end
       
       function r = DistanceBtwTwoTargets(sys,i,j)
           r = sum((sys.T_position.x(i)-sys.T_position.x(j))^2+...
               (sys.T_position.y(i)-sys.T_position.y(j))^2+...
               (sys.T_position.z(i)-sys.T_position.z(j))^2)^0.5;
       end
       
       function sys = Reinitialize(sys)
           p=0.5;
           sys.T=(rand(1,sys.Tnum)>p);
           sys.W=zeros(size(sys.W));
           sys.WperT=zeros(size(sys.WperT));
       end
       
       function sys = Destroy(sys,destroy_ratio)

           wlist=find(sys.W==1);
           if ~isempty(wlist)
               for i=1:size(wlist,2)
                  if rand()<destroy_ratio
                      Ind=wlist(i);
                       sys.W(Ind)=0;
                       sys.T2W(sys.W_relation(Ind,1))=sys.T2W(sys.W_relation(Ind,1))-1;
                       sys.T2W(sys.W_relation(Ind,2))=sys.T2W(sys.W_relation(Ind,2))-1;
                  end
               end
           end
       end
       
       function r= Visualize(sys)
           figure()
           colorindex=(sys.T'*[0,0,1]+(1-sys.T')*[0.7,0.7,0.7]);
           scatter3(sys.T_position.x,sys.T_position.y,sys.T_position.z,10,colorindex,'filled');
           hold on;
           wlist=find(sys.W==1);
           if ~isempty(wlist)
               for i=1:size(wlist,2)
                   x=[sys.T_position.x(sys.W_relation(wlist(i),1)),sys.T_position.x(sys.W_relation(wlist(i),2))];
                   y=[sys.T_position.y(sys.W_relation(wlist(i),1)),sys.T_position.y(sys.W_relation(wlist(i),2))];
                   z=[sys.T_position.z(sys.W_relation(wlist(i),1)),sys.T_position.z(sys.W_relation(wlist(i),2))];
                   line(x,y,z);
                   hold on;
               end
           end
           
           
       end
      

   end
end
