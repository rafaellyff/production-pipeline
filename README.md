# Production Pipeline

This simple REST API, using Ruby on Rails, aims to create a platform to receive orders from other systems, group by batches and track orders in the production pipeline until dispatch.

Developed for the gocase selection process.

## Configs

- Ruby 2.6.5
- Rails 5.2.4
- PostgreSQL 

## Documentation

API documentation available in: https://app.swaggerhub.com/apis-docs/rafaellyff/production-pipeline-api/1.0.0

## Using for the first time

#### Install gems
> bundle install

With this command, you can install a list of necessary dependencies for the execution of this project.

#### Create Database
> rake db:create

Command to create database in postgres

#### Create Tables 
> rake db:migrate

After executing this command, you’ll have created all the tables in your project.

#### Populate Database
> rake db:seed

You’ll create false data in the database to test

#### Start Server
> rails s

Using this command, you can upload the project to the local server and your application will be ready for use at the URL http://localhost:3000/

## Running other times 

#### Start Server
> rails s

Using this command, you can upload the project to the local server and your application will be ready for use at the URL http://localhost:3000/


## Run code tests

#### All Tests
> bundle exec rspec 

#### Model Tests  

Order:
> bundle exec rspec spec/models/order_spec.rb

Batch:
> bundle exec rspec spec/models/batch_spec.rb

#### Request Tests
> bundle exec rspec spec/requests/orders_spec.rb

----------

## Considerações

Obrigada pela oportunidade de participar do processo seletivo e mais uma vez peço desculpas pelos imprevistos que aconteceram. Apesar de tudo, aprendi bastante fazendo a API, não só no que diz respeito à rails mas também treinando um pouco meu inglês (Tentei fazer o código e a documentação nele). 

Sobre os pontos de melhoria, acredito que os testes e tratamento de erros são tópicos que tive um contato mínimo durante na minha trajetória profissional, estou aprendendo um pouco mais agora e gostando bastante.

Apesar de não ter desenvolvido dessa forma, desenhei a modelagem como acredito que deveria ser em uma versão completa.
https://drive.google.com/file/d/1yKQN8fBez3uB-GXaif1uLkx9XHoRci2h/view?usp=sharing

Mais uma vez muito obrigada pela oportunidade de me desafiar e aprender! 

*Curiosidade: Projeto devesenvolvido em 15 horas e 50 minutos*
