--==============================================================================================
--				FLIP-FLOP D
--==============================================================================================
entity FFD is
	port (clk ,d,set ,clr: in bit;
			q: out bit);
end FFD;

architecture CKT of FFD is
	
signal qs: bit;
begin
	process(clk ,set ,clr)
	begin

		if set = '0' then qs <= '1';
		elsif clr = '0' then qs <= '0';
		elsif clk='1' and clk 'event then
			qs <= d;
	end if;

	end process;

	q <= qs;

end CKT;

--==============================================================================================
--				FLIP-FLOP J-K
--==============================================================================================
entity FFJK is
	port (clk ,j,k,set ,clr: in bit;
		q: out bit);
end FFJK;


architecture CKT of FFJK is

signal qs: bit;
begin

	process(clk ,set ,clr)
	begin
		if set = '0' then qs <= '1';
		elsif clr = '0' then qs <= '0';
		elsif clk= '1' and clk 'event then
			
			if j = '1' and k = '1' then qs <= not qs;
			elsif j = '1' and k = '0' then qs <= '1';
			elsif j = '0' and k = '1' then qs <= '0';
			end if;

		end if;
	end process;

	q <= qs;

end CKT;

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

	signal aux : bit_vector(3 downto 0);
	

	begin

	A0 : FFD port map (clk, aux(0), set, clr, S(0));
	A1 : FFD port map (clk, aux(1), set, clr, S(1));
	A2 : FFD port map (clk, aux(2), set, clr, S(2));
	A3 : FFD port map (clk, aux(3), set, clr, S(3));

	process(load)
	begin
		if load = '1' then
			aux(0) <= I(0);
			aux(1) <= I(1);
			aux(2) <= I(2);
			aux(3) <= I(3);
		end if;
	end process;

end ckt;

--=================================================================
--				MUX de 2 BITS
--=================================================================
entity MUX2B is
	port (i0, i1, s : in bit;
		 	y : out bit);
end MUX2B;

architecture ckt of MUX2B is

	begin
		y <= (not s and i0) or (s and i1);

end ckt;

--=================================================================
--				MUX de 4 BITS INPUT e 4 BITS OUTPUT
--=================================================================
entity MUX4X4B is
	port (i0, i1 : in bit_vector(3 downto 0);
			s : in bit;
		 	y : out bit_vector(3 downto 0));
end MUX4X4B;

architecture ckt of MUX4X4B is

	component MUX2B is
		port (i0, i1, s : in bit;
				y : out bit);
	end component;

	begin

		S0 : MUX2B port map (i0(0), i1(0), s, y(0));
		S1 : MUX2B port map (i0(1), i1(1), s, y(1));
		S2 : MUX2B port map (i0(2), i1(2), s, y(2));
		S3 : MUX2B port map (i0(3), i1(3), s, y(3));

end ckt;

--=================================================================
--				ESTOURO CRESCENTE E DECRESCENTE
--=================================================================
entity TC_CRES is
	port(I : in bit_vector(3 downto 0);
			Y : out bit);
end TC_CRES;

architecture ckt of TC_CRES is

	begin
		Y <= I(3) and I(2) and I(1) and I(0);

end ckt;

entity TC_DEC is
	port(I : in bit_vector(3 downto 0);
			Y : out bit);
end TC_DEC;

architecture ckt of TC_DEC is

	begin
		Y <= not (I(3) or I(2) or I(1) or I(0));

end ckt;

--=================================================================
--				SELETOR DO ESTOURO
--=================================================================
entity TC is
	port(ENTRADA : in bit_vector(3 downto 0);
			S : in bit;
			Y : out bit);
end TC;

architecture ckt of TC is

	component MUX2B is
		port (i0, i1, s : in bit;
				 y : out bit);
	end component;

	component TC_CRES is
		port(I : in bit_vector(3 downto 0);
			Y : out bit);
	end component;

	component TC_DEC is
		port(I : in bit_vector(3 downto 0);
			Y : out bit);
	end component;

	signal CRESCENTE : bit;
	signal DECRESCENTE : bit;

	begin
		
		CR : TC_CRES port map (ENTRADA, CRESCENTE);
		DC : TC_DEC port map (ENTRADA, DECRESCENTE);

		ESTOURO : MUX2B port map (CRESCENTE, DECRESCENTE, S);

		Y <= (not S and CRESCENTE) or (S and DECRESCENTE);

