class SignupPage
    include Capybara::DSL

    def open
        visit "/signup"
    end

    def create(user)
        find("#fullName").set user[:nome] #o find é do capybara e a busca é feita pelo css selector, por isso usa o #
        find("#email").set user[:email]
        find("#password").set user[:senha]
    
        click_button "Cadastrar"   
    end

end