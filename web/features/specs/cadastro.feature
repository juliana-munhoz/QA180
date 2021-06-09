#language:pt

Funcionalidade: Cadastro
    Sendo um músico que possui equipamentos musicais # o ator
    Quero fazer o meu cadastro no RockLov # a funcionalidade
    Para que eu possa disponibilizá-los para locação #valor de negocio agregado

    @cadastro
    Cenario: Fazer cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulario de cadastro:
            | nome           | email               | senha |
            | juliana munhoz | juliana@outlook.com | 1234  |
        Então sou redirecionado para o Dashboard

    Esquema do Cenario: Tentativa de Cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulario de cadastro:
            | nome         | email         | senha         |
            | <nome_input> | <email_input> | <senha_input> |
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | nome_input     | email_input         | senha_input | mensagem_output                  |
            |                | juliana@outlook.com | 1234        | Oops. Informe seu nome completo! |
            | Juliana Munhoz | juliana*outlook.com | 1234        | Oops. Informe um email válido!   |
            | Juliana Munhoz |                     | 1234        | Oops. Informe um email válido!   |
            | Juliana Munhoz | juliana@outlook.com |             | Oops. Informe sua senha secreta! |
