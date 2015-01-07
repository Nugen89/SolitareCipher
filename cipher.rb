class Cipher

  attr_accessor :deck

  def initialize
    @deck = Deck.new
  end

  def self.encrypt(input)
    sanitized_input = self.sanitize_input(input)
    key_stream = self.gen_keystream
    numStream1 = self.to_numberstream(sanitized_input)
    numStream2 = self.to_numberstream(key_stream)

    self.to_letterstream(self.sum_arrays(numStream1, numStream2))
  end

  def self.decrypt(input)
    key_stream = self.gen_keystream
    numStream1 = self.to_numberstream(input)
    numStream2 = self.to_numberstream(key_stream)

    self.to_letterstream(self.subtract_arrays(numStream1, numStream2))
  end

  def self.sanitize_input(string)
    sanitized_string = string.upcase.gsub(/[^A-Z]/i, '').scan(/.{1,5}/)
    sanitized_string << pad_X_string(sanitized_string.pop)
    sanitized_string.join(" ")
  end

  def self.pad_X_string(string)
    string << ("X" * (5 - string.length))
  end

  def self.gen_keystream
    # Deck.new.keystream
    "DWJXH YRFDG TMSHP UURXJ"
  end

  def self.to_numberstream(string)
    string.scan(/.{1}/).map do |letter|
      letter.ord - 64 unless (letter.ord-64 == -32)
    end.join(" ")
  end

  def self.to_letterstream(string)
    letterstream = string.split(" ").map do |number|
      (number.to_i + 64).chr
    end.join(" ")
    sanitize_input(letterstream)
  end


  def self.sum_arrays(a1, a2)
    a1 = a1.split(" ")
    a2 = a2.split(" ")
    sum_array = [a1,a2].transpose.map { |e| e.reduce(0){|s,v| s.to_i + v.to_i } }
    sum_array.each_with_index.map do |e, i|
      sum = (e < 26 ? e : e - 26).to_s
      sum << " " if (i%5 == 4)
      sum
    end.join(" ").strip
  end

  def self.subtract_arrays(a1, a2)
    a1 = a1.split(" ")
    a2 = a2.split(" ")
    sum_array = [a1,a2].transpose.map { |e| e[0].to_i - e[1].to_i }
    sum_array.each_with_index.map do |e, i|
      sum = (e > 0 ? e : e + 26).to_s
      sum << " " if (i%5 == 4)
      sum
    end.join(" ").strip
  end

end  


# sum_array.each_slice(5).to_a
