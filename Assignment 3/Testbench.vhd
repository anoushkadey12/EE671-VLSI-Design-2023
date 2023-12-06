library std;
use std.textio.all;

library IEEE;
use IEEE.std_logic_1164.all;

entity Testbench is
end entity;

architecture Behave of Testbench is


--Component Declaration
component brentkung is
port(A,B: in std_logic_vector(31 downto 0); Cin: in std_logic; S: out std_logic_vector(31 downto 0);
Cout: out std_logic);
end component brentkung;

--Signal Declaration
signal input_vector: std_logic_vector(64 downto 0);--Consists of Cin, A and B
signal output_vector:std_logic_vector(16 downto 0);--Consists of Cout and S

function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;
-- Bit vector to std_logic_vector and vice-versa
function to_std_logic_vector(x: bit_vector) return std_logic_vector is
     alias lx: bit_vector(1 to x'length) is x;
     variable ret_val: std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_std_logic_vector;

function to_bit_vector(x: std_logic_vector) return bit_vector is
     alias lx: std_logic_vector(1 to x'length) is x;
     variable ret_val: bit_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_bit_vector;

begin
dut:brentkung
port map(A=>input_vector(63 downto 16), B=>input_vector(15 downto 0), Cin=> input_vector(64), S=>output_vector(31 downto 0),
Cout=>output_vector(32));

main:process
file infile: text open read_mode is "testcases.txt";
file outfile: text open write_mode is "results.txt";

variable invar:bit_vector(64 downto 0);
variable outvar: bit_vector(32 downto 0);
variable flag: boolean:=true;
variable testcase: integer:=0;
variable inp_line:Line;
variable out_line:Line;

begin
while not endfile(infile) loop
	testcase:=testcase+1;
	readLine(infile,inp_line);
	read(inp_line,invar);
	read(inp_line,outvar);
	
	input_vector<=to_std_logic_vector(invar);
	wait for 10 ns;
	
	if(output_vector=to_std_logic_vector(outvar)) then
		flag:=flag and true;
	else
		flag:=false;
		write(out_line,to_string("Error: Testcase "& integer'image(testcase)));
		writeline(outfile,out_line);
	end if;
	
	write(out_line,to_bit_vector(input_vector));
	write(out_line,to_string(" "));
	write(out_line, to_bit_vector(output_vector));
	writeline(outfile,out_line);
	wait for 5 ns;
end loop;

 assert (not flag) report "SUCCESS, All Testcases out of " & integer'image(testcase) & " Passed!" severity note;
 assert (flag) report "FAILURE, Few Testcases out of " & integer'image(testcase) & " Failed" severity error;
report "Design verification completed";
wait;

end process;
end;




