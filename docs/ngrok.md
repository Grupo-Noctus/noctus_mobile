
# 🚀 Como Usar o Ngrok para Expor sua API Local

## 📥 Instalação

Você pode instalar e executar o Ngrok de duas formas:

### ✅ 1. Usando o terminal com Node.js:
```cmd
npx ngrok
```

### 📎 2. Baixando manualmente:
Acesse: [https://ngrok.com/download](https://ngrok.com/download)

Após o download, extraia o `.zip` e entre na pasta do executável. Geralmente está em (se baixado via npx):
```cmd
cd %USERPROFILE%\AppData\Roaming\ngrok
```

**💡 Dica:**  
Se quiser rodar o Ngrok de qualquer lugar do terminal, adicione essa pasta ao `PATH` do sistema:

1. Pressione `Win + R`, digite `sysdm.cpl` e vá em **Variáveis de Ambiente**.
2. Em **Path**, adicione o caminho completo para a pasta onde está o `ngrok.exe`.

---

## 🔐 Autenticação

Você precisará de uma conta no Ngrok para gerar um token de autenticação.

### 📝 1. Crie sua conta:
Acesse: [https://dashboard.ngrok.com/signup](https://dashboard.ngrok.com/signup)

### 🔑 2. Pegue seu token:
Disponível em: [https://dashboard.ngrok.com/get-started/your-authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)

### ✅ 3. Configure seu token no terminal:
```cmd
ngrok config add-authtoken <seu_token_aqui>
```

---

## 🚀 Iniciando o Ngrok

Para rodar a API local que está, por exemplo, na porta `3000`:

```cmd
ngrok http 3000
```

Você verá uma resposta parecida com:

```cmd
Forwarding    https://abcd1234.ngrok.io -> http://localhost:3000
```

Esse link (`https://abcd1234.ngrok.io`) será o endpoint público que outras pessoas (ou apps móveis) poderão acessar.

---

## 🛠️ Atualize a URL no App

No seu projeto Flutter ou mobile, vá até o arquivo:

```
lib/utils/api_config.dart
```

E altere a variável `baseUrl` para o link gerado pelo Ngrok:

```dart
const String baseUrl = 'https://abcd1234.ngrok.io';
```

---

## ⚠️ Observações importantes

- 🔄 Sempre que reiniciar o Ngrok, ele irá gerar um **novo link**, a não ser que você tenha um **subdomínio pago**.
- 🪟 Mantenha o terminal com o Ngrok aberto. Fechar o terminal encerra a conexão pública.
- 💻 Se estiver usando `npx`, os arquivos temporários podem ser salvos em:
  ```
  C:\Users\<seu-usuário>\AppData\Roaming\npm-cache
  ```
