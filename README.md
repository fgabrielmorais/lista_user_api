## 📱 Projeto: Gerenciamento de Dados e Conectividade (Flutter)

### 📝 Sumário

  * [💡 Visão Geral](https://www.google.com/search?q=%23-vis%C3%A3o-geral)
  * [🎯 Habilidades Demonstradas](https://www.google.com/search?q=%23-habilidades-demonstradas)
  * [⚠️ Aviso de Dependência](https://www.google.com/search?q=%23-aviso-de-depend%C3%AAncia)
  * [🚀 Estrutura do Projeto](https://www.google.com/search?q=%23-estrutura-do-projeto)
  * [⚙️ Detalhes Técnicos](https://www.google.com/search?q=%23-detalhes-t%C3%A9cnicos)
      * [1. Consumo de API e Múltiplos Modelos](https://www.google.com/search?q=%231-consumo-de-api-e-m%C3%BAltiplos-modelos)
      * [2. Verificação de Conectividade](https://www.google.com/search?q=%232-verifica%C3%A7%C3%A3o-de-conectividade)
      * [3. Persistência de Dados (Cache Seguro)](https://www.google.com/search?q=%233-persist%C3%AAncia-de-dados-cache-seguro)
  * [🛠️ Como Iniciar](https://www.google.com/search?q=%23-como-iniciar)

-----

### 💡 Visão Geral

Este projeto Flutter Front-End foi desenvolvido com o foco em **gestão de dados e resiliência de conectividade**. Ele simula um aplicativo que realiza requisições a uma API para obter diferentes conjuntos de dados (como uma lista de usuários ou dados monetários), que implementa soluções robustas para verificar o status da internet e persistir dados de forma segura (cache).

### 🎯 Habilidades Demonstradas

| Categoria | Habilidades |
| :---: | :---: |
| **Front-End** | Desenvolvimento de UI/UX em **Flutter**, manipulação de estados e *Widgets*. |
| **Comunicação** | Consumo de **API REST** com DIO e requisições específicas. |
| **Resiliência** | **Verificação em tempo real** da conexão à Internet (`dart:io`). |
| **Persistência** | Implementação de **Cache Seguro** de dados utilizando `flutter_secure_storage`. |
| **Arquitetura** | Organização do código em camadas (*Models, Controllers, Data*). |

-----

### ⚠️ Aviso de Dependência

> **Atenção:** A versão do cliente HTTP **DIO** utilizada neste projeto está **desatualizada**. Recomenda-se a atualização para a versão mais recente para garantir melhorias de segurança, performance e compatibilidade com as novas versões do Flutter.

-----

### 🚀 Estrutura do Projeto

A organização do projeto segue um padrão que separa claramente a interface de usuário da lógica de dados, garantindo um código modular e de fácil manutenção:

```
lib/
├── components/          # Widgets reutilizáveis (se houverem)
├── data/
│   ├── api.dart         # Configuração do cliente HTTP (DIO) e endpoints da API.
│   ├── cache.dart       # Lógica para escrita, leitura e limpeza de cache seguro.
│   ├── dataController.dart # Orquestração da lógica de negócio, chamadas à API e gestão de cache.
│   └── internet.dart    # Classe para verificação de conectividade.
├── model/
│   ├── listPersonmodel.dart # Estrutura da classe para a lista de usuários.
│   └── moneyModel.dart  # Estrutura da classe para a lista de dados monetários.
└── main.dart            # Ponto de entrada e configuração principal.
```

### ⚙️ Detalhes Técnicos

#### 1\. Consumo de API e Múltiplos Modelos

O `dataController.dart` é o ponto focal onde as requisições são disparadas, utilizando o **DIO** como cliente HTTP.

  * **Cliente HTTP:** O pacote **DIO** foi fundamental para lidar com as requisições assíncronas de forma robusta e eficiente.
  * **Modelagem:** Foram utilizados dois modelos distintos (`listPersonModel.dart` e `moneyModel.dart`) para estruturar e tipar os diferentes conjuntos de dados retornados pela API (como listas de usuários e informações financeiras), garantindo a integridade dos dados na aplicação.

#### 2\. Verificação de Conectividade

A resiliência da aplicação é garantida pela classe `CheckInternet` (`internet.dart`):

  * **Funcionalidade:** Antes de realizar chamadas à API, o método `checkConnection()` tenta uma comunicação direta com um endereço confiável (`google.com`).
 
#### 3\. Persistência de Dados (Cache Seguro)

A classe `SecureStorage` (`cache.dart`) é responsável por armazenar informações importantes localmente de forma segura.

  * **Tecnologia:** Utiliza o pacote **`flutter_secure_storage`**, que armazena dados em *key-value pairs* utilizando mecanismos nativos de segurança do sistema operacional.
  * **Funcionalidade:** Permite o armazenamento (`writeSecureData`) e recuperação (`readSecureData`) de dados que não devem ser expostos em cache comum. 

-----

### 🛠️ Como Iniciar

1.  **Clone o Repositório:**
    ```bash
    git clone https://github.com/fgabrielmorais/lista_user_api.git
    ```
2.  **Instale as Dependências:**
    ```bash
    flutter pub get
    ```
3.  **Execute o Aplicativo:**
    ```bash
    flutter run
    ```
