--This file will contain the functionality of the ALU

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is port (
	hex_A      :  in  std_logic_vector(3 downto 0);
	hex_B      :  in  std_logic_vector(3 downto 0);
	pb_0       :  in  std_logic;
	pb_1       :  in  std_logic;
	pb_2       :  in  std_logic;
	ALU_output :  out std_logic_vector(3 downto 0)
);
end ALU;



architecture arch2 of ALU is

signal andOperation  : std_logic_vector(3 downto 0); --create a signal that will store the result of an "and" operation on hex_A and hex_B 
signal orOperation   : std_logic_vector(3 downto 0); --create -----||---------------------------------- "or" operation on hex_A and hex_B 
signal xorOperation  : std_logic_vector(3 downto 0); --create -----||---------------------------------- "xor" operation on hex_A and hex_B 

begin 
	andOperation <= hex_A and hex_B; 
	orOperation  <= hex_A or  hex_B;
	xorOperation <= hex_A xor hex_B;
    

	
	ALU_output <= andOperation when pb_0 = '1' else --if pb0 is pressed, set the output of the ALU to the "and" of hex_A and hex_B 
                  orOperation  when pb_1 = '1' else --if pb1 is pressed, set the output of the ALU to the "or" of hex_A and hex_B 
	              xorOperation when pb_2 = '1' else --if pb2 is pressed, set the output of the ALU to the "xor" of hex_A and hex_B 
				  "0000"; --if none of them are pressed, output "0000", since we don't want the LED's to show anything if none of the buttons are pressed 


end architecture arch2;