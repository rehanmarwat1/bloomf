function [checkbits_array,outputArg2] = check_presence(convert_table_to_Array, current_item_index,num_check_bits,checkbit_offset,checkbit_position,chkenabled,num_of_hashfunctions)
    
    number_of_data_elements=size(convert_table_to_Array,1)%rows in data

    for i=1:number_of_data_elements %%%%read number of elements and add them to bloom filter
        if(current_item_index~=i)%%%do not check with the current item
            text=convert_table_to_Array{i,1};
        %%%%%%%%cacluate checkbits and add them to checkbits array
            binary_value_of_text = dec2bin(text);%convert text to binary
            dec_sum_of_binary_values=sum(sum(binary_value_of_text))%add all binary values
            binary_of_sum=(dec2bin(dec_sum_of_binary_values));%again convert the sum of binary values to a binary value
            middle=uint8(size(binary_of_sum,2)/2)%go to the middle part of the binary value of the sum (in the form of binary)
            left50=middle/2;%take bits from the middle of the left of 50%
            right50=middle+left50;%take bits from the middle of the right of 50%
            if (checkbit_position=='middle')
                checkbit_starting_position=middle;
            elseif(checkbit_position=='left50')
                checkbit_starting_position=left50;
            elseif (checkbit_position=='right50')
                checkbit_starting_position=right50;
            end
            for num_of_check_bit = 1:num_check_bits
                is_even = rem(num_of_check_bit, 2) == 0%check if number is even or not
                if ~(is_even)%if odd number, then take left bit
                    checkbits_array(1,num_of_check_bit)=str2num(binary_of_sum(checkbit_starting_position-checkbit_offset-num_of_check_bit));
                else%if even number, then take left bit
                    checkbits_array(1,num_of_check_bit)=str2num(binary_of_sum(checkbit_starting_position+checkbit_offset+num_of_check_bit));
                end                      
            end
        %%%%%%%%cacluate checkbits and add them to checkbits array
        end
    end




end

