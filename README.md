# QTrack — Sistema de Monitoramento de Qubits

O **QTrack** é um sistema completo de registro, telemetria e análise de dados físicos voltado ao monitoramento de hardware em processadores quânticos (QPUs), criostatos e qubits. Desenvolvido como projeto final para a disciplina de **Banco de Dados I** na **Universidade Federal de Santa Catarina (UFSC)**.

O sistema integra um banco de dados relacional **PostgreSQL**, uma API em **Node.js (Express)**, uma interface rica em **React (Vite)** e um **Copilot Inteligente** baseado na API do **Google Gemini** para traduzir perguntas em linguagem natural para consultas SQL em tempo real (NLP-to-SQL).

---

## 🚀 Funcionalidades Principais

* **Painel de Monitoramento (Dashboard):** Visualização em tempo real da integridade das QPUs, mapa topológico dos qubits, taxa de erro de portas e leituras de coerência.
* **Consultas Acadêmicas Complexas:** Interface dedicada para executar e plotar graficamente as 3 consultas complexas solicitadas no projeto.
* **Copilot Inteligente (NLP-to-SQL):** Chat interativo integrado com a API do Gemini que permite ao pesquisador consultar o banco de dados fazendo perguntas em português (ex: *"Quais qubits estão com status de Atenção na QPU Triton-20?"*).
* **Hot-Swap de Conexão no Frontend:** A aplicação não necessita de arquivos de configuração locais (como `.env`). Todas as credenciais do banco de dados e a chave de IA podem ser fornecidas e alteradas dinamicamente de forma visual diretamente na interface web.
* **Agente de Contingência Local:** Caso o limite de requisições ou cota da API do Gemini seja atingido, o sistema possui uma IA de contingência que responde localmente utilizando dados reais extraídos do banco de dados.

---

## 📁 Estrutura do Projeto

```text
QTrack_Project/
├── database/
│   └── ddl.sql                 # Script DDL de referência física (Usado apenas para documentação acadêmica; não é lido pela aplicação)
├── backend/
│   ├── server.js               # Servidor Express, rotas da API, conexão Postgres dinâmica e integração Gemini
│   ├── package.json
│   └── .env.example            # Exemplo de configuração de variáveis de ambiente (opcional)
└── frontend/
    ├── src/
    │   ├── App.jsx             # Componente React principal, telas de relatórios e modal de conexão
    │   ├── components/
    │   │   ├── Copilot.jsx     # Interface de chat e modal de configuração da API Key do Gemini
    │   │   ├── Heatmap.jsx     # Mapa visual de qubits do processador
    │   │   └── ...             # Componentes gráficos adicionais
    │   └── main.jsx
    ├── package.json
    └── index.html
```

---

## 🛠️ Tecnologias Utilizadas

* **Banco de Dados:** PostgreSQL (Tabelas, Chaves Estrangeiras, Restrições de Integridade e Funções de Janela SQL).
* **Backend:** Node.js, Express, `pg` (Postgres Client), `dotenv`, `cors`.
* **Frontend:** React, Vite, Recharts (para renderização de gráficos), Lucide React (ícones).
* **IA Generativa:** API do Google Gemini (`gemini-2.5-flash` / `gemini-2.5-pro`).

---

## 🔧 Configuração e Instalação (Zero-Config)

A aplicação foi projetada para iniciar sem a necessidade de criação de arquivos `.env` manuais no backend. Toda a parametrização inicial de conexão é feita diretamente pelo navegador.

### Pré-requisitos
* Node.js instalado (v18 ou superior).
* Banco de dados PostgreSQL rodando localmente ou em nuvem.

### 1. Inicializando o Backend
1. Navegue até a pasta `backend`:
   ```bash
   cd backend
   ```
2. Instale as dependências e inicie o servidor:
   ```bash
   npm install
   npm run dev
   ```
   Por padrão, o backend iniciará na porta `8000`. 
   
   *Nota:* O servidor tentará inicialmente se conectar a um banco local padrão com os dados `host: localhost, port: 5432, user: postgres, database: qtrack, password: 1234`. Se esses dados não forem válidos para o seu ambiente local, não se preocupe: você poderá ajustá-los em seguida pela interface.

### 2. Inicializando o Frontend
1. Em um novo terminal, navegue até a pasta `frontend`:
   ```bash
   cd frontend
   ```
2. Instale as dependências e inicie o servidor:
   ```bash
   npm install
   npm run dev
   ```
   A interface web abrirá por padrão em seu navegador no endereço `http://localhost:5173`.

### 3. Configurando Banco e IA pela Interface
Ao abrir a aplicação no navegador:
1. Acesse o menu de **Configurações** na barra lateral.
2. Clique em **⚙️ Configurar Credenciais de Conexão** e preencha as informações do seu PostgreSQL local (usuário, senha, nome do banco, host e porta). Ao salvar, o backend redefinirá a conexão instantaneamente.
3. No chat do **Copilot**, clique no alerta de configuração no cabeçalho e insira sua **Gemini API Key** (obtenha gratuitamente no Google AI Studio) para habilitar o chat inteligente. (Caso queira testar de forma simulada sem chave, digite `'mock'`).
4. *Populando os Dados:* Acesse a seção de carga na aplicação para rodar o seed e preencher o banco com dados simulados históricos de 105 dias de experimentos e calibrações.

---

## 🎓 Autores
* **Maria Eduarda Winkel de Mello Vianna** — UFSC (Engenharia de Computação)
* **Mateus Kramer de Oliveira** — UFSC (Engenharia de Computação)