end ckt;

--=================================================================
--				COMPARADOR DE 4 BITS
--=================================================================

entity COMP_4BIT is
	port (A, B : in bit_vector(3 downto 0);
			AigB, AmaiorB, AmenorB : out bit);
end COMP_4BIT;

architecture ckt of COMP_4BIT is

signal AmaiorB_aux : bit;
signal AigB_aux : bit;

begin

	AigB_aux <= (A(3) xnor B(3)) and (A(2) xnor B(2)) 
				and (A(1) xnor B(1)) 
				and (A(0) xnor B(0));
	
	
	AmaiorB_aux <= (A(3) and not B(3)) 
				or (A(2) and not B(2) and (A(3) xnor B(3)))
				or (A(1) and not B(1) and (A(3) xnor B(3)) and (A(2) xnor B(2))) 
				or (A(0) and not B(0) and (A(3) xnor B(3)) 
					and (A(2) xnor B(2)) and (A(1) xnor B(1)));

	AmenorB <= AigB_aux nor AmaiorB_aux;

	AigB <= AigB_aux;
	AmaiorB <= AmaiorB_aux;
	

end ckt;

--==============================================================================================
--				LOGICA DO PASSO CRESCENTE
--==============================================================================================
entity SMEIO is
	port (A, B : in bit;
			S, Co : out bit);
end SMEIO;

architecture ckt of SMEIO is

	begin 
		S <= A xor B;
		Co <= A and B;

end ckt;

entity SCOMP is
	port( A, B, Ci : in bit;
			Co, S : out bit);
end SCOMP;

architecture ckt of SCOMP is

	begin

		S <= A xor B xor Ci;
		Co <= (A and B) or (A and Ci) or (B and Ci);
		
end ckt;

entity ADD4 is
	port(A, B : in bit_vector(3 downto 0);
			Co : out bit;
		 	S : out bit_vector(3 downto 0));
end ADD4;

architecture ckt of ADD4 is

	component SMEIO is
		port (A, B : in bit;
			S, Co : out bit);
	end component;

	component SCOMP is
		port( A, B, Ci : in bit;
			Co, S : out bit);
	end component;

	signal Carry : bit_vector(3 downto 0);

	begin

		R0 : SMEIO port map (A(0), B(0), S(0), Carry(0));
		R1 : SCOMP port map (A(1), B(1), Carry(0), Carry(1), S(1));
		R2 : SCOMP port map (A(2), B(2), Carry(1), Carry(2), S(2));
		R3 : SCOMP port map (A(3), B(3), Carry(2), Carry(3), S(3));
		
end ckt;

--==============================================================================================
--				LOGICA DO PASSO DECRESCENTE
--==============================================================================================
entity SUBMEIO is
	port (A , B : in bit;
			S, Tout : out bit);
end SUBMEIO;

architecture ckt of SUBMEIO is

	begin
		S <= (not A) and B;
		Tout <= A xor B;

end ckt;

entity SUBCOMP is
	port(A, B : in bit;
		Tin : in bit;
		S : out bit;
		Tout : out bit);
end SUBCOMP;

architecture ckt of SUBCOMP is

	begin
		S <= (A xor B) xor Tin;
		Tout <= ((not A) and B) or ((not A) and Tin) or (B and Tin);
end ckt;

entity SUB4 is
	port (A, B : in bit_vector(3 downto 0);
			Tout : out bit;
			S : out bit_vector(3 downto 0));
end SUB4;

architecture ckt of SUB4 is

	component SUBMEIO is
		port (A , B : in bit;
			S, Tout : out bit);
	end component;

	component SUBCOMP is
		port(A, B : in bit;
		Tin : in bit;
		S : out bit;
		Tout : out bit);
	end component;

	signal Borrow : bit_vector(3 downto 0);

	begin

		R0 : SUBMEIO port map (A(0), B(0), S(0), Borrow(0));
		R1 : SUBCOMP port map (A(1), B(1), Borrow(0), S(1), Borrow(1));
		R2 : SUBCOMP port map (A(2), B(2), Borrow(1), S(2), Borrow(2));
		R3 : SUBCOMP port map (A(3), B(3), Borrow(2), S(3), Borrow(3));

end ckt;

