# FENIX HUB V2.0

Interface modular Lua para Roblox, com visual escuro vermelho/laranja e layout adaptável.

## Estrutura
- `loader.lua`: carrega os módulos e a interface a partir do GitHub RAW.
- `interface.lua`: interface, navegação, sliders, avisos, minimizar/reabrir e FPS.
- `modules/player.lua`: informações do jogador.
- `modules/movement.lua`: controles locais de velocidade e pulo.
- `modules/settings.lua`: preferências da sessão.
- `modules/visual.lua`: paleta visual.
- `modules/notifications.lua`: notificações.

## Instalação
Envie os arquivos mantendo os caminhos e substitua o conteúdo do repositório. O endereço do loader continua:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptgif/Universal-Lua/refs/heads/main/loader.lua"))()
```

## Observações importantes
- Movimento é destinado somente a experiências próprias ou ambientes em que você tenha autorização.
- A aba Combat contém indicadores demonstrativos; não executa mira automática ou automação de combate.
- ESP universal não foi implementado. Recursos de visualização de jogadores devem ser feitos no código da experiência própria/autorizada.
- Persistência em arquivo depende de recursos específicos do executor e ainda não está habilitada.
- Compatibilidade com Arceus X e Delta precisa ser validada em testes reais; não é garantida apenas pela edição dos arquivos.
