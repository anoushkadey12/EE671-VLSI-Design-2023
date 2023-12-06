-- A DUT entity is used to wrap your design so that we can combine it with testbench.
-- This example shows how you can do this for the OR Gate

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(63 downto 0);
       	output_vector: out std_logic_vector(32 downto 0));
end entity;

architecture DutWrap of DUT is
   component macdadda is
port(A,B: in std_logic_vector(15 downto 0); C: in std_logic_vector(31 downto 0); S: out std_logic_vector(31 downto 0); Cout: out std_logic);
end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: macdadda
			port map (
					-- order of inputs B A
					A=> input_vector(63 downto 48),
					B => input_vector(47 downto 32),
					C=> input_vector(31 downto 0),
               -- order of output OUTPUT
					Cout=>output_vector(32),
					S => output_vector(31 downto 0));
end DutWrap;
