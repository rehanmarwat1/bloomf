
function obj = insert(bf, elem, checkbits_array)
  hash = string2hash(elem, bf.size);
  for i = 1 : bf.k
      %trying with custom hash functions
      idx = resultingHash(hash, i, bf.size);

      %idx=abs(mod((elem * i), (bf.size)))
      
%     string = elem; 
%     sha256hasher = System.Security.Cryptography.SHA256Managed;
%     sha256 = uint8(sha256hasher.ComputeHash(uint8(string)));
%     dec2hex(sha256)
    if (idx==0)
        idx=1;
    end
    
    bf.array(idx) = true;
  end
  
 
  for num_of_check_bit = 1:size(checkbits_array,2)%total values in checkbits array
    bf.checkbits_array(num_of_check_bit)=checkbits_array(num_of_check_bit)
  end
  
  bf.elementsAdded = bf.elementsAdded + 1;
  fprintf(1, '\n"%s" successfully inserted into BloomFilter.\n\tNum of Elements -> %d\n', elem, bf.elementsAdded);
  obj = bf;
  
  end
