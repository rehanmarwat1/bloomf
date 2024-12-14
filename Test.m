

%checkbits=BloomFilter(10000,3);
%Table = readtable('sample_1000.csv');
%Array = table2array(Table(:,1))
%%%%%%image to hash: https://www.mathworks.com/matlabcentral/answers/504847-generate-hash-value-of-images-in-matlab
%%for processing text, use the following module
%%G:\R&D Faculty\Rehan\Synchronize apps\GoogleDrive\1. R_&_D\1.PROJECTS_QU\1. ACTIVE_PRJ\2021 dr suleman big data\code\my implementation\AnalyzeTextDataUsingTopicModelsExample\AnalyzeTextDataUsingTopicModelsExample.mlx


%use global features to extract global features and used as hash values
%calculate the checkbits from the category by finding the category of the image



global hashvalue
load data_batch_2.mat
load batches.meta.mat
%image dataset: https://www.cs.toronto.edu/~kriz/cifar.html
%image hash: https://www.mathworks.com/matlabcentral/fileexchange/45038-generate-digital-signature-of-images

%%%%%%%%%%settings
execute_faster=true
faster_img_rows=2
faster_img_columns=2

use_only_caption=false
use_only_hash=false
append_caption_in_beginning=false
append_caption_begin_plus_end=true
append_caption_in_end=false

num_check_bits=3;%should be taken even number due to left are right movements in the binary sum array
chkenabled=true;
image_chkenabled=true;
checkbit_offest=1;
random_checkbits=false
size_of_bf=500;
num_of_hashfunctions=3;
if (random_checkbits)
    checkbit_position=randperm(3,3);%middle 1/left50 2/right50 3. From which three positions, the check bits will be accumulated. (middle,left50%, right50%)
else
    checkbit_position=1;%middle 1/left50 2/right50 3. From which three positions, the check bits will be accumulated. (middle,left50%, right50%)
end
%%%%%%%%%%settings


%read_data_in_form_of_table = readtable('corpus_small.csv');
processed_text='processed_tweets.csv';%processed throught text anlaysis in matlab
un_processed_text='Twitter_Processed_Without_Class.csv'%pure original text without any processing done
read_data_in_form_of_table = readtable(un_processed_text);
convert_table_to_Array = table2array(read_data_in_form_of_table(:,1));
number_of_data_elements=size(convert_table_to_Array,1)%rows in data

tic
%%%%%%%%%%%%%%check bits related variables
    checkbits_array=zeros(number_of_data_elements,num_check_bits,'uint8');%extra array for checkbits with each value of bloom filter
    size_based_checkbits=false;%set it to true if the checkbits desired are to be made by size of the content
%%%%%%%%%%%%%%check bits related variables

%%%%%%%%%%%%%%bloom filter presets

    bloomfilter=BloomFilter(size_of_bf,num_of_hashfunctions);%first param: size, second param: # of hash functions, 3rd param: # of checkbits
    bloom_filter_items_array=zeros(number_of_data_elements,num_of_hashfunctions,'uint8');%extra array for checkbits with each value of bloom filter
%%%%%%%%%%%%%%bloom filter presets

%%%%%%%%%counter reset for false positives
    falsepositives_with_out_checkbits=0;
    falsepositives_with_checkbits=0;
%%%%%%%%%counter reset for false positives

for element_number=1:1000 %1:number_of_data_elements-0     %440 %%%%read number of elements and add them to bloom filter
    %%%%%%%%%read text from data
        %text=Array{i,1}; for numeric only
        element_number
        falsepositives_with_checkbits
        falsepositives_with_out_checkbits
