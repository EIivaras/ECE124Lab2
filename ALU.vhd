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

signal andOperation  : std_logic_vector(3 downto 0);
signal orOperation   : std_logic_vector(3 downto 0);
signal xorOperation  : std_logic_vector(3 downto 0);

begin 
	andOperation <= hex_A and hex_B;
	orOperation  <= hex_A or  hex_B;
	xorOperation <= hex_A xor hex_B;

	
	ALU_output <= andOperation when pb_0 = '1' else
                  orOperation  when pb_1 = '1' else
	              xorOperation when pb_2 = '1';


end architecture arch2;