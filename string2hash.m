
function hash = string2hash(str, maxSize)
  str = double(str);
  hash = 5381*ones(size(str,1),1);
  for i=1:size(str,2),
    hash = mod(hash * 33 + str(:,i), maxSize) + 1;
  end
  
end
