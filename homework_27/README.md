
1. Created the required docker images and containers.

 Тут всё ок, работает в джокере дженкинс.

 ![1](https://user-images.githubusercontent.com/18323106/117574019-cf7be480-b0e3-11eb-8a7c-c6bbc4352a06.png)
 Вот докерфайл

 ![1_2](https://user-images.githubusercontent.com/18323106/117574061-ffc38300-b0e3-11eb-8902-bebd774a6078.png)

2. Add ssh key to jenkins home to access vagrant nodes

 Сделал не оч хорошим способом. Через гит в контейнер запушил ключ (т.е. дженкинс джоба выкачала репозиторий из гита с ключем, я скопировал куда надо). Понимаю, что это не секьюрно - предавать где-то в открытом виде ключ.

 ![2](https://user-images.githubusercontent.com/18323106/117574067-07832780-b0e4-11eb-946a-55087c9942b3.png)

3. Create manual parameterized pipeline to validate you ansible playbook syntax using tools from previous HWs

4. Run ansible playbook from previous HWs. User name should be provided as parameter

3-4 пункты сделал в одном пайплайне. Снчала идёт --check плэйбука, потом запускаю плейпук с пингом.На саммо деле там выбор плейбука, в том числе и добавил возможность выбирать плейбук с установкой джавы. короче работает.

![3](https://user-images.githubusercontent.com/18323106/117574117-474a0f00-b0e4-11eb-9a7e-ba4c5dd10a43.png)

![3_2](https://user-images.githubusercontent.com/18323106/117574119-49ac6900-b0e4-11eb-9445-2c31312271a3.png)
 
5. Create a schedule for you pipeline

Добавил запуск раз в час![5](https://user-images.githubusercontent.com/18323106/117574138-5fba2980-b0e4-11eb-8b38-10931fbaf104.png)

6. Add slave node to your jenkins master via ssh. Use ansible to provision this node(can be vagrant instance)

Добавил слейв ноду, ранаю пайплайны с неё. Работает.

![6_1](https://user-images.githubusercontent.com/18323106/117574209-b58ed180-b0e4-11eb-8980-54bbd46d40b1.png)

Настраивал таким пайплайном. Тут ставится и джава и энсибл

![6](https://user-images.githubusercontent.com/18323106/117574326-49f93400-b0e5-11eb-81c3-efeb9d526ad4.png)

7. Attach screenshots of you pipeline confiuration
  
