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
	ALU_output :  out std_logic_vector(3 downto 0);
);
end ALU;



architecture arch2 of ALU is

begin 




end architecture arch2;