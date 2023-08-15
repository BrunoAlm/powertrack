class AppwriteMessage {
  String translateMessage(String message) {
    String messageTranslated = message.toString();
    switch (messageTranslated) {
      case 'Invalid credentials. Please check the email and password.':
        return 'Usuário ou senha inválidos!';
      case 'Param "email" is not optional.':
        return 'Preencha o email.';
      case 'Param "password" is not optional.':
        return 'Preencha a senha.';
      case 'Invalid password: Password must be at least 8 characters':
        return 'Senha inválida: Precisa de pelo menos 8 caracteres';
      case 'Invalid email: Value must be a valid email address':
        return 'Insira um email válido';
      case 'O computador remoto recusou a conexão de rede.':
        return 'Sem conexão com o servidor!';
      case 'A user with the same email already exists in your project.':
        return 'Email já registrado!';
      case '':
        return 'Falha ao comunicar com o servidor!';
      case 'Rate limit for the current endpoint has been exceeded. Please try again after some time.':
        return 'Muitas tentativas. Tente novamente mais tarde.';
      case 'The current user session could not be found.':
        return 'Erro inexplicável 🤣';
      case 'Invalid password: Password must be at least 8 characters and should not be one of the commonly used password.':
        return 'Senha precisa de pelo menos 8 caracteres e não pode ser comum.';
      case "Failed host lookup: 'console.brunoalm.online'":
        return 'Sem conexão com a internet';
      default:
        messageTranslated = 'Erro não tratado 😅';
    }
    return messageTranslated;
  }
}
