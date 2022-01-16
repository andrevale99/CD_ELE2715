entity MEM18 is
	port (	CLK, CLR : in bit;
			I : in bit_vector(17 downto 0);
   			S : out bit_vector(17 downto 0));
end MEM18;

architecture ckt of MEM18 is

	component MEM6 is
		port (	CLK, CLR : in bit;
		 		I : in bit_vector(5 downto 0);
				S : out bit_vector(5 downto 0));
	end component;

	signal MEM6_1 : bit_vector(5 downto 0);
	signal MEM6_2 : bit_vector(5 downto 0);
	signal MEM6_3 : bit_vector(5 downto 0);

	signal OUTT_1 : bit_vector(5 downto 0);
	signal OUTT_2 : bit_vector(5 downto 0);
	signal OUTT_3 : bit_vector(5 downto 0);
		
	begin

		MEM6_1(0) <= I(0);
		MEM6_1(1) <= I(1);
		MEM6_1(2) <= I(2);
		MEM6_1(3) <= I(3);
		MEM6_1(4) <= I(4);
		MEM6_1(5) <= I(5);

		MEM6_2(0) <= I(6);
		MEM6_2(1) <= I(7);
		MEM6_2(2) <= I(8);
		MEM6_2(3) <= I(9);
		MEM6_2(4) <= I(10);
		MEM6_2(5) <= I(11);

		MEM6_3(0) <= I(12);
		MEM6_3(1) <= I(13);
		MEM6_3(2) <= I(14);
		MEM6_3(3) <= I(15);
		MEM6_3(4) <= I(16);
		MEM6_3(5) <= I(17);


		M1 : MEM6 port map (CLK, CLR, MEM6_1, OUTT_1);
		M2 : MEM6 port map (CLK, CLR, MEM6_2, OUTT_2);
		M3 : MEM6 port map (CLK, CLR, MEM6_3, OUTT_3);


		S(0) <= OUTT_1(0);
		S(1) <= OUTT_1(1);
		S(2) <= OUTT_1(2);
		S(3) <= OUTT_1(3);
		S(4) <= OUTT_1(4);
		S(5) <= OUTT_1(5);
	
		S(6)  <= OUTT_2(0);
		S(7)  <= OUTT_2(1);
		S(8)  <= OUTT_2(2);
		S(9)  <= OUTT_2(3);
		S(10) <= OUTT_2(4);
		S(11) <= OUTT_2(5);
	
		S(12) <= OUTT_3(0);
		S(13) <= OUTT_3(1);
		S(14) <= OUTT_3(2);
		S(15) <= OUTT_3(3);
		S(16) <= OUTT_3(4);
		S(17) <= OUTT_3(5);

end ckt;