--Name:Anoushka Dey
--Roll No: 210010010
--Last two digits: 10

-- simple gates with trivial architectures
library IEEE;
use IEEE.std_logic_1164.all;
entity andgate is
port (A, B: in std_ulogic;
prod: out std_ulogic);
end entity andgate;
architecture trivial of andgate is
begin
prod <= A AND B AFTER 310 ps;
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;
entity xorgate is
port (A, B: in std_ulogic;
uneq: out std_ulogic);
end entity xorgate;
architecture trivial of xorgate is
begin
uneq <= A XOR B AFTER 620 ps;
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;
entity abcgate is
port (A, B, C: in std_ulogic;
abc: out std_ulogic);
end entity abcgate;
architecture trivial of abcgate is
begin
abc <= A OR (B AND C) AFTER 410 ps;
end architecture trivial;
-- A + C.(A+B) with a trivial architecture

library IEEE;
use IEEE.std_logic_1164.all;
entity Cin_map_G is
port(A, B, Cin: in std_ulogic;
Bit0_G: out std_ulogic);
end entity Cin_map_G;
architecture trivial of Cin_map_G is
begin
Bit0_G <= (A AND B) OR (Cin AND (A OR B)) AFTER 620 ps;
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;

entity HA is
    port(
        A,B: in std_logic;
        S,Cout: out std_logic
    );
end entity;

architecture behave of HA is
    -- component declarations --
    component andgate is
        port (A, B: in std_logic;
        prod: out std_logic);
    end component;

    component xorgate is
        port (A, B: in std_logic;
        uneq: out std_logic);
    end component xorgate;
begin
    a1: andgate port map(A => A, B => B, prod => Cout);
    x1: xorgate port map(A => A, B => B, uneq => S);
end behave;

--Full Adder--
library IEEE;
use IEEE.std_logic_1164.all;

entity FA is 
     port(
        A,B,Cin: in std_logic;
        S,Cout: out std_logic
    );
end entity;

architecture behave of FA is
    -- component declarations --
    component andgate is
        port (A, B: in std_logic;
        prod: out std_logic);
    end component;

    component xorgate is
        port (A, B: in std_logic;
        uneq: out std_logic);
    end component xorgate;

    component Cin_map_G is
        port(A, B, Cin: in std_logic;
        Bit0_G: out std_logic);
    end component Cin_map_G;

    signal t1: std_logic;

begin
    g1: Cin_map_G port map(Cin => Cin, A => A, B => B, Bit0_G => Cout);
    x1: xorgate port map(A => A, B =>B, uneq => t1);
    x2: xorgate port map(A => t1, B => Cin, uneq => S);
end behave;
