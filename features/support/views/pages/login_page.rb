class LoginPage 

    include Capybara::DSL

    def open
        visit "/"
    end

    /page objects (mapeamento de elementos) e app actions
    implementar ações e funcionalidades nos metodos/
    def with(email,password)
        find("input[placeholder = 'Seu email']").set email
        find("input[type = password]").set password
        click_button "Entrar"
    end

       
end