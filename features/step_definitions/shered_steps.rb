Então('sou redirecionado para o Dashboard') do
    expect(@dash_page.on_dash?).to be true # o expect é do rspec e o page do capybara
end

Então('vejo a mensagem de alerta: {string}') do |expect_alert|
    @alert.dark
end
  