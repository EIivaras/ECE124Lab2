--This file will contain the functionality of the led drivers

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity leds_drivers is port (
	leds_in     : in   std_logic_vector(7 downto 0);
	led7_out    : out  std_logic;
	led6_out    : out  std_logic;
	led5_out    : out  std_logic;
	led4_out    : out  std_logic;
	led3_out    : out  std_logic;
	led2_out    : out  std_logic;
	led1_out    : out  std_logic;
	led0_out    : out  std_logic
);
end leds_drivers;

architecture arch3 of leds_drivers is

begin 

 led7_out <= leds_in(7);
 led6_out <= leds_in(6);
 led5_out <= leds_in(5);
 led4_out <= leds_in(4);
 led3_out <= leds_in(3);
 led2_out <= leds_in(2);
 led1_out <= leds_in(1);
 led0_out <= leds_in(0);

end architecture arch3;