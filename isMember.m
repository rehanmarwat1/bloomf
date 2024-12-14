
function is_probably_present = isMember(bf, elem,checkbits_array,chkenabled)
  hash = string2hash(elem, bf.size);
  checkbits_matching_count=0;
  matching=0;
  for i = 1 : bf.k
    idx = resultingHash(hash, i, bf.size);
    if (idx==0)
        idx=1;
    end
    
    if(bf.array(idx))
        matching = matching+1;
    end
    
  end
  %%%%%%%%now check how many matchings have been registered. If it is same
  %%%%%%%%as the number of hashfunctions, this means, probably the item is
  %%%%%%%%already in the bloom filter
      if (matching==bf.k)
          %since matching are equal to number of hash functions, thus, before flagging item as already present, check
          %for enabled checkbits if already enabled
          %%%Now check if all checkbits match
        if (chkenabled) 
            %%%see if all checkbits match
            for num_of_check_bit = 1:size(checkbits_array,2)%total values in checkbits array
                if(bf.checkbits_array(num_of_check_bit)==checkbits(num_of_check_bit))
                    checkbits_matching_count=checkbits_matching_count+1;
                end
            end
            
            if (checkbits_matching_count==size(checkbits_array,2))%%%if number of matchings matching is exactly same as the number of checkbits, then the item is present
                is_probably_present=true;
            else%%%if number of matchings is not exactly same as the number of checkbits, then the item is not present
                is_probably_present=false;
            end
            %%%Now check if all checkbits match
            
        else% if checkbits are not enabled, thus send flag that the item is matching 
            is_probably_present=true;
        end
      else%%% send flag that item is not matching
        is_probably_present=false;
      end
  %%%%%%%%now check how many matchings have been registered. If it is same
  %%%%%%%%as the number of hashfunctions, this means, probably the item is
  %%%%%%%%already in the bloom filter
end
  

