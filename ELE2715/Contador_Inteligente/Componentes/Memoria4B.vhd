--==============================================================================================
--				ARMAZENADOR DE 4 BITS
--==============================================================================================

entity MEM4B is
	port (I : in bit_vector(3 downto 0);
			clk : bit;
			set : in bit;
			clr : in bit;
			load : in bit;
			S : out bit_vector(3 downto 0));
end MEM4B;

architecture ckt of MEM4B is

	component FFD is
		port (clk ,d,set ,clr: in bit;
			q: out bit);
	end component;

    component MUX2B is
		port (i0, i1, s : in bit;
				y : out bit);
	end component;

    signal outff : bit_vector(3 downto 0);
    signal outmux : bit_vector(3 downto 0);

	begin

        A0MUX : MUX2B port map (outff(0), I(0), load, outmux(0));
        A0IN : FFD port map (clk, outmux(0), set, clr, outff(0));

        A1MUX : MUX2B port map (outff(1), I(1), load, outmux(1));
        A1IN : FFD port map (clk, outmux(1), set, clr, outff(1));

        A2MUX : MUX2B port map (outff(2), I(2), load, outmux(2));
        A2IN : FFD port map (clk, outmux(2), set, clr, outff(2));

        A3MUX : MUX2B port map (outff(3), I(3), load, outmux(3));
        A3IN : FFD port map (clk, outmux(3), set, clr, outff(3));

        S <= outff;
end ckt;