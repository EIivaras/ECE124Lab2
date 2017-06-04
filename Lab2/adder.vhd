--This file will contain the functionality of the adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is port (
	hex_A      :  in  std_logic_vector(3 downto 0);
	hex_B      :  in  std_logic_vector(3 downto 0);
	sum        :  out std_logic_vector(7 downto 0)
);
end adder;



architecture arch4 of adder is

signal hex_A_concat    : std_logic_vector(7 downto 0); --create a signal that will hold the concatenation of hex_A with "0000"
signal hex_B_concat    : std_logic_vector(7 downto 0); --create a signal that will hold the concatenation of hex_B with "0000"

begin 

hex_A_concat <= "0000" & hex_A;
hex_B_concat <= "0000" & hex_B;

sum <= std_logic_vector(unsigned(hex_A_concat) + unsigned(hex_B_concat)); --add up the unsigned values (integer versions) of hex_A_concat and hex_B_concat, 
                                                                          --and then convert the result back to an std_logic_vector so logic operations can be carried out still

end architecture arch4;