# Sistema_de_lista

- Sistema de cadastro de Anotações.poderá realizar o cadastro de algumas anotações passando alguns dados como nome , email , título e a anotação desejada, após cadastrar e selecionar algum item da lista,  poderá ter acesso às anotações realizada, podendo também editar e deletar se desejado. Sistema_de_lista foi desenvolvido em flutter , usando o FireBase como banco de dados, todos os metodos tem sua propia documentação para melhor entendimento pode ler para melhor entendimento exemplo de documentaçao: 
    /*
    * Resumo do que a funçao faz 
    * @author  inicial ou nome quen fez   - data 
    * @version 1.0   - 20230302 - initial release
    * @param   <tipo de variable> - nome da varivel    - o que esa variavel faz 
    * @return <tipo de retorno> resumo do retorno 
    */


## Organiçaçao 
Padrão de arquitetura MVC para organização das pastas, mudando um pouco o contexto mas respeitando a regra:
    - Models: entidades dos obj
    - Controller: controladores de cada obj e gerencionador de estados (provider)
    - helpers: services(session, metodos genericos)
    - Screen: todas as telas con nomes que representam o que elas fazem ou mostra
    - style: todos los stilos usados em tudo o app (Theme)
    - Components: components reusados global con nomes que representam ou fazem 

## Segurança
- Firebase storage é cryptografado con uma chave ja registrada manualmente no app salvada internamente na execuçao do app em flutter secure storage, a key tem um tamanho de 32 bytes. e o iv : de 16
- storage ofline, caso o usuario tente realizar alguma alteração ou criação, sera criado un arquivo txt com shared preferences chamado "storageOfline" tambem crypto so que essa chave é gerada dinamicamente ao instalar o app e sera salva no flutter secure storage, 
- Para fazer a parte de criptografia foi usadaas dependencias encrypt e steel_crypt em sua ultimas verções
- os metodos relacionados a criptogrfia pode ser encontrados em controller/cryptoController

##  Documentação 
- Diagrama de secuencias referente a cada request feita para o firebase (dar uma olhada para entender o que se recebe e envia para ser salvado)

## Fluxo
O sistema seá inicializado com a tela de SplashScreen, sendo carregada todas as dependcias externas caso: 
- Error: mostrará um mensage custumizado dependendo do erro 
- success: redireccionará para a pagina de homeScreen mostrando assim os dados do usuario
Estando na pagina de Home o usuario podera alterar, criar, eliminar e mostrar todos los dados do usuario (CRUD), Cada uma das screen conta com o nome especifico com a sua função con o regirterOrEdit, como o nome ja fala registrara otra --- ou edita uma --- specifca o que muda de uma e a outra seria que pasa o parametro id, precisará comfirmar para deletar 

## Outros
    - session: se tudo esta certo ao inisializar o app criará uma session usando get it para nãp realizar request desnecesarias (a session sera actualizada a cada request realizada exemplo: deletando, creando o editado algum obj ), pode encontrar os metodos en helpers/services_locator
    - gerencionamento de estados: usando provider para a parte de traduçoes e para realizar o search na pagina de home pode encontrar os metodos en controller/provider
    - traduções: o app conta con 2 idiomas soportados sendo estos (en, pt_br) para assim conseguir manter tudo o codigo e texto numa lenguagen so, pode encontrar os metodos en controller/provider
    - FunctionsClass: é uma clase com metodos genericos que sera usado por tudo o app pode encrontrar no helpers/fuctions_class

# Requisitos do Sistema

- Linguagem Dart
- Firestore (Firebase) como banco de dados
- Utilizando animações
- Versionamento de código com Git