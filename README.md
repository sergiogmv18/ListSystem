# Sistema_de_lista

- Sistema de cadastro de trarefas. Poderá realizar o cadastro de tarefas passando alguns dados como título e descrição, após cadastrar e selecionar algum item da lista,  poderá ter acesso às tarefas realizadas, podendo também editar e deletar caso desejado. Sistema_de_lista foi desenvolvido em flutter , usando o FireBase como banco de dados, todos os metodos tem sua própria documentação para melhor entendimento pode ler o exemplo de documentaçao: 
    /*
    * Resumo do que a funçao faz 
    * @author  inicial ou nome quen fez   - data 
    * @version 1.0   - 20230302 - initial release
    * @param   <tipo de variable> - nome da varivel    - o que esa variavel faz 
    * @return <tipo de retorno> resumo do retorno 
    */


## Organização 
Padrão de arquitetura MVC para organização das pastas, mudando um pouco o contexto mas respeitando a regra:
    - Models: entidades dos obj
    - Controller: controladores de cada obj e gerencionador de estados (provider)
    - helpers: services(session, metodos genericos)
    - Screen: todas as telas con nomes que representam o que elas fazem ou mostra
    - style: todos los stilos usados em tudo o app (Theme)
    - Components: components reusados global con nomes que representam ou fazem 

## Ofline
Despois que for inicializado terá todas as infomaçóes dentro de un banco de dados local feito con sql lite usando uma 'orm' chamado floor, caso o usuario faça alguma alteraçáo ou delete a tarefa sera salvada localmente e a cada  15 minutos terá un background fetch que se encarrega de tentar sincronizar os dados.  

## Fluxo
O sistema será inicializado com a tela de SplashScreen, carregando todas as dependências externas em caso de: 
- Error: mostrará uma mensagem custumizada de acordo com o erro  
- success: redirecionará para a pagina de homeScreen mostrando assim os dados do usuario
Estando na pagina de Home o usuario poderá alterar, criar, eliminar e mostrar todos os dados do usuario (CRUD), cada uma das telas conta com um nome específico segundo sua função com o regirterOrEdit; como o nome já fala registrará outra tarefa ou editará uma tarefa específica (o que muda entre uma e a outra sería que pasa o objeto, precisará confirmar para deletar).

## Outros
    - session: se tudo está certo ao inisializar o app criará uma session usando get it para não realizar request desnecessárias (a session será actualizada a cada request realizada. Exemplo: deletando, criando ou editando algum obj ), pode encontrar os métodos en helpers/services_locator
    - gerencionamento de estados: usando provider para a parte de traduções
    - traduções: o app conta con 2 idiomas sendo esses (en, pt_br) desta forma mantendo todo o código e texto numa linguagem única, pode encontrar os métodos en controller/provider
    - FunctionsClass: é uma clase com métodos genéricos que será usado por todo o app, pode encrontrar no helpers/fuctions_class
    - background_fetch: conseguir sincronizar en segundo plano com server firebase(caso tenha algua coisa para sincronizar)

# Requisitos do Sistema

- Linguagem Dart
- Firestore (Firebase) como banco de dados
- Utilizando animações
- Versionamento de código com Git
- caso altere os models, as querys ou database precisara rodar o comando :
    - flutter pub run build_runner build --delete-conflicting-outputs  
- documentação a serem lídas :
    - background_fetch: https://pub.dev/packages/background_fetch
    - floor: https://pub.dev/packages/floor
    