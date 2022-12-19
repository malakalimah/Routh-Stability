classdef RouthCriteria
    properties
        rowz;
        itterations;
        system;

    end
    methods
        function generate_rows(obj)
            new_rows=obj.rowz;
            append_row=zeros(1,height(new_rows));
            itter= (obj.itterations)-2;
            y=width(new_rows);
            order=strings(1:obj.itterations);

            append_row=zeros(itter,width(new_rows));
           for j=1:obj.itterations  %%set the indexes of table i.e s^4 s^3 etc
                pow=j-1;
                order(j)=sym('s')^string(pow);
           end
           

           for i=1:itter  %%excute routh criteria
               try
                    for p= 1:y
                        
                           mul1=new_rows((i+1),p);
                           mul2=new_rows((i),(p+1));
                           mul3=new_rows((i),(p));
                           mul4=new_rows((i+1),(p+1));
                           num2=(mul1*mul2)-(mul3*mul4);
                           new = num2/new_rows((i+1),p);
                           append_row(i,p)=new;
                           
                    end

               catch
               append_row(i,p)=0;
               end
               %%special case when a whole row equal zeros take derivative
               %%aux
               if 1/poly2sym(append_row(i,:))==inf && i~=obj.itterations-2
                  auxillary= poly2sym(obj.rowz(end,:));
                  aux_sym = sym2poly(diff(auxillary));
                  maxlen=max(length(new_rows));
                  aux_sym(end+1:maxlen)=0;
                  append_row(i,:)=aux_sym;
               end
                %%special case when a first element is zero ,, make it
                %%epcilon
               if append_row(i,1)==0 && i~=obj.itterations-2
                  append_row(i,1)=[0.0001];
               end
               new_rows=[new_rows;append_row(i,:)];



               
           end  
           %%setup table
           index=[flip(order(1:obj.itterations))];
           Routh_table=table(transpose(index),new_rows);
           disp(Routh_table)
        %%count sign changes to check stability
            count=0;
            for k=1:height(new_rows)
                try
                    if new_rows(k,1)<0 && k~=height(new_rows) && new_rows(k+1,1)>0
                        count=count+1;

                    end
                catch 
                    if new_rows(k,1)<0 && k==height(new_rows) && new_rows(k-1,1)>0
                        count=count-1;
                    end
                end

                    
                     
                
            end
            if count>0

                fprintf("system is unstable with %d real poles",count)
            else
                fprintf("system is stable")
            end
            try
                rlocus(obj.system)
            catch
            end
        end


    end
end