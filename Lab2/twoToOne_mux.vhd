--This file will contain the functionality of the twoToOne_mux

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity twoToOne_mux is port ( --this mux will decide whether or not to push out the results of an addition or logic operation based on whether or not pb3 is pressed 
	logic	   :  in  std_logic_vector(7 downto 0);  --the 8-bit result of a logic operation on hex_A and hex_B (and/or/xor)
	addition   :  in  std_logic_vector(7 downto 0);  --the 8-bit result of an addition of hex_A and hex_B
	pb3_select :  in  std_logic;
	hex_out    :  out std_logic_vector(7 downto 0)
);
end twoToOne_mux;

architecture arch1 of twoToOne_mux is

begin 

with pb3_select select
hex_out <= logic     when '0', --if pb3 is not pressed, output the 8-bit result of the aforementioned logic operation 
		   addition  when '1'; --if pv3 is pressed, output the 8-bit result of the aforementioned addition

end architecture arch1;