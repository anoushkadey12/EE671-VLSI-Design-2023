--Structural Description of the Multiply Accumulate 16x16 Dadda Multiplier with 32 bit Brent Kung Adder
library IEEE;
use IEEE.std_logic_1164.all;

entity macdadda is
port(A,B: in std_logic_vector(15 downto 0); C: in std_logic_vector(31 downto 0); S: out std_logic_vector(31 downto 0); Cout: out std_logic);
end entity;

architecture mac_arc of macdadda is

--component declarations

component brentkung is
port(A,B: in std_logic_vector(31 downto 0); Cin: in std_logic; S: out std_logic_vector(31 downto 0);
Cout: out std_logic);
end component brentkung;

component andgate is
port (A, B: in std_ulogic;
prod: out std_ulogic);
end component andgate;

component HA is
port (A,B: in std_ulogic; S,Cout:out std_ulogic);
end component HA;

component FA is
port (A,B,Cin: in std_ulogic; S,Cout:out std_ulogic);
end component FA;

--Signal Declarations
signal stage1_r1: std_logic_vector(31 downto 0);
signal stage1_r2: std_logic_vector(15 downto 0);
signal stage1_r3: std_logic_vector(16 downto 1);
signal stage1_r4: std_logic_vector(17 downto 2);
signal stage1_r5: std_logic_vector(18 downto 3);
signal stage1_r6: std_logic_vector(19 downto 4);
signal stage1_r7: std_logic_vector(20 downto 5);
signal stage1_r8: std_logic_vector(21 downto 6);
signal stage1_r9: std_logic_vector(22 downto 7);
signal stage1_r10: std_logic_vector(23 downto 8);
signal stage1_r11: std_logic_vector(24 downto 9);
signal stage1_r12: std_logic_vector(25 downto 10);
signal stage1_r13: std_logic_vector(26 downto 11);
signal stage1_r14: std_logic_vector(27 downto 12);
signal stage1_r15: std_logic_vector(28 downto 13);
signal stage1_r16: std_logic_vector(29 downto 14);
signal stage1_r17: std_logic_vector(30 downto 15);

signal fin1:std_logic_vector(31 downto 0);
signal fin2: std_logic_vector(31 downto 0);
signal wires:std_logic_vector(419 downto 0);
signal out_val:std_logic_vector(31 downto 0);
signal carry: std_logic;

begin
stage1_r1<=C(31 downto 0);

--Generating the products
prod1: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(0), prod=> stage1_r2(i)); 
end generate prod1;

prod2: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(1), prod=> stage1_r3(i+1)); 
end generate prod2;

prod3: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(2), prod=> stage1_r4(i+2)); 
end generate prod3;

prod4: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(3), prod=> stage1_r5(i+3)); 
end generate prod4;

prod5: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(4), prod=> stage1_r6(i+4)); 
end generate prod5;

prod6: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(5), prod=> stage1_r7(i+5)); 
end generate prod6;

prod7: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(6), prod=> stage1_r8(i+6)); 
end generate prod7;

prod8: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(7), prod=> stage1_r9(i+7)); 
end generate prod8;

prod9: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(8), prod=> stage1_r10(i+8)); 
end generate prod9;

prod10: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(9), prod=> stage1_r11(i+9)); 
end generate prod10;

prod11: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(10), prod=> stage1_r12(i+10)); 
end generate prod11;

prod12: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(11), prod=> stage1_r13(i+11)); 
end generate prod12;

prod13: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(12), prod=> stage1_r14(i+12)); 
end generate prod13;

prod14: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(13), prod=> stage1_r15(i+13)); 
end generate prod14;

prod15: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(14), prod=> stage1_r16(i+14)); 
end generate prod15;

prod16: for i in 0 to 15 generate
andgen_i: andgate port map(A=>A(i), B=>B(15), prod=> stage1_r17(i+15)); 
end generate prod16;


fin1(0)<=stage1_r1(0);
fin2(0)<=stage1_r2(0);

--1
HA1: HA port map(A=>stage1_r1(1),B=>stage1_r2(1),S=>fin1(1),Cout=>fin2(2));
fin2(1)<=stage1_r3(1);

--2
HA2: HA port map(A=>stage1_r1(2),B=>stage1_r2(2), S=>wires(0),Cout=>wires(1));
FA1: FA port map(A=>wires(0), B=>stage1_r3(2), Cin=> stage1_r4(2),S=>fin1(2), Cout=>fin2(3));

--3
HA3: HA port map(A=> stage1_r1(3), B=>stage1_r2(3),S=>wires(2),Cout=>wires(3));
FA2: FA port map(A=> wires(2), B=>stage1_r3(3), Cin=> stage1_r4(3), S=> wires(4), Cout=> wires(5));
FA3: FA port map(A=>wires(4), B=> wires(1), Cin=>stage1_r5(3), S=>fin1(3), Cout=>fin2(4));

