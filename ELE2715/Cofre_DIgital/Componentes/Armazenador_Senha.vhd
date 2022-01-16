entity SENHA is
	port (	CLK : bit;
			I1, I2, I3 : in bit_vector(5 downto 0);
			S : in bit_vector(3 downto 0);
			COMPS : out bit);
end SENHA;

architecture ckt of SENHA is

	component MEM18 is
		port (	CLK : in bit;
				ESTADO : in bit_vector(3 downto 0);
				I_1 : in bit_vector(5 downto 0);
				I_2 : in bit_vector(5 downto 0);
				I_3 : in bit_vector(5 downto 0);
				S : out bit_vector(17 downto 0));
	end component;

	component COMP8B is
		port (A, B : in bit_vector(7 downto 0);
				AigB, AmaiorB, AmenorB : out bit);
	end component;

	signal Test_S1 : bit;
	signal Test_S2 : bit;
	signal Test_S3 : bit;

	signal AUX_OUT : bit_vector(17 downto 0);

	signal AUX_1 : bit_vector(7 downto 0);
	signal AUX_2 : bit_vector(7 downto 0);
	signal AUX_3 : bit_vector(7 downto 0);

begin
	
	T : MEM18 port map (CLK, S, I1, I2, I3, AUX_OUT);

	AUX_1(0) <= AUX_OUT(0);
	AUX_1(1) <= AUX_OUT(1);
	AUX_1(2) <= AUX_OUT(2);
	AUX_1(3) <= AUX_OUT(3);
	AUX_1(4) <= AUX_OUT(4);
	AUX_1(5) <= AUX_OUT(5);
	AUX_1(6) <= '0';
	AUX_1(7) <= '0';
	
	AUX_2(0)  <= AUX_OUT(6);
	AUX_2(1)  <= AUX_OUT(7);
	AUX_2(2)  <= AUX_OUT(8);
	AUX_2(3)  <= AUX_OUT(9);
	AUX_2(4) <= AUX_OUT(10);
	AUX_2(5) <= AUX_OUT(11);
	AUX_2(6) <= '0';
	AUX_2(7) <= '0';
	
	AUX_3(0) <= AUX_OUT(12);
	AUX_3(1) <= AUX_OUT(13);
	AUX_3(2) <= AUX_OUT(14);
	AUX_3(3) <= AUX_OUT(15);
	AUX_3(4) <= AUX_OUT(16);
	AUX_3(5) <= AUX_OUT(17);
	AUX_3(6) <= '0';
	AUX_3(7) <= '0';

	
	--senha : 100100(36) | 010111(23) |  111100 (60)
	COMPS_TESTE_01 : COMP8B port map (AUX_1, "00100100", Test_S1);
	COMPS_TESTE_02 : COMP8B port map (AUX_2, "00010111", Test_S2);
	COMPS_TESTE_03 : COMP8B port map (AUX_3, "00111100", Test_S3);

	COMPS <= Test_S1 and Test_S2 and Test_S3;

end ckt;