%         text=convert_table_to_Array{element_number,1};
%         size_of_content=size(text,2);
        
        image_from_cifar=(reshape(data(element_number, 1:3072), [32,32,3]));   % get 3-channel RGB image
        image_from_cifar = permute(image_from_cifar, [2 1 3]);
        if execute_faster==true
            image_from_cifar=imresize(image_from_cifar,[faster_img_rows faster_img_columns]);
            hash_of_image=image_hash(faster_img_rows,faster_img_columns,"SHA224",image_from_cifar);

        else
        %imshow(image_from_cifar);
            hash_of_image=image_hash(32,32,"SHA224",image_from_cifar);
        end
        label_number_of_image=labels(element_number);
        label_name_of_image=label_names(label_number_of_image+1);%labels start from 0 till 9
        text=label_name_of_image{:};
        
        
        if use_only_caption==true%use only caption to generate checkbits
            text=text;%use only caption
        end
        if use_only_hash==true %use only hash to generate checkbits
            text=hash_of_image
        end       
        if append_caption_in_beginning==true
            text=strcat(text,hash_of_image);
        end
        if append_caption_begin_plus_end==true
            text=strcat(text,hash_of_image,text);%combine caption and hash to generate checkbits
        end
        if append_caption_in_end==true
            text=strcat(hash_of_image,text);%combine caption and hash to generate checkbits
        end

        
        %using_strrep = strrep(text, '"', '1')
    %%%%%%%%%read text from data

    %%%%%%%%cacluate checkbits and add them to checkbits array
        if size_based_checkbits
            binary_value_of_text = dec2bin(size_of_content);%convert text to binary
            binary_of_sum=binary_value_of_text;
        else
            binary_value_of_text = text2bin(text);%convert text to binary
            %[binV, binS] = text2bin(text)
            dec_sum_of_binary_values=sum(sum(binary_value_of_text));%add all binary values
            binary_of_sum=(dec2bin(dec_sum_of_binary_values));%again convert the sum of binary values to a binary value
        end
        
        middle=uint8(size(binary_of_sum,2)/2);%go to the middle part of the binary value of the sum (in the form of binary)
        left50=middle/2;%take bits from the middle of the left of 50%
        right50=middle+left50;%take bits from the middle of the right of 50%
        
        if (random_checkbits)
            checkbit_position=randperm(3,1);%middle 1/left50 2/right50 3. From which three positions, the check bits will be accumulated. (middle,left50%, right50%)
        end
            
        if (checkbit_position==1)%middle
            checkbit_starting_position=middle;
        elseif(checkbit_position==2)%left
            checkbit_starting_position=left50;
        elseif (checkbit_position==3)%right
            checkbit_starting_position=right50;
        end
        increment_checkbit=0;
        for num_of_check_bit = 1:num_check_bits
            %is_even = rem(num_of_check_bit, 2) == 0%check if number is even or not
            checkbits_array(element_number,num_of_check_bit)=str2num(binary_of_sum(checkbit_starting_position+increment_checkbit));
            increment_checkbit=increment_checkbit+checkbit_offest;
        end
    %%%%%%%%cacluate checkbits and add them to checkbits array
    
    %%%%%%%%check if already in bloom filter
        hash = string2hash(text, bloomfilter.size);
        matching=0;
        element_already_present=false;
        for i = 1 : bloomfilter.k
            idx = resultingHash(hash, i, bloomfilter.size);
            if (idx==0)
                idx=1;
            end
            if(bloomfilter.array(idx))
                matching = matching+1;
                hash_of_last_element(1,i)=idx;
            end
        end
        if (matching==bloomfilter.k)
            falsepositives_with_out_checkbits=falsepositives_with_out_checkbits+1
            element_already_present=true;
        end
        %%%%Till this point, we have confirmed that similar item or
        %%%%non-simiilar item but with similar hash output is present in
        %%%%bloom filter
        %%%%Now, if checkbits enabled, we need to check whether the
        %%%%checkbits are also similar, if similar then this means that
        %%%%ideally, the matching is due to similar duplicate addition
        %%%%(probably)
        if (element_already_present)
            if(chkenabled)
                indeces_of_matching_hash=ismember(bloom_filter_items_array,hash_of_last_element(1,:),'rows');%find if hash ouput of last element is same as already present hashes outputs in array
                extract_row_number_of_matching_hash=find(indeces_of_matching_hash==1);%once similar hashes are there, find the row numbers of the matching hash values
                checkbit_pattern=checkbits_array(extract_row_number_of_matching_hash,:);%extract the chkbits of the elements of the matching hashes
                %%%%%%now try to match the previous checkbit patterns with
                %%%%%%the current element checkbits
                matching_pattern=ismember(checkbit_pattern,checkbits_array(element_number,:),'rows');
                if (find(matching_pattern==1))%checkbits have matched to at least one entry in similar hash output elements
                    falsepositives_with_checkbits=falsepositives_with_checkbits+1
                end
            end           
        end
    %%%%%%%%check if already in bloom filter
    
    %%%%%%%%%%%%%%%%inserting into bloom filter
    hash = string2hash(text, bloomfilter.size);
      for i = 1 : bloomfilter.k
          idx = resultingHash(hash, i, bloomfilter.size);
        if (idx==0)
            idx=1;
        end
        bloomfilter.array(idx) = true;
        bloom_filter_items_array(element_number,i)=idx;%%%save position of the 1s in bloom filter array
      end
    bloomfilter.elementsAdded = bloomfilter.elementsAdded + 1;
    %%%%%%%%%%%%%%%%inserting into bloom filter 

end

falsepositives_with_checkbits
falsepositives_with_out_checkbits
toc