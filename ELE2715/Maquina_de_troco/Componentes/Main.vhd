--POSSUI ERRO NA LOGICA PARA TRANSITAR PARA 
--O PROXIMO ESTADO

entity MAIN is
	port (	clk : in bit;
			clear : in bit;
			load_cx : in bit;
			iniciar : in bit_vector(3 downto 0);
			troco_real : in bit_vector(9 downto 0);
			load_reg : in bit;
			c1, c2, c3, c4, c5, c6 : in bit_vector(5 downto 0);
			v_temp_out : out bit_vector(9 downto 0));
end MAIN;

architecture ckt of MAIN is

	component CALC is
		port (	clk : in bit;
				qtde_cx : in bit_vector(5 downto 0);
				est_at : in bit_vector(3 downto 0);
				est_cf : in bit_vector(3 downto 0);
				prox_est_in : in bit_vector(3 downto 0);
				clr : in bit;
				v_temp_out : in bit_vector(9 downto 0);
				valor : in bit_vector(9 downto 0);
				valor_cx : in bit_vector(9 downto 0);
				c_temp : out bit_vector(5 downto 0);
				prox_est_out : out bit_vector(3 downto 0);
				v_temp_in : out bit_vector(9 downto 0);
				enable : out bit);
	end component;

	component MUX4B4S is
		port ( I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16 : in bit_vector(3 downto 0);
				S : in bit_vector(3 downto 0);
				Q : out bit_vector(3 downto 0));
	end component;

	component MUX10B3S is
		port ( I1, I2, I3, I4, I5, I6, I7, I8 : in bit_vector(9 downto 0);
				S : in bit_vector(2 downto 0);
				Q : out bit_vector(9 downto 0));
	end component;

	component MEM6LD is
		port (	Y : in bit_vector(5 downto 0);
				 clk, ld, clr : in bit;
				Q : out bit_vector(5 downto 0));
	end component;

	component  REG4B is
		port (	clk : in bit;
				estados_in : in bit_vector(3 downto 0);
				estados_o : out bit_vector(3 downto 0));
	end component;

	component MEM10 is
		port (	Y : in bit_vector(9 downto 0);
				clk, clr, en : in bit;
				Q : out bit_vector(9 downto 0));
	end component;

	signal en01 : bit;
	signal en02 : bit;
	signal en03 : bit;
	signal en04 : bit;
	signal en05 : bit;
	signal en06 : bit;

	signal en_mem10 : bit;

	signal qtc1 : bit_vector(5 downto 0);
	signal qtc2 : bit_vector(5 downto 0);
	signal qtc3 : bit_vector(5 downto 0);
	signal qtc4 : bit_vector(5 downto 0);
	signal qtc5 : bit_vector(5 downto 0);
	signal qtc6 : bit_vector(5 downto 0);

	signal out_mux_v_tem_in : bit_vector( 9 downto 0);

	signal estado_atual : bit_vector(3 downto 0);
	signal estado_atual_in_mux10b3s : bit_vector(2 downto 0);
	
	signal prox_estado : bit_vector(3 downto 0);

	signal c1_temp : bit_vector(5 downto 0);
	signal c2_temp : bit_vector(5 downto 0);
	signal c3_temp : bit_vector(5 downto 0);
	signal c4_temp : bit_vector(5 downto 0);
	signal c5_temp : bit_vector(5 downto 0);
	signal c6_temp : bit_vector(5 downto 0);

	signal est_out01 : bit_vector(3 downto 0);
	signal est_out02 : bit_vector(3 downto 0);
	signal est_out03 : bit_vector(3 downto 0);
	signal est_out04 : bit_vector(3 downto 0);
	signal est_out05 : bit_vector(3 downto 0);
	signal est_out06 : bit_vector(3 downto 0);

	signal v_temp_in_01 : bit_vector( 9 downto 0);
	signal v_temp_in_02 : bit_vector( 9 downto 0);
	signal v_temp_in_03 : bit_vector( 9 downto 0);
	signal v_temp_in_04 : bit_vector( 9 downto 0);
	signal v_temp_in_05 : bit_vector( 9 downto 0);
	signal v_temp_in_06 : bit_vector( 9 downto 0);

	signal v_temp_out_aux : bit_vector(9 downto 0);

	begin
		en_mem10 <= en01 or en02 or en03 or en04 or en05 or en06;

		estado_atual_in_mux10b3s(0) <= estado_atual(0);
		estado_atual_in_mux10b3s(1) <= estado_atual(1);
		estado_atual_in_mux10b3s(2) <= estado_atual(2);

		REGEST : REG4B port map(clk, prox_estado, estado_atual); 

		MEM10_VALOR : MEM10 port map (out_mux_v_tem_in, clk, clear, en_mem10, v_temp_out_aux);

		C1_INPUT : MEM6LD port map (c1, clk, load_cx, '1', qtc1);
		C2_INPUT : MEM6LD port map (c2, clk, load_cx, '1', qtc2);
		C3_INPUT : MEM6LD port map (c3, clk, load_cx, '1', qtc3);
		C4_INPUT : MEM6LD port map (c4, clk, load_cx, '1', qtc4);
		C5_INPUT : MEM6LD port map (c5, clk, load_cx, '1', qtc5);
		C6_INPUT : MEM6LD port map (c6, clk, load_cx, '1', qtc6);

		CALC_C1 : CALC port map (clk, qtc1, estado_atual, "0001", "0010", clear, v_temp_out_aux, troco_real, "0001100100", c1_temp, est_out01, v_temp_in_01, en01);
		CALC_C2 : CALC port map (clk, qtc2, estado_atual, "0010", "0011", clear, v_temp_out_aux, troco_real, "0000110010", c2_temp, est_out02, v_temp_in_02, en02);
		CALC_C3 : CALC port map (clk, qtc3, estado_atual, "0011", "0100", clear, v_temp_out_aux, troco_real, "0000011001", c3_temp, est_out03, v_temp_in_03, en03);
		CALC_C4 : CALC port map (clk, qtc4, estado_atual, "0100", "0101", clear, v_temp_out_aux, troco_real, "0000001010", c4_temp, est_out04, v_temp_in_04, en04);
		CALC_C5 : CALC port map (clk, qtc5, estado_atual, "0101", "0110", clear, v_temp_out_aux, troco_real, "0000000101", c5_temp, est_out05, v_temp_in_05, en05);
		CALC_C6 : CALC port map (clk, qtc6, estado_atual, "0110", "0111", clear, v_temp_out_aux, troco_real, "0000000001", c6_temp, est_out06, v_temp_in_06, en06);
		
		MUX4B4S_OUT : MUX4B4S port map (iniciar, est_out01, est_out02, est_out03, est_out04, est_out05, est_out06, "0000", "0000", "0000", "0000", "0000", "0000", "0000", "0000", "0000",  estado_atual, prox_estado);
		MUX10B3S_OUT : MUX10B3S port map ("0000000000", v_temp_in_01, v_temp_in_02, v_temp_in_03, v_temp_in_04, v_temp_in_05, v_temp_in_06, "0000000000", estado_atual_in_mux10b3s, out_mux_v_tem_in);
		
		
		v_temp_out <= v_temp_out_aux;
		
		--port (	clk : in bit;
		--		qtde_cx : in bit_vector(5 downto 0);
		--		est_at : in bit_vector(3 downto 0);
		--		est_cf : in bit_vector(3 downto 0);
		--		prox_est_in : in bit_vector(3 downto 0);
		--		clr : in bit;
		--		v_temp_out : in bit_vector(9 downto 0);
		--		valor : in bit_vector(9 downto 0);
		--		valor_cx : in bit_vector(9 downto 0);
		--		c_temp : out bit_vector(5 downto 0);
		--		prox_est_out : out bit_vector(3 downto 0);
		--		v_temp_in : out bit_vector(9 downto 0);
		--		enable : out bit);
end ckt;