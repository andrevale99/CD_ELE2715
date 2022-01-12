#include <algorithm>
#include <iostream>
#include <cstring>
#include <filesystem>

#include <unistd.h>

using std::strcmp;
using std::strlen;

namespace fs = std::filesystem;

struct Args
{

	// Nome do arquivo para criar o arquivo TESTBENCH.vhd para testar os circuitos
	char *make_testbench;

	// Local do arquivo que será criado
	char *path;

	//Arquivo para simulacao
	char *simu;
	
	//Nome do arquivo para ser o "work" (onde estarao os componentes)
	char *work_name;
	
	//Tempo de simulação
	char *time;
} args;

//============PROTOTIPOS==========================
void parse_Args(int &argc, char *argv[]);
bool find_homeBIN();
//================================================

int main(int argc, char *argv[])
{
	//Serve para debug para ver todas os argumentos
	if(argc > 2 && strcmp(argv[1], "--showArgs")==0)
	{
		for(int i=1; i < argc; ++i)
		{
			std::cout << argv[i] << '\n';
		}

	exit(0);
	}

	parse_Args(argc, argv);

	return 0;
}

//====================FUNÇÕES=====================

/**
 * @brief Verifica e coloca os argumentos passados nas variáveis
 *
 **/
void parse_Args(int &argc, char *argv[])
{
	if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)
	{
		std::cout << "\nUSAGE: ghdl_run [options] ....\n";
		std::cout << '\n';
		std::cout << "-h | --help"
				  << "\t\t\t"
				  << "Mensagem de Ajuda\n";

		std::cout << '\n';
		std::cout << "-T | --Testbench [Nome]"
			  << "\t\t"
		          << "Cria o exemplo arquivo TESTBENCH\n";

		std::cout << '\n';
		std::cout << "-p | --path [Diretorio]"
			  << "\t\t"
		   	  << "Especifica o diretorio para criacao de arquivo\n"
			  << "\t\t\t\t"
			  << "Default: Atual(./)\n";

		std::cout << '\n';
		std::cout << "-t | --time [ns, fs, s, ...]"
			  << "\t"
			  << "Tempo de simulacao\n"; 


		std::cout << '\n';
		std::cout << "-s | --simulation [Name]"
			  << "\t"
			  << "Nome do arquivo para simulacao no GTKwave\n";

		std::cout << '\n';

		exit(0);
	}

	else
	{
		for (short i = 1; i < argc; i += 2)
		{
			if (strcmp(argv[i], "-p") == 0 || strcmp(argv[i], "--path") == 0)
			{
				args.path = new char[strlen(argv[i + 1]) + 1];
				strcpy(args.path, argv[i + 1]);
			}

			if (strcmp(argv[i], "-T") == 0 || strcmp(argv[i], "--Testbench") == 0)
			{
				args.make_testbench = new char[strlen(argv[i + 1]) + 1];
				strcpy(args.make_testbench, argv[i + 1]);
			}

			if (strcmp(argv[i], "-t")==0 || strcmp(argv[i], "--time")==0)
			{
				args.time = new char[strlen(argv[i+1]+1)];
				strcpy(args.time, argv[i+1]);
			}
		
			if (strcmp(argv[i], "-s")==0 || strcmp(argv[i], "--simumation")==0)
			{
				args.time = new char[strlen(argv[i+1]+1)];
				strcpy(args.time, argv[i+1]);
			}
		}

		return;
	}
}

/**
 * @brief Verifica se existe o diretório /home/$USER/bin/
 * 	  pois será nessa pasta que estará o comando
 * 	  caso queira.
 * */
bool find_homeBIN()
{
	
}
