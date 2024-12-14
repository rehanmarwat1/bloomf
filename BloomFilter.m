function obj = BloomFilter(n, k)
  
%first param: size, second param: # of hash functions

fprintf(1, '\nCreating BloomFilter...\n');
            
%   if (nargin == 2)
%     if (k <= 0 || n <= 0)
%       error("The numbers must be over zero!");
%       fprintf(1, '\nExiting...\n');
%       exit
%     end
                
    obj.k = k;
    obj.size = n;
    obj.array = zeros(1,n,'uint8');
    obj.elementsAdded = 0;

                  
    %# Shows basic information about the Bloom Filter created
    fprintf(1, '\nBloomFilter sucessfully created.\n\tSize -> %d\n\tNumber of Hash Functions ->%d\n \tNumber of check bits ->%d\n\n', n, k);
%  else
    %# No values for n nor k, display error and exit
%    error("Please assign values to BF object!");
%    fprintf(1, '\n\tExample: BF = BloomFilter(100,2);\nExiting...\n');
%    exit
  %end
end    
