# Routh–Hurwitz stability criterion
## Over View

This respiratory contains a MATLAB code that includes a main program and RouthCriteria class, this program takes input from user (transfer function) then extract the numerator and denominator polynomials  and apply Routh criteria to examine stability. 
## File Navigation

In "routh_proj.mlx" user will give the inputs and run the code lines then "RouthCriteria.m" class will be called that carries the logic.
Also this analysis carries special cases of routh criteria.

## Main logic



for *i* is row index and *p* is column index of our routh matrix(table) without appending the new rows

the new row in matrix of index *m* where m as counter of new rows indecies will have value starts from *i* and cosiquently will have elements of index (*i*,*p*) or (*m*,*p*) where index (*m*,*p*) carries value equals to values strored in following indecies in our matrix ( ( (i+1,p) * (i,p+1) ) - ( (i,p) * (i+1,p+1))) / (i,p)



As shown in the code

```
           

           for i=1:itter  %%excute routh criteria , itter is order of charactaristic equation minus 2
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
```

## Output

You can expect output to be routh table and a line that tells whether the system is stable or not and the number of real poles also a graph of the system root locus.


Note that the equation evaluated in following figure is of special case where whole row is zeros


![Capture](https://user-images.githubusercontent.com/70919728/208780396-5aa092ec-3e20-42e4-be7b-d49fb68868c4.PNG)



