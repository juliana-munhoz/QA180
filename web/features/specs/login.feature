#language:pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da RockLov
    Para que eu possa anunciar meus equipamentos musicais

    @temp
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "juliana@yahoo.com" e "123"
        Então sou redirecionado para o Dashboard

    Esquema do Cenário: Tentar logar

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input          | senha_input | mensagem_output                  |
            | juliana@yahoo.com    | 1234        | Usuário e/ou senha inválidos.    |
            | juliana_12@yahoo.com | 123         | Usuário e/ou senha inválidos.    |
            | juliana*yahoo.com    | 1234        | Oops. Informe um email válido!   |
            |                      | 1234        | Oops. Informe um email válido!   |
            | juliana@yahoo.com    |             | Oops. Informe sua senha secreta! |


