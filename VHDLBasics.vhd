--1.0 VHDL Basics 

--VHDL stands for VHSIC (Very High Speed Integrated Circuit) Hardware Description Language
--It is one of the two languages used by education and business to design FPGAs (Field Programmable Gate Arrays) and ASICs (Application Specific Integrated Circuits), both of which you can learn about here: https://www.nandland.com/articles/what-is-an-fpga-what-is-an-asic.html
--VHDL and Verilog are the two languages digital designers use to describe their circuits, and they are different by design than your tradition software languages like C and Java
--To learn VHDL, we're going to create a VHDL file that describes an AND gate 

--1.1 Signals

--The fundamental unit of VHDL is called a signal 
--For now we will assume that a signal can be either a 0 or a 1 (there are actually other possibilities, but not useful now)
--Signals are used for communication between VHDL components

signal and_gate : std_logic; 
and_gate <= input_1 and input_2; 

--The first line defines a signal of type std_logic and is called "and_gate"
--This is most common, but there are a few more that can be used (like std_logic_vector)
--The second line generates an AND gate with a single output (and_gate), and two inputs (input_1 and input_2)
--The "<=" operator is known as the assignment operator 
--If you were to say this out loud, you would say "The signal and_gate GETS input_1 and-ed with input_2"

--1.2 Entities

--So you may be wondering where input_1 and input_2 actually come from
--They are inputs to this file, as their name suggests, but we need to give the tools surrounding them 
--Input and outputs to a file are defined in an entity 
--An entity contains a port that defines all input ans outputs to a file 

entity example_and is 
	port (
		input_1      : in  std_logic;
		input_2      : in  std_logic;
		and_result   : out std_logic
	);
end exmaple_and;

--This is a basic entity 
--It defines an entity called "example_and" and 3 signals- 2 inputs and and 1 output, all of which are type std_logic

--1.3 Architecture 

--One other VHDL keyword is needed to make this complete, and that is the architecture
--An architecture is used to describe the functionality of a particular entity 
--Think of it as a report: The entity is the table of contents, and the architecture IS the content 
--Or in software terms: The entity is the function declaration, the parameter inputs, and the return statement; the architecture is the function definition

architecture routine1 of example_and is 
	signal and_gate : std_logic;
begin 
	and_gate <= input_1 and input_2;
	and_result <= and_gate;
end routine1;

--The above code defines an architecture called "routine1" of entity "example_and"
--All signals that are used by the architecture must be defined between the "is" and "end" keywords

--1.4 Libraries
 
--We're almost finished with this file- but one last thing: we need to state which libraries to use 
--A library defines how certain keywords behave in your file
--For now, just take it for granted that you need to have these 2 lines at the top of your file:

library ieee;
use ieee.std_logic_1164.all;

--1.5 The Story so Far

library ieee;
use ieee.std_logic_1164.all;
 
entity example_and is
  port (
    input_1    : in  std_logic;
    input_2    : in  std_logic;
    and_result : out std_logic
    );
end example_and;
 
architecture routinel of example_and is
  signal and_gate : std_logic;
begin
  and_gate   <= input_1 and input_2;
  and_result <= and_gate;
end routinel;

--