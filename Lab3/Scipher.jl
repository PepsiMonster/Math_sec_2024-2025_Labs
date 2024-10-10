# Implementing gamma cipher encryption and decryption in Julia

# Define the Russian alphabet excluding 'Ё'
russian_letters = ['А','Б','В','Г','Д','Е','Ж','З','И','Й','К','Л','М',
                   'Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ',
                   'Ъ','Ы','Ь','Э','Ю','Я']

# Create mappings between letters and numbers
letter_to_num = Dict{Char, Int}()
num_to_letter = Dict{Int, Char}()

for (i, letter) in enumerate(russian_letters)
    letter_to_num[letter] = i
    num_to_letter[i] = letter
end

# Encryption function
function encrypt(plaintext::String, key::String)
    # Convert to uppercase and filter non-alphabet characters
    plaintext = filter(c -> c in russian_letters, uppercase(plaintext))
    key = filter(c -> c in russian_letters, uppercase(key))
    
    # Map letters to numbers
    plaintext_nums = [letter_to_num[c] for c in plaintext]
    key_nums = [letter_to_num[c] for c in key]
    
    # Extend key to match plaintext length
    m = length(plaintext_nums)
    key_nums_extended = [key_nums[(i-1) % length(key_nums) + 1] for i in 1:m]
    
    # Perform encryption
    cipher_nums = [(plaintext_nums[i] + key_nums_extended[i]) % 32 for i in 1:m]
    cipher_nums = [num == 0 ? 32 : num for num in cipher_nums]
    
    # Map numbers back to letters
    cipher_text = [num_to_letter[num] for num in cipher_nums]
    return join(cipher_text)
end

# Decryption function
function decrypt(ciphertext::String, key::String)
    # Convert to uppercase and filter non-alphabet characters
    ciphertext = filter(c -> c in russian_letters, uppercase(ciphertext))
    key = filter(c -> c in russian_letters, uppercase(key))
    
    # Map letters to numbers
    cipher_nums = [letter_to_num[c] for c in ciphertext]
    key_nums = [letter_to_num[c] for c in key]
    
    # Extend key to match ciphertext length
    m = length(cipher_nums)
    key_nums_extended = [key_nums[(i-1) % length(key_nums) + 1] for i in 1:m]
    
    # Perform decryption
    plaintext_nums = [(cipher_nums[i] - key_nums_extended[i]) % 32 for i in 1:m]
    plaintext_nums = [num == 0 ? 32 : num for num in plaintext_nums]
    
    # Map numbers back to letters
    plaintext = [num_to_letter[num] for num in plaintext_nums]
    return join(plaintext)
end

# Example usage
plaintext = "ПРИКАЗ"
key = "ГАММА"

ciphertext = encrypt(plaintext, key)
println("Plaintext: $plaintext")
println("Key: $key")
println("Ciphertext: $ciphertext")

decrypted_text = decrypt(ciphertext, key)
println("Decrypted text: $decrypted_text")
