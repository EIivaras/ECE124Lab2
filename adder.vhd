--This file will contain the functionality of the ALU

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

signal hex_A_concat    : std_logic_vector(7 downto 0);
signal hex_B_concat    : std_logic_vector(7 downto 0);

begin 

hex_A_concat <= "0000" & hex_A;
hex_B_concat <= "0000" & hex_B;

sum <= std_logic_vector(unsigned(hex_A_concat) + unsigned(hex_B_concat));

end architecture arch4;