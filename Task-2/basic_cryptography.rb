require "openssl"
require "digest"
require "base64"

$row_hash = {
    "A" => ["p","h","q","g","m", "+", "J", "L"],
    "B" => ["e","a","y","l","n", "1", "W", "X"],
    "C" => ["o","-","d","x","k", "2", "Y", "="],
    "D" => ["r","c","v","s","z", "3", "f", "D"],
    'E' => ["w","b","u","t","i", "4", "S", "Z"],
    "F" => ["5","6","7","8","9", "0", "N", "T"],
    "G" => ["A","B","C","E","F", "G", "H", "I"],
    "H" => ["K","M","O","P","Q", "R", "U", "V"]
}

$col_hash = {
    "A" => ["p", "e", "o", "r", "w", "5", "A", "K"],
    "B" => ["h", "a", "-", "c", "b", "6", "B", "X"],
    "C" => ["q", "y", "d", "v", "u", "7", "C", "O"],
    "D" => ["g", "l", "x", "s", "t", "8", "E", "P"],
    "E" => ["m", "n", "k", "z", "i", "9", "F", "Q"],
    "F" => ["+", "1", "2", "3", "4", "0", "G", "R"],
    "G" => ["J", "W", "Y", "f", "S", "N", "H", "U"],
    "H" => ["L", "X", "=", "D", "Z", "T", "I", "V"]
}

$encoded_text = "BHFCCBEGEFFAECGFEDFHEBDBFAAHEHECEAFDHDADEHHHBGHEFBGBGFCBABGHHDEGDECADCFFGGDFBEEDFDAFDGHC"
decrypted_text = []

def polybius
  decrypted_text = []
    $encoded_text.scan(/../).each do |l|
      l.split(//)
        array = $row_hash["#{l[0]}"] + $col_hash["#{l[1]}"]
          decrypted_text.push(array.detect{ |e| array.count(e) > 1 })
    end
      puts decrypted_text.join('')
  return decrypted_text.join('')
end

def aes256_decrypt(key, data)
  key = Digest::SHA256.digest(key) if(key.kind_of?(String) && 32 != key.bytesize)
    aes = OpenSSL::Cipher.new('AES-256-CBC')
      aes.decrypt
        aes.key = Digest::SHA256.digest(key)
          aes.update(data) + aes.final
end

def base64_decrypt(text)
  original = Base64.decode64(text)
  return original
end

def start
  first_decryption = polybius
  second_decryption = aes256_decrypt(key, first_decryption)
  base64_decrypt(second_decryption)
end

start
