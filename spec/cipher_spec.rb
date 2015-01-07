require_relative '../cipher'

describe Cipher do

  describe "Input" do
    it "should split and capitalise input string" do
      expect(Cipher.sanitize_input("Code in Ruby, live longer!")).to eq("CODEI NRUBY LIVEL ONGER")
    end

    it "should split and capitalise input string" do
      expect(Cipher.sanitize_input("113right, #42 Here RiGht Now.!~!")).to eq("RIGHT HERER IGHTN OWXXX")
    end

    describe "Pad X string" do
      it "should split and capitalise input string" do
        expect(Cipher.pad_X_string("ABC")).to eq("ABCXX")
      end     
    end

    describe "to number code" do
      it "should convert letters to numbers" do
        expect(Cipher.to_numberstream("CODEI NRUBY LIVEL ONGER")).to eq("3 15 4 5 9  14 18 21 2 25  12 9 22 5 12  15 14 7 5 18")
      end

      it "should convert numbers to letters" do
        expect(Cipher.to_letterstream("7 12 14 3 17  13 10 1 6 6  6 22 15 13 2  10 9 25 3 2")).to eq("GLNCQ MJAFF FVOMB JIYCB")
      end

      it "should convert numbers to letters" do
        expect(Cipher.to_letterstream("3 15 4 5 9  14 18 21 2 25  12 9 22 5 12  15 14 7 5 18")).to eq("CODEI NRUBY LIVEL ONGER")
      end
    end

    describe "number streams" do
      it "add" do
        l1 = "3 15 4 5 9  14 18 21 2 25  12 9 22 5 12  15 14 7 5 18"
        l2 = "4 23 10 24 8  25 18 6 4 7  20 13 19 8 16  21 21 18 24 10"
        result = "7 12 14 3 17  13 10 1 6 6  6 22 15 13 2  10 9 25 3 2"
        expect(Cipher.sum_arrays(l1, l2)).to eq(result)
      end

      it "subtract" do
        l1 = "7 12 14 3 17  13 10 1 6 6  6 22 15 13 2  10 9 25 3 2"
        l2 = "4 23 10 24 8  25 18 6 4 7  20 13 19 8 16  21 21 18 24 10"
        result = "3 15 4 5 9  14 18 21 2 25  12 9 22 5 12  15 14 7 5 18"
        expect(Cipher.subtract_arrays(l1, l2)).to eq(result)
      end
    end
  end

  describe "Encryption" do
    it "encrypt input stream" do
      expect(Cipher.encrypt("Code in Ruby, live longer!")).to eq("GLNCQ MJAFF FVOMB JIYCB")
    end
    
  end

  describe "Decryption" do
    it "decrypt input stream" do
      expect(Cipher.decrypt("GLNCQ MJAFF FVOMB JIYCB")).to eq("CODEI NRUBY LIVEL ONGER")
    end

    it "decrypt input stream" do
      expect(Cipher.decrypt("CLEPK HHNIY CFPWH FDFEH")).to eq("YOURC IPHER ISWOR KINGX")
    end
      
    it "decrypt input stream" do
      expect(Cipher.decrypt("ABVAW LWZSY OORYK DUPVH")).to eq("WELCO METOR UBYQU IZXXX")
    end    
  end

end