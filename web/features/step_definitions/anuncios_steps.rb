Dado("Login com {string} e {string}") do |email, password|
  @email = email

  @login_page.open
  @login_page.with(email, password)

  #checkpoint para garantir que esta no Dashboard
  expect(@dash_page.on_dash?).to be true
end

Dado("que acesso o formulário de cadastro de anúncios") do
  @dash_page.goto_equipo_form
end

Dado("que eu tenho o seguinte equipamento:") do |table|
  @anuncio = table.rows_hash

  #@anuncio= table.hashes.first

  MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end

Quando("submeto o cadastro desse item") do
  @equipos_page.create(@anuncio)
end

Então("devo ver esse item no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Então("deve conter a mensagem de alerta: {string}") do |expect_alert|
  expect(@alert.dark).to have_text expect_alert
end

# Remover anuncios

Dado("que eu tenho um anúncio à remover:") do |table|
  user_id = page.execute_script("return localStorage.getItem('user')")

  #preparando a massa de teste, consumindo a api com integração com httparty
  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  EquiposService.new.create(@equipo, user_id)

  visit current_path
end

Quando("eu solicito a remoção desse anúncio") do
  @dash_page.request_removal(@equipo[:name])
  sleep 1 #think time
end

Quando("confirmo a remoção") do
  @dash_page.confirm_removal
end

Então("o item não deve ser exibido no Dashboard") do
  expect(@dash_page.has_no_equipo?(@equipo[:name])).to be true
end

#desistir da remocao
Quando("não confirmo a remoção") do
  @dash_page.cancel_removal
end

Então("este item deve permanecer no Dashboard") do
  expect(@dash_page.equipo_list).to have_content @equipo[:name]
end
