
function result = resultingHash(hash, i, arraySize)
    result = abs(mod((hash * i), (arraySize)));
end

