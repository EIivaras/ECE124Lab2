--This file will contain the functionality of the twoToOne_mux

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity twoToOne_mux is port (
	hex_in	   :  in  std_logic_vector(7 downto 0);
	sum        :  in  std_logic_vector(7 downto 0);
	pb3_select :  in  std_logic;
	hex_out    :  out std_logic_vector(7 downto 0);
);
end twoToOne_mux;

architecture arch1 of twoToOne_mux is

begin 




end architecture arch1;