--4
FA4: FA port map(A=>stage1_r1(4), B=>stage1_r2(4), Cin=> stage1_r3(4), S=>wires(6), Cout=> wires(7));
HA4: HA port map(A=>stage1_r4(4),B=>stage1_r5(4), S=> wires(8), Cout=>wires(9));
FA5: FA port map(A=>wires(6),B=>wires(3),Cin=> wires(8), S=>wires(10), Cout=>wires(11));
FA6: FA port map(A=>wires(10), B=>wires(5), Cin=>stage1_r6(4), S=>fin1(4),Cout=>fin2(5));

--5
HA5: HA port map(A=>stage1_r1(5), B=>stage1_r2(5), S=>wires(12), Cout=>wires(13));
FA7: FA port map(A=>wires(12), B=>stage1_r3(5), Cin=>stage1_r4(5), S=>wires(14),Cout=>wires(15));
FA8: FA port map(A=>stage1_r5(5), B=>stage1_r6(5), Cin=>stage1_r7(5), S=>wires(16), Cout=>wires(17));
FA9: FA port map(A=>wires(14),B=>wires(7), Cin=>wires(16), S=>wires(18), Cout=>wires(19));
FA10: FA port map(A=>wires(18), B=>wires(11), Cin=>wires(9), S=>fin1(5), Cout=>fin2(6));

--6
FA11: FA port map(A=>stage1_r1(6), B=>stage1_r2(6), Cin=> stage1_r3(6), S=>wires(20),Cout=>wires(21));
HA6: HA port map(A=>stage1_r4(6), B=>stage1_r5(6), S=> wires(22), Cout=> wires(23));
FA12: FA port map(A=> wires(20), B=> wires(13), Cin=> wires(22), S=>wires(24), Cout=> wires(25));
FA13: FA port map(A=> stage1_r6(6), B=> stage1_r7(6), Cin=> stage1_r8(6), S=>wires(26), Cout=> wires(27));
FA14: FA port map(A=> wires(24), B=> wires(15), Cin=> wires(26), S=> wires(28), Cout=>wires(29));
FA15: FA port map(A=> wires(28), B=> wires(19), Cin=> wires(17), S=> fin1(6), Cout=> fin2(7));

--7
FA16: FA port map(A=>stage1_r1(7), B=>stage1_r2(7), Cin=>stage1_r3(7), S=> wires(30), Cout=> wires(31));
FA17: FA port map(A=>stage1_r4(7), B=>stage1_r5(7), Cin=>stage1_r6(7), S=>wires(32), Cout=>wires(33));
HA7: HA port map(A=>stage1_r7(7), B=>stage1_r8(7), S=>wires(34), Cout=>wires(35));
FA18: FA port map(A=>wires(30), B=>wires(21), Cin=>wires(32), S=>wires(36), Cout=>wires(37));
FA19: FA port map(A=>wires(23), B=>wires(34), Cin=>stage1_r9(7), S=>wires(38), Cout=>wires(39));
FA20: FA port map(A=>wires(36), B=>wires(25), Cin=>wires(38), S=>wires(40), Cout=>wires(41));
FA21: FA port map(A=>wires(40), B=>wires(29), Cin=>wires(27), S=>fin1(7), Cout=>fin2(8));

--8
HA8: HA port map(A=>stage1_r1(8), B=>stage1_r2(8), S=>wires(42), Cout=>wires(43));
FA22: FA port map(A=>wires(42), B=>stage1_r3(8), Cin=> stage1_r4(8), S=>wires(44), Cout=>wires(45));
FA23: FA port map(A=>stage1_r5(8), B=>stage1_r6(8), Cin=>stage1_r7(8), S=> wires(46), Cout=> wires(47));
FA24: FA port map(A=>stage1_r8(8), B=>stage1_r9(8), Cin=>stage1_r10(8), S=> wires(48), Cout=> wires(49));
FA25: FA port map(A=>wires(44), B=>wires(31), Cin=>wires(46), S=> wires(50), Cout=> wires(51));
FA26: FA port map(A=>wires(33), B=>wires(48), Cin=>wires(35), S=> wires(52), Cout=> wires(53));
FA27: FA port map(A=>wires(50), B=>wires(37), Cin=>wires(52), S=> wires(54), Cout=> wires(55));
FA28: FA port map(A=>wires(54), B=>wires(41), Cin=>wires(39), S=> fin1(8), Cout=> fin2(9));

--9
FA29: FA port map(A=>stage1_r1(9), B=>stage1_r2(9), Cin=>stage1_r3(9), S=> wires(56), Cout=> wires(57));
HA9: HA port map(A=>stage1_r4(9),B=>stage1_r5(9), S=>wires(58), Cout=>wires(59));
FA30: FA port map(A=>wires(56), B=>wires(43), Cin=>wires(58), S=> wires(60), Cout=> wires(61));
FA31: FA port map(A=>stage1_r6(9), B=>stage1_r7(9), Cin=>stage1_r8(9), S=> wires(62), Cout=> wires(63));
FA32: FA port map(A=>stage1_r9(9), B=>stage1_r10(9), Cin=>stage1_r11(9), S=> wires(64), Cout=> wires(65));
FA33: FA port map(A=>wires(60), B=>wires(45), Cin=>wires(62), S=> wires(66), Cout=> wires(67));
FA34: FA port map(A=>wires(47), B=>wires(64), Cin=>wires(49), S=> wires(68), Cout=> wires(69));
FA35: FA port map(A=>wires(66), B=>wires(51), Cin=>wires(68), S=> wires(70), Cout=> wires(71));
FA36: FA port map(A=>wires(70), B=>wires(55), Cin=>wires(53), S=>fin1(9), Cout=>fin2(10));

--10
FA37: FA port map(A=>stage1_r1(10), B=>stage1_r2(10), Cin=>stage1_r3(10), S=> wires(72), Cout=> wires(73));
FA38: FA port map(A=>stage1_r4(10), B=>stage1_r5(10), Cin=>stage1_r6(10), S=> wires(74), Cout=> wires(75));
HA10: HA port map(A=>stage1_r7(10),B=>stage1_r8(10),S=>wires(76),Cout=>wires(77));
FA39: FA port map(A=>wires(72), B=>wires(57), Cin=>wires(74), S=> wires(78), Cout=> wires(79));
FA40: FA port map(A=>wires(59), B=>wires(76), Cin=>stage1_r9(10), S=> wires(80), Cout=> wires(81));
FA41: FA port map(A=>stage1_r10(10), B=>stage1_r11(10), Cin=>stage1_r12(10), S=> wires(82), Cout=> wires(83));
FA42: FA port map(A=>wires(78), B=>wires(61), Cin=>wires(80), S=> wires(84), Cout=> wires(85));
FA43: FA port map(A=>wires(63), B=>wires(82), Cin=>wires(65), S=> wires(86), Cout=> wires(87));
FA43_next:FA port map(A=>wires(84), B=>wires(67), Cin=>wires(86), S=> wires(88), Cout=> wires(89));
FA44: FA port map(A=>wires(88), B=>wires(71), Cin=>wires(69), S=> fin1(10), Cout=> fin2(11));

--11
FA45: FA port map(A=>stage1_r1(11), B=>stage1_r2(11), Cin=>stage1_r3(11), S=> wires(90), Cout=> wires(91));
FA46: FA port map(A=>stage1_r4(11), B=>stage1_r5(11), Cin=>stage1_r6(11), S=> wires(92), Cout=> wires(93));
FA47: FA port map(A=>stage1_r7(11), B=>stage1_r8(11), Cin=>stage1_r9(11), S=> wires(94), Cout=> wires(95));
HA11: HA port map(A=>stage1_r10(11), B=>stage1_r11(11), S=> wires(96), Cout=> wires(97));
FA49: FA port map(A=>wires(90), B=>wires(73), Cin=>wires(92), S=> wires(98), Cout=> wires(99));
FA50: FA port map(A=>wires(75), B=>wires(94), Cin=>wires(77), S=> wires(100), Cout=> wires(101));
FA51: FA port map(A=>wires(96), B=>stage1_r12(11), Cin=>stage1_r13(11), S=> wires(102), Cout=> wires(103));
FA52: FA port map(A=>wires(98), B=>wires(79), Cin=>wires(100), S=> wires(104), Cout=> wires(105));
FA53: FA port map(A=>wires(81), B=>wires(102), Cin=>wires(83), S=> wires(106), Cout=> wires(107));
FA54: FA port map(A=>wires(104), B=>wires(85), Cin=>wires(106), S=> wires(108), Cout=> wires(109));
FA55: FA port map(A=>wires(108), B=>wires(89), Cin=>wires(87), S=> fin1(11), Cout=>fin2(12));

--12
HA12: HA port map(A=>stage1_r1(12),B=>stage1_r2(12),S=>wires(110),Cout=>wires(111));
FA56: FA port map(A=>wires(110), B=>stage1_r3(12), Cin=>stage1_r4(12), S=> wires(112), Cout=> wires(113));
FA57: FA port map(A=>stage1_r5(12), B=>stage1_r6(12), Cin=>stage1_r7(12), S=> wires(114), Cout=> wires(115));
FA58: FA port map(A=>stage1_r8(12), B=>stage1_r9(12), Cin=>stage1_r10(12), S=> wires(116), Cout=> wires(117));
FA59: FA port map(A=>stage1_r11(12), B=>stage1_r12(12), Cin=>stage1_r13(12), S=> wires(118), Cout=> wires(119));
FA60: FA port map(A=>wires(112), B=>wires(91), Cin=>wires(114), S=> wires(120), Cout=> wires(121));
FA61: FA port map(A=>wires(93), B=>wires(116), Cin=>wires(95), S=> wires(122), Cout=> wires(123));
FA62: FA port map(A=>wires(118), B=>wires(97), Cin=>stage1_r14(12), S=> wires(124), Cout=> wires(125));
FA63: FA port map(A=>wires(120), B=>wires(99), Cin=>wires(122), S=> wires(126), Cout=> wires(127));
FA64: FA port map(A=>wires(101), B=>wires(124), Cin=>wires(103), S=> wires(128), Cout=> wires(129));
FA65: FA port map(A=>wires(126), B=>wires(105), Cin=>wires(128), S=> wires(130), Cout=> wires(131));
FA66: FA port map(A=>wires(130), B=>wires(109), Cin=>wires(107), S=> fin1(12), Cout=>fin2(13));

--13
FA67: FA port map(A=>stage1_r1(13),B=>stage1_r2(13),Cin=>stage1_r3(13),S=>wires(132),Cout=>wires(133));
HA13: HA port map(A=>stage1_r4(13),B=>stage1_r5(13),S=>wires(134),Cout=>wires(135));
FA68: FA port map(A=>wires(132), B=>wires(111), Cin=>wires(134), S=> wires(136), Cout=> wires(137));
FA69: FA port map(A=>stage1_r6(13), B=>stage1_r7(13), Cin=>stage1_r8(13), S=> wires(138), Cout=> wires(139));
FA70: FA port map(A=>stage1_r9(13), B=>stage1_r10(13), Cin=>stage1_r11(13), S=> wires(140), Cout=> wires(141));
FA71: FA port map(A=>stage1_r12(13), B=>stage1_r13(13), Cin=>stage1_r14(13), S=> wires(142), Cout=> wires(143));
FA72: FA port map(A=>wires(136), B=>wires(113), Cin=>wires(138), S=> wires(144), Cout=> wires(145));
FA73: FA port map(A=>wires(115), B=>wires(140), Cin=>wires(117), S=> wires(146), Cout=> wires(147));
FA74: FA port map(A=>wires(142), B=>wires(119), Cin=>stage1_r15(13), S=> wires(148), Cout=> wires(149));
FA75: FA port map(A=>wires(144), B=>wires(121), Cin=>wires(146), S=> wires(150), Cout=> wires(151));
FA76: FA port map(A=>wires(123), B=>wires(148), Cin=>wires(125), S=> wires(152), Cout=> wires(153));
FA77: FA port map(A=>wires(150), B=>wires(127), Cin=>wires(152), S=> wires(154), Cout=> wires(155));
FA78: FA port map(A=>wires(154), B=>wires(131), Cin=>wires(129), S=> fin1(13), Cout=>fin2(14));

--14
FA79: FA port map(A=>stage1_r1(14),B=>stage1_r2(14),Cin=>stage1_r3(14),S=>wires(156),Cout=>wires(157));
FA80: FA port map(A=>stage1_r4(14),B=>stage1_r5(14),Cin=>stage1_r6(14),S=>wires(158),Cout=>wires(159));
HA14: HA port map(A=>stage1_r7(14),B=>stage1_r8(14),S=>wires(160),Cout=>wires(161));
FA81: FA port map(A=>wires(156), B=>wires(133), Cin=>wires(158), S=> wires(162), Cout=> wires(163));
FA82: FA port map(A=>wires(135), B=>wires(160), Cin=>stage1_r9(14), S=> wires(164), Cout=> wires(165));
FA83: FA port map(A=>stage1_r10(14), B=>stage1_r11(14), Cin=>stage1_r12(14), S=> wires(166), Cout=> wires(167));
FA84: FA port map(A=>stage1_r13(14), B=>stage1_r14(14), Cin=>stage1_r15(14), S=> wires(168), Cout=> wires(169));
FA85: FA port map(A=>wires(162), B=>wires(137), Cin=>wires(164), S=> wires(170), Cout=> wires(171));
FA86: FA port map(A=>wires(139), B=>wires(166), Cin=>wires(141), S=> wires(172), Cout=> wires(173));
FA87: FA port map(A=>wires(168), B=>wires(143), Cin=>stage1_r16(14), S=> wires(174), Cout=> wires(175));
FA88: FA port map(A=>wires(170), B=>wires(145), Cin=>wires(172), S=> wires(176), Cout=> wires(177));
FA89: FA port map(A=>wires(147), B=>wires(174), Cin=>wires(149), S=> wires(178), Cout=> wires(179));
FA90: FA port map(A=>wires(176), B=>wires(151), Cin=>wires(178), S=> wires(180), Cout=> wires(181));
FA91: FA port map(A=>wires(180), B=>wires(155), Cin=>wires(153), S=> fin1(14), Cout=>fin2(15));

--15
FA92: FA port map(A=>stage1_r1(15),B=>stage1_r2(15),Cin=>stage1_r3(15),S=>wires(182),Cout=>wires(183));
FA93: FA port map(A=>stage1_r4(15),B=>stage1_r5(15),Cin=>stage1_r6(15),S=>wires(184),Cout=>wires(185));
FA94: FA port map(A=>stage1_r7(15),B=>stage1_r8(15),Cin=>stage1_r9(15),S=>wires(186),Cout=>wires(187));
HA15: HA port map(A=>stage1_r10(15),B=>stage1_r11(15),S=>wires(188),Cout=>wires(189));
FA95: FA port map(A=>wires(182), B=>wires(157), Cin=>wires(184), S=> wires(190), Cout=> wires(191));
FA96: FA port map(A=>wires(159), B=>wires(186), Cin=>wires(161), S=> wires(192), Cout=> wires(193));
FA97: FA port map(A=>wires(188), B=>stage1_r12(15), Cin=>stage1_r13(15), S=> wires(194), Cout=> wires(195));
FA98: FA port map(A=>stage1_r14(15), B=>stage1_r15(15), Cin=>stage1_r15(15), S=> wires(196), Cout=> wires(197));
FA99: FA port map(A=>wires(190), B=>wires(163), Cin=>wires(192), S=> wires(198), Cout=> wires(199));
FA100: FA port map(A=>wires(165), B=>wires(194), Cin=>wires(167), S=> wires(200), Cout=> wires(201));
FA101: FA port map(A=>wires(196), B=>wires(169), Cin=>stage1_r17(15), S=> wires(202), Cout=> wires(203));
FA102: FA port map(A=>wires(198), B=>wires(171), Cin=>wires(200), S=> wires(204), Cout=> wires(205));
FA103: FA port map(A=>wires(173), B=>wires(202), Cin=>wires(175), S=> wires(206), Cout=> wires(207));
FA104: FA port map(A=>wires(204), B=>wires(177), Cin=>wires(206), S=> wires(208), Cout=> wires(209));
FA105: FA port map(A=>wires(208), B=>wires(181), Cin=>wires(179), S=> fin1(15), Cout=>fin2(16));

--16
FA106: FA port map(A=>stage1_r1(16),B=>stage1_r3(16),Cin=>stage1_r4(16),S=>wires(210),Cout=>wires(211));
FA107: FA port map(A=>stage1_r5(16),B=>stage1_r6(16),Cin=>stage1_r7(16),S=>wires(212),Cout=>wires(213));
FA108: FA port map(A=>stage1_r8(16),B=>stage1_r9(16),Cin=>stage1_r10(16),S=>wires(214),Cout=>wires(215));
HA16: HA port map(A=>stage1_r11(16),B=>stage1_r12(16),S=>wires(216),Cout=>wires(217));
FA109: FA port map(A=>wires(210), B=>wires(183), Cin=>wires(212), S=> wires(218), Cout=> wires(219));
FA110: FA port map(A=>wires(185), B=>wires(214), Cin=>wires(187), S=> wires(220), Cout=> wires(221));
FA111: FA port map(A=>wires(216), B=>wires(189), Cin=>stage1_r13(16), S=> wires(222), Cout=> wires(223));
FA112: FA port map(A=>stage1_r14(16), B=>stage1_r15(16), Cin=>stage1_r16(16), S=> wires(224), Cout=> wires(225));
FA113: FA port map(A=>wires(218), B=>wires(191), Cin=>wires(220), S=> wires(226), Cout=> wires(227));
FA114: FA port map(A=>wires(193), B=>wires(222), Cin=>wires(195), S=> wires(228), Cout=> wires(229));
FA115: FA port map(A=>wires(224), B=>wires(197), Cin=>stage1_r17(16), S=> wires(230), Cout=> wires(231));
FA116: FA port map(A=>wires(226), B=>wires(199), Cin=>wires(228), S=> wires(232), Cout=> wires(233));
FA117: FA port map(A=>wires(201), B=>wires(230), Cin=>wires(203), S=> wires(234), Cout=> wires(235));
FA118: FA port map(A=>wires(232), B=>wires(205), Cin=>wires(234), S=> wires(236), Cout=> wires(237));
FA119: FA port map(A=>wires(236), B=>wires(209), Cin=>wires(207), S=> fin1(16), Cout=>fin2(17));

--17
FA120: FA port map(A=>stage1_r1(17),B=>stage1_r4(17),Cin=>stage1_r5(17),S=>wires(238),Cout=>wires(239));
FA121: FA port map(A=>stage1_r6(17),B=>stage1_r7(17),Cin=>stage1_r8(17),S=>wires(240),Cout=>wires(241));
FA122: FA port map(A=>stage1_r9(17),B=>stage1_r10(17),Cin=>stage1_r11(17),S=>wires(242),Cout=>wires(243));
FA123: FA port map(A=>wires(238), B=>wires(211), Cin=>wires(240), S=> wires(244), Cout=> wires(245));
FA124: FA port map(A=>wires(213), B=>wires(242), Cin=>wires(215), S=> wires(246), Cout=> wires(247));
FA125: FA port map(A=>stage1_r12(17), B=>wires(217), Cin=>stage1_r13(17), S=> wires(248), Cout=> wires(249));
FA126: FA port map(A=>stage1_r14(17), B=>stage1_r15(17), Cin=>stage1_r16(17), S=> wires(250), Cout=> wires(251));
FA127: FA port map(A=>wires(244), B=>wires(219), Cin=>wires(246), S=> wires(252), Cout=> wires(253));
FA128: FA port map(A=>wires(221), B=>wires(248), Cin=>wires(223), S=> wires(254), Cout=> wires(255));
FA129: FA port map(A=>wires(250), B=>wires(225), Cin=>stage1_r17(17), S=> wires(256), Cout=> wires(257));
FA130: FA port map(A=>wires(252), B=>wires(227), Cin=>wires(254), S=> wires(258), Cout=> wires(259));
FA131: FA port map(A=>wires(229), B=>wires(256), Cin=>wires(231), S=> wires(260), Cout=> wires(261));
FA132: FA port map(A=>wires(258), B=>wires(233), Cin=>wires(260), S=> wires(262), Cout=> wires(263));
FA133: FA port map(A=>wires(262), B=>wires(237), Cin=>wires(235), S=> fin1(17), Cout=>fin2(18));

--18
FA134: FA port map(A=>stage1_r1(18),B=>stage1_r5(18),Cin=>stage1_r6(18),S=>wires(264),Cout=>wires(265));
FA135: FA port map(A=>stage1_r7(18),B=>stage1_r8(18),Cin=>stage1_r9(18),S=>wires(266),Cout=>wires(267));
FA136: FA port map(A=>wires(264),B=>wires(239),Cin=>wires(266),S=>wires(268),Cout=>wires(269));
FA137: FA port map(A=>wires(241), B=>stage1_r10(18), Cin=>wires(243), S=> wires(270), Cout=> wires(271));
FA138: FA port map(A=>stage1_r11(18), B=>stage1_r12(18), Cin=>stage1_r13(18), S=> wires(272), Cout=> wires(273));
FA139: FA port map(A=>stage1_r14(18), B=>stage1_r15(18), Cin=>stage1_r16(18), S=> wires(274), Cout=> wires(275));
FA140: FA port map(A=>wires(268), B=>wires(245), Cin=>wires(270), S=> wires(276), Cout=> wires(277));
FA141: FA port map(A=>wires(247), B=>wires(272), Cin=>wires(249), S=> wires(278), Cout=> wires(279));
FA142: FA port map(A=>wires(274), B=>wires(251), Cin=>stage1_r17(18), S=> wires(280), Cout=> wires(281));
FA143: FA port map(A=>wires(276), B=>wires(253), Cin=>wires(278), S=> wires(282), Cout=> wires(283));
FA144: FA port map(A=>wires(255), B=>wires(280), Cin=>wires(257), S=> wires(284), Cout=> wires(285));
FA145: FA port map(A=>wires(282), B=>wires(259), Cin=>wires(284), S=> wires(286), Cout=> wires(287));
FA146: FA port map(A=>wires(286), B=>wires(263), Cin=>wires(261), S=> fin1(18), Cout=>fin2(19));

--19
FA147: FA port map(A=>stage1_r1(19),B=>stage1_r6(19),Cin=>stage1_r7(19),S=>wires(288),Cout=>wires(289));
FA148: FA port map(A=>wires(288),B=>wires(265),Cin=>stage1_r8(19),S=>wires(290),Cout=>wires(291));
FA149: FA port map(A=>wires(267),B=>stage1_r9(19),Cin=>stage1_r10(19),S=>wires(292),Cout=>wires(293));
FA150: FA port map(A=>stage1_r11(19), B=>stage1_r12(19), Cin=>stage1_r13(19), S=> wires(294), Cout=> wires(295));
FA151: FA port map(A=>stage1_r14(19), B=>stage1_r15(19), Cin=>stage1_r16(19), S=> wires(296), Cout=> wires(297));
FA152: FA port map(A=>wires(290), B=>wires(269), Cin=>wires(292), S=> wires(298), Cout=> wires(299));
FA153: FA port map(A=>wires(271), B=>wires(294), Cin=>wires(273), S=> wires(300), Cout=> wires(301));
FA154: FA port map(A=>wires(296), B=>wires(275), Cin=>stage1_r17(19), S=> wires(302), Cout=> wires(303));
FA155: FA port map(A=>wires(298), B=>wires(277), Cin=>wires(300), S=> wires(304), Cout=> wires(305));
FA156: FA port map(A=>wires(279), B=>wires(302), Cin=>wires(281), S=> wires(306), Cout=> wires(307));
FA157: FA port map(A=>wires(304), B=>wires(283), Cin=>wires(306), S=> wires(308), Cout=> wires(309));
FA158: FA port map(A=>wires(308), B=>wires(287), Cin=>wires(285), S=> fin1(19), Cout=> fin2(20));

--20
FA159: FA port map(A=>stage1_r1(20),B=>wires(289),Cin=>stage1_r7(20),S=>wires(310),Cout=>wires(311));
FA160: FA port map(A=>stage1_r8(20), B=>stage1_r9(20), Cin=>stage1_r10(20), S=> wires(312), Cout=> wires(313));
FA161: FA port map(A=>stage1_r11(20), B=>stage1_r12(20), Cin=>stage1_r13(20), S=> wires(314), Cout=> wires(315));
FA162: FA port map(A=>stage1_r14(20), B=>stage1_r15(20), Cin=>stage1_r16(20), S=> wires(316), Cout=> wires(317));
FA163: FA port map(A=>wires(310), B=>wires(291), Cin=>wires(312), S=> wires(318), Cout=> wires(319));
FA164: FA port map(A=>wires(293), B=>wires(314), Cin=>wires(295), S=> wires(320), Cout=> wires(321));
FA165: FA port map(A=>wires(316), B=>wires(297), Cin=>stage1_r17(20), S=> wires(322), Cout=> wires(323));
FA166: FA port map(A=>wires(318), B=>wires(299), Cin=>wires(320), S=> wires(324), Cout=> wires(325));
FA167: FA port map(A=>wires(301), B=>wires(322), Cin=>wires(303), S=> wires(326), Cout=> wires(327));
FA168: FA port map(A=>wires(324), B=>wires(305), Cin=>wires(326), S=> wires(328), Cout=> wires(329));
FA169: FA port map(A=>wires(328), B=>wires(309), Cin=>wires(307), S=> fin1(20), Cout=> fin2(21));

--21
FA170: FA port map(A=>stage1_r1(21), B=>stage1_r8(21), Cin=>stage1_r9(21), S=> wires(330), Cout=> wires(331));
FA171: FA port map(A=>stage1_r10(21), B=>stage1_r11(21), Cin=>stage1_r12(21), S=> wires(332), Cout=> wires(333));
FA172: FA port map(A=>stage1_r13(21), B=>stage1_r14(21), Cin=>stage1_r15(21), S=> wires(334), Cout=> wires(335));
FA173: FA port map(A=>wires(330), B=>wires(311), Cin=>wires(332), S=> wires(336), Cout=> wires(337));
FA174: FA port map(A=>wires(313), B=>wires(334), Cin=>wires(315), S=> wires(338), Cout=> wires(339));
FA175: FA port map(A=>stage1_r16(21), B=>wires(317), Cin=>stage1_r17(21), S=> wires(340), Cout=> wires(341));
FA176: FA port map(A=>wires(336), B=>wires(319), Cin=>wires(338), S=> wires(342), Cout=> wires(343));
FA177: FA port map(A=>wires(321), B=>wires(340), Cin=>wires(323), S=> wires(344), Cout=> wires(345));
FA178: FA port map(A=>wires(342), B=>wires(325), Cin=>wires(344), S=> wires(346), Cout=> wires(347));
FA179: FA port map(A=>wires(346), B=>wires(329), Cin=>wires(327), S=> fin1(21), Cout=> fin2(22));

--22
FA180: FA port map(A=>stage1_r1(22), B=>stage1_r9(22), Cin=>stage1_r10(22), S=> wires(348), Cout=> wires(349));
FA181: FA port map(A=>stage1_r11(22), B=>stage1_r12(22), Cin=>stage1_r13(22), S=> wires(350), Cout=> wires(351));
FA182: FA port map(A=>wires(348), B=>wires(331), Cin=>wires(350), S=> wires(352), Cout=> wires(353));
FA183: FA port map(A=>wires(333), B=>stage1_r14(22), Cin=>wires(335), S=> wires(354), Cout=> wires(355));
FA184: FA port map(A=>stage1_r15(22), B=>stage1_r16(22), Cin=>stage1_r17(22), S=> wires(356), Cout=> wires(357));
FA185: FA port map(A=>wires(352), B=>wires(337), Cin=>wires(354), S=> wires(358), Cout=> wires(359));
FA186: FA port map(A=>wires(339), B=>wires(356), Cin=>wires(341), S=> wires(360), Cout=> wires(361));
FA187: FA port map(A=>wires(358), B=>wires(343), Cin=>wires(360), S=> wires(362), Cout=> wires(363));
FA188: FA port map(A=>wires(362), B=>wires(347), Cin=>wires(345), S=> fin1(22), Cout=> fin2(23));

--23
FA189: FA port map(A=>stage1_r1(23), B=>stage1_r10(23), Cin=>stage1_r11(23), S=> wires(364), Cout=> wires(365));
FA190: FA port map(A=>wires(364), B=>wires(349), Cin=>stage1_r12(23), S=> wires(366), Cout=> wires(367));
FA191: FA port map(A=>wires(351), B=>stage1_r13(23), Cin=>stage1_r14(23), S=> wires(368), Cout=> wires(369));
FA192: FA port map(A=>stage1_r15(23), B=>stage1_r16(23), Cin=>stage1_r17(23), S=> wires(370), Cout=> wires(371));
FA193: FA port map(A=>wires(366), B=>wires(353), Cin=>wires(368), S=> wires(372), Cout=> wires(373));
FA194: FA port map(A=>wires(355), B=>wires(370), Cin=>wires(357), S=> wires(374), Cout=> wires(375));
FA195: FA port map(A=>wires(372), B=>wires(359), Cin=>wires(374), S=> wires(376), Cout=> wires(377));
FA196: FA port map(A=>wires(376), B=>wires(363), Cin=>wires(361), S=> fin1(23), Cout=> fin2(24));

--24
FA197: FA port map(A=>stage1_r1(24), B=>wires(365), Cin=>stage1_r11(24), S=> wires(378), Cout=> wires(379));
FA198: FA port map(A=>stage1_r12(24), B=>stage1_r13(24), Cin=>stage1_r14(24), S=> wires(380), Cout=> wires(381));
FA199: FA port map(A=>stage1_r15(24), B=>stage1_r16(24), Cin=>stage1_r17(24), S=> wires(382), Cout=> wires(383));
FA200: FA port map(A=>wires(378), B=>wires(367), Cin=>wires(380), S=> wires(384), Cout=> wires(385));
FA201: FA port map(A=>wires(369), B=>wires(382), Cin=>wires(371), S=> wires(386), Cout=> wires(387));
FA202: FA port map(A=>wires(384), B=>wires(373), Cin=>wires(386), S=> wires(388), Cout=> wires(389));
FA203: FA port map(A=>wires(388), B=>wires(377), Cin=>wires(375), S=> fin1(24), Cout=> fin2(25));

--25
FA204: FA port map(A=>stage1_r1(25), B=>stage1_r12(25), Cin=>stage1_r13(25), S=> wires(390), Cout=> wires(391));
FA205: FA port map(A=>stage1_r14(25), B=>stage1_r15(25), Cin=>stage1_r16(25), S=> wires(392), Cout=> wires(393));
FA206: FA port map(A=>wires(390), B=>wires(379), Cin=>wires(392), S=> wires(394), Cout=> wires(395));
FA207: FA port map(A=>wires(381), B=>stage1_r17(25), Cin=>wires(383), S=> wires(396), Cout=> wires(397));
FA208: FA port map(A=>wires(394), B=>wires(385), Cin=>wires(396), S=> wires(398), Cout=> wires(399));
FA209: FA port map(A=>wires(398), B=>wires(389), Cin=>wires(387), S=> fin1(25), Cout=> fin2(26));

--26
FA210: FA port map(A=>stage1_r1(26), B=>stage1_r13(26), Cin=>stage1_r14(26), S=> wires(400), Cout=> wires(401));
FA211: FA port map(A=>wires(400), B=>wires(391), Cin=>stage1_r15(26), S=> wires(402), Cout=> wires(403));
FA212: FA port map(A=>wires(393), B=>stage1_r16(26), Cin=>stage1_r17(26), S=> wires(404), Cout=> wires(405));
FA213: FA port map(A=>wires(402), B=>wires(395), Cin=>wires(404), S=> wires(406), Cout=> wires(407));
FA214: FA port map(A=>wires(406), B=>wires(399), Cin=>wires(397), S=> fin1(26), Cout=> fin2(27));

--27
FA215: FA port map(A=>stage1_r1(27), B=>wires(401), Cin=>stage1_r14(27), S=> wires(408), Cout=> wires(409));
FA216: FA port map(A=>stage1_r15(27), B=>stage1_r16(27), Cin=>stage1_r17(27), S=> wires(410), Cout=> wires(411));
FA217: FA port map(A=>wires(408), B=>wires(403), Cin=>wires(410), S=> wires(412), Cout=> wires(413));
FA218: FA port map(A=>wires(412), B=>wires(407), Cin=>wires(405), S=> fin1(27), Cout=> fin2(28));

--28
FA219: FA port map(A=>stage1_r1(28), B=>stage1_r15(28), Cin=>stage1_r16(28), S=> wires(414), Cout=> wires(415));
FA220: FA port map(A=>wires(414), B=>wires(409), Cin=>stage1_r17(28), S=> wires(416), Cout=> wires(417));
FA221: FA port map(A=>wires(416), B=>wires(413), Cin=>wires(411), S=> fin1(28), Cout=> fin2(29));

--29
FA222: FA port map(A=>stage1_r1(29), B=>wires(415), Cin=>stage1_r16(29), S=> wires(418), Cout=> wires(419));
FA223: FA port map(A=>wires(418), B=>wires(417), Cin=>stage1_r17(29), S=> fin1(29), Cout=> fin2(30));

--30
FA224: FA port map(A=>stage1_r1(30), B=>wires(419), Cin=>stage1_r17(30), S=> fin1(30), Cout=> fin2(31));

--31
fin1(31)<=stage1_r1(31);

--Brent Kung Adder
bk_adder: brentkung port map(A=>fin1(31 downto 0), B=>fin2(31 downto 0),Cin=>'0',S=>out_val,Cout=>carry);
S<=out_val(31 downto 0);
Cout<=carry;

end mac_arc;
