package arrayTypes is
   type charArray is array(Integer range <>) of Character;
   type stringArray is array(Integer range <>) of charArray(1..10);
   type intArray is array(Integer range <>) of Integer;
end arrayTypes;
