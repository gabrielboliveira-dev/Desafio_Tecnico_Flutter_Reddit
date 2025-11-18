# Desafio Técnico: Reddit Client (Flutter)

## Contexto

Este aplicativo é um cliente de leitura leve para o Reddit. Ele consome a API pública (JSON) para exibir as postagens "Hot" de um subreddit específico (ex: `r/flutterdev`) e permite visualizar os detalhes e comentários de uma postagem.

O foco principal é o **parsing complexo de JSON** e a apresentação de listas de conteúdo gerado pelo usuário.

## 🚀 Requisitos Funcionais

1.  **Feed do Subreddit:**
    * Carregar postagens "Hot" de um subreddit padrão (ex: `flutterdev`).
    * Exibir cards com: Título, Autor, Número de Upvotes (Score) e Thumbnail (se houver).
2.  **Detalhes do Post:**
    * Ao clicar, abrir uma tela com o conteúdo completo (texto ou imagem).
    * Carregar e listar os comentários principais do post.
3.  **Pull-to-Refresh:** Permitir atualizar a lista arrastando para baixo.

## 🛠️ Tecnologias Utilizadas

* **Flutter (SDK)**
* **Provider** (Gerenciamento de Estado)
* **http** (API REST)
* **intl** (Formatação de números)
* **url_launcher** (Para abrir links externos)

## 🎯 Objetivos de Aprendizado (Clean Architecture)

* **JSON Parsing Avançado:** Lidar com a estrutura `kind/data` do Reddit e listas heterogêneas.
* **Tratamento de Thumbnails:** O Reddit retorna strings como "self", "default" ou URLs reais. O app deve saber distinguir.
* **Listas Mistas:** Renderizar posts que podem ser apenas texto, imagens ou links.

## Endpoints (JSON Público)

* **Feed:** `https://www.reddit.com/r/{subreddit}/hot.json`
* **Comentários:** `https://www.reddit.com{permalink}.json`
