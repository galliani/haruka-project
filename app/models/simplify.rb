class Simplify
  
  def begin_flatten(arr)
  	if arr.kind_of?(Array)
  	  array_flattening(arr, [])
  	else
  	  puts "not an array, case closed"
  	end
  end

  def array_flattening(arr, bottle)
  	arr.each do |a|
  	  if a.kind_of?(Array) #check if the element is array
  	  	array_flattening(a, bottle) #put the element to be flatten again until single
  	  else
  	  	bottle.push(a)
  	  end
  	end

  	result = bottle
  end

end