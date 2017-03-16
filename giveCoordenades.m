function output = giveCoordenades(img_resul,col,i,j, vectorN, naoMarcados, marcados )
%CHECKPOSITION Summary of this function goes here
%   Detailed explanation goes here
               

           for t =1: numel(col)
               
            if strcmp(vectorN(col(t)),'cl')
                if (img_resul(i,j-1).family==-1)
                    naoMarcados = [naoMarcados col(t)]; 
                else
                    marcados = [marcados col(t)];
                end
            end
          
            if  strcmp(vectorN(col(t)),'cddl')
                if (img_resul(i+1,j-1).family==-1)
                    naoMarcados = [naoMarcados col(t)]; 
                else
                    marcados = [marcados col(t)];
                end
            end
            if strcmp(vectorN(col(t)),'cd')
                if (img_resul(i+1,j).family==-1)
                    naoMarcados = [naoMarcados col(t)]; 
                else
                    marcados = [marcados col(t)];
                end
            end
            if strcmp(vectorN(col(t)),'cddr')
                if (img_resul(i+1,j+1).family==-1)
                    naoMarcados = [naoMarcados col(t)]; 
                else
                    marcados = [marcados col(t)];
                end
            end
            if strcmp(vectorN(col(t)),'cr')
                if (img_resul(i,j+1).family==-1)
                    naoMarcados = [naoMarcados col(t)]; 
                else
                    marcados = [marcados col(t)];
                end
            end
            
            if strcmp(vectorN(col(t)),'cdur')
                if (img_resul(i-1,j+1).family==-1)
                    naoMarcados = [naoMarcados col(t)]; 
                else
                    marcados = [marcados col(t)];
                end
            end
            if strcmp(vectorN(col(t)),'cu')
                if (img_resul(i-1,j).family==-1)
                    naoMarcados = [naoMarcados col(t)]; 
                else
                    marcados = [marcados col(t)];
                end
            end
            
           end
           
           output = [naoMarcados marcados];
end

