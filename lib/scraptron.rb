class Scrapatron

  def hashbuilder(keys, value)
# This function return a hash , it tooks values from between of keys
    keys.each_with_index do |key, index|
      data = Hash.new()
      if index+1 < keys.size
        x = value.text.index(keys[index])+keys[index].length
        y = value.text.index(keys[index+1])
        val = value.text[x..y-1]
        data[key.strip] = val.strip
      else
        x = value.text.index(keys[index])+keys[index].length
        y = value.text.length
        val = value.text[x..y-1]
        data[key] = val
      end

    end
    return data
  end

  def getLinksBySelector(selector)
    all(selector).map { |v| v[:href] }
  end

  def makeArrayOfString(array)
   array=array.map { |k|  k.text }
  end

  def nestedArrayItteration(a)
    a.each_pair do |k1, v1|
      puts "======== key: #{k1}, value: ========"

      if v1.class == Hash
        v1.each_pair do |k2, v2|
          puts "key_2: #{k2}, value: #{v2}"
        end
      else
        v1.each do |h|
          h.each_pair do |k2, v2|
            puts "hash #{v1.index(h)} => key_2: #{k2}, value: #{v2}"
          end
        end
      end
    end
  end

end