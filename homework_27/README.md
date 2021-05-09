
1. Created the required docker images and containers.

2. Add ssh key to jenkins home to access vagrant nodes
Сделал не оч хорошим способом. Через гит в контейнер запушил ключ (т.е. дженкинс джоба выкачала репозиторий из гита с ключем, я скопировал куда надо). Понимаю, что это не секьюрно - предавать где-то в открытом виде ключ.

3. Create manual parameterized pipeline to validate you ansible playbook syntax using tools from previous HWs
4. Run ansible playbook from previous HWs. User name should be provided as parameter
На скриншоте пайплайн, одним степам делаю --check плейбука, следующим запускаю. хосты, плейбук и юзер параметризированы.

5. Create a schedule for you pipeline
Добавил запуск раз в час

6. Add slave node to your jenkins master via ssh. Use ansible to provision this node(can be vagrant instance)
7. Attach screenshots of you pipeline confiuration

  