entity MEM18 is
	port (	CLK : in bit;
			ESTADO : in bit_vector(3 downto 0);
			I_1 : in bit_vector(5 downto 0);
			I_2 : in bit_vector(5 downto 0);
			I_3 : in bit_vector(5 downto 0);
   			S : out bit_vector(17 downto 0));
end MEM18;

architecture ckt of MEM18 is

	component MEM6 is
		port (	CLK, CLR, EN : in bit;
				I : in bit_vector(5 downto 0);
	   			S : out bit_vector(5 downto 0));
	end component;

	signal MEM6_1 : bit_vector(5 downto 0);
	signal MEM6_2 : bit_vector(5 downto 0);
	signal MEM6_3 : bit_vector(5 downto 0);

	signal OUTT_1 : bit_vector(5 downto 0);
	signal OUTT_2 : bit_vector(5 downto 0);
	signal OUTT_3 : bit_vector(5 downto 0);

	signal EN_EST_S1 : bit;
	signal EN_EST_S2 : bit;
	signal EN_EST_S3 : bit;

	signal CLR_EST : bit;
		
	begin

		MEM6_1(0) <= I_1(0);
		MEM6_1(1) <= I_1(1);
		MEM6_1(2) <= I_1(2);
		MEM6_1(3) <= I_1(3);
		MEM6_1(4) <= I_1(4);
		MEM6_1(5) <= I_1(5);

		MEM6_2(0) <= I_2(0);
		MEM6_2(1) <= I_2(1);
		MEM6_2(2) <= I_2(2);
		MEM6_2(3) <= I_2(3);
		MEM6_2(4) <= I_2(4);
		MEM6_2(5) <= I_2(5);

		MEM6_3(0) <= I_3(0);
		MEM6_3(1) <= I_3(1);
		MEM6_3(2) <= I_3(2);
		MEM6_3(3) <= I_3(3);
		MEM6_3(4) <= I_3(4);
		MEM6_3(5) <= I_3(5);

		EN_EST_S1 <= (not ESTADO(3) and not ESTADO(2) and ESTADO(1) and not ESTADO(0));
		EN_EST_S2 <= (not ESTADO(3) and ESTADO(2) and not ESTADO(1) and not ESTADO(0));
		EN_EST_S3 <=  (not ESTADO(3) and ESTADO(2) and ESTADO(1) and not ESTADO(0));

		CLR_EST <= not ((ESTADO(3) and ESTADO(2) and ESTADO(1) and ESTADO(0)) or (ESTADO(3) and not ESTADO(2) and ESTADO(1) and not ESTADO(0)));

		M1 : MEM6 port map (CLK, CLR_EST, EN_EST_S1, MEM6_1, OUTT_1);
		M2 : MEM6 port map (CLK, CLR_EST, EN_EST_S2, MEM6_2, OUTT_2);
		M3 : MEM6 port map (CLK, CLR_EST, EN_EST_S3, MEM6_3, OUTT_3);


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