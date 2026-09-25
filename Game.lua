<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">

<title>ПВЗ ОТ КИРИЛЛА</title>

<style>
*{box-sizing:border-box;-webkit-tap-highlight-color:transparent}

body{
    margin:0;
    width:100%;
    height:100vh;
    background:#3b8f35;
    font-family:Arial;
    overflow:hidden;
}

button{
    width:300px;
    height:60px;
    margin:8px;
    display:flex;
    align-items:center;
    justify-content:center;
    border:3px solid #245c20;
    border-radius:15px;
    background:#70c451;
    color:white;
    font-size:24px;
    font-weight:bold;
}

button:active{transform:scale(.95)}

#menu{
    width:100%;
    height:100%;
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
}

#title{
    color:white;
    font-size:50px;
    font-weight:bold;
    margin-bottom:40px;
    text-align:center;
}

#levels{
    display:none;
    width:100%;
    height:100%;
    flex-direction:column;
    align-items:center;
}

#levels h1,
#plantChoose h1{
    color:white;
    margin:20px;
}

#levelList{
    width:90%;
    max-width:700px;
    display:grid;
    grid-template-columns:repeat(5,1fr);
    gap:10px;
    overflow-y:auto;
    flex:1;
}

.levelButton{
    width:100%;
    height:60px;
    margin:0;
    font-size:20px;
}

.levelButton.locked{
    background:#555;
    border-color:#333;
    color:#aaa;
}

#plantChoose{
    display:none;
    width:100%;
    height:100%;
    flex-direction:column;
    align-items:center;
}

#plantInfo{
    color:white;
    font-size:20px;
    margin-bottom:15px;
    text-align:center;
}

#plantCards{
    width:95%;
    display:flex;
    justify-content:center;
}

.plantCard{
    width:125px;
    height:135px;
    margin:0;
    flex-direction:column;
    font-size:18px;
}

.plantCard.selected{
    background:#e5d73e;
    color:#245c20;
    border-color:white;
}

.plantIcon{font-size:50px}

#game{
    display:none;
    width:100%;
    height:100%;
    background:#222;
    color:white;
    flex-direction:column;
    align-items:center;
}

#top{
    width:100%;
    min-height:75px;
    background:#4d8e30;
    border-bottom:4px solid #245c20;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:5px 10px;
}

#levelInfo,
#sun{
    font-size:22px;
    font-weight:bold;
}

#selected{
    display:flex;
    align-items:center;
}

.gameCard{
    width:65px;
    height:65px;
    margin:0;
    font-size:34px;
    opacity:.45;
}

.gameCard.selected{
    opacity:1;
    background:#e5d73e;
    color:#245c20;
}

#field{
    width:95%;
    max-width:700px;
    margin-top:25px;
    background:#74b94c;
    border:5px solid #245c20;
    position:relative;
    overflow:hidden;
}

#lane{
    width:100%;
    height:100px;
    display:grid;
    grid-template-columns:repeat(9,1fr);
}

.cell{
    border:1px solid rgba(0,0,0,.2);
    display:flex;
    align-items:center;
    justify-content:center;
    position:relative;
}

.cell:active{
    background:rgba(255,255,255,.2);
}

.plant{
    font-size:48px;
    position:relative;
    z-index:2;
}

#zombiesLayer{
    position:absolute;
    left:5px;
    right:5px;
    top:5px;
    height:100px;
    pointer-events:none;
}

.zombie{
    position:absolute;
    top:16px;
    right:0;
    font-size:55px;
    line-height:1;
    transition:right:.05s linear;
}

#message{
    margin-top:20px;
    font-size:21px;
    text-align:center;
    padding:0 10px;
}

#gameButtons{
    margin-top:auto;
    margin-bottom:15px;
}

#win,
#lose{
    display:none;
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.8);
    align-items:center;
    justify-content:center;
    flex-direction:column;
    z-index:10;
}

#win h1,
#lose h1{
    color:white;
    font-size:40px;
    text-align:center;
    margin:15px;
}

@media(max-width:600px){

    #title{font-size:35px}

    button{
        width:260px;
        height:55px;
        font-size:20px;
    }

    #levelList{
        grid-template-columns:repeat(4,1fr);
    }

    .levelButton{
        height:55px;
        font-size:18px;
    }

    #top{
        min-height:70px;
    }

    #levelInfo,
    #sun{
        font-size:18px;
    }

    .gameCard{
        width:55px;
        height:55px;
        font-size:28px;
    }

    #field{
        width:98%;
        margin-top:15px;
    }

    #lane{
        height:85px;
    }

    #zombiesLayer{
        height:85px;
    }

    .plant{
        font-size:40px;
    }

    .zombie{
        font-size:48px;
        top:13px;
    }
}
</style>
</head>

<body>

<div id="menu">

    <div id="title">ПВЗ ОТ КИРИЛЛА</div>

    <button onclick="openLevels()">
        ▶ ПРИКЛЮЧЕНИЯ
    </button>

    <button onclick="openMiniGame()">
        МИНИ ИГРЫ
    </button>

    <button onclick="openSettings()">
        ⚙ НАСТРОЙКИ
    </button>

</div>


<div id="levels">

    <h1>ПРИКЛЮЧЕНИЯ</h1>

    <div id="levelList"></div>

    <button onclick="backToMenu()">
        ← НАЗАД
    </button>

</div>


<div id="plantChoose">

    <h1>ВЫБЕРИТЕ РАСТЕНИЯ</h1>

    <div id="plantInfo">
        Можно взять или убрать Горохострел
    </div>

    <div id="plantCards">

        <button
            id="peaCard"
            class="plantCard selected"
            onclick="selectPea()">

            <div class="plantIcon">🌱</div>
            Горохострел
            <small>☀️ 100</small>

        </button>

    </div>

    <button onclick="startSelectedLevel()">
        ▶ НАЧАТЬ
    </button>

    <button onclick="backToLevels()">
        ← НАЗАД
    </button>

</div>


<div id="game">

    <div id="top">

        <div id="levelInfo">
            УРОВЕНЬ 1
        </div>

        <div id="sun">
            ☀️ 300
        </div>

        <div id="selected">

            <button
                id="gamePeaCard"
                class="gameCard selected"
                onclick="selectGamePea()">

                🌱

            </button>

        </div>

    </div>


    <div id="field">

        <div id="lane">

            <div class="cell" onclick="clickCell(0)"></div>
            <div class="cell" onclick="clickCell(1)"></div>
            <div class="cell" onclick="clickCell(2)"></div>
            <div class="cell" onclick="clickCell(3)"></div>
            <div class="cell" onclick="clickCell(4)"></div>
            <div class="cell" onclick="clickCell(5)"></div>
            <div class="cell" onclick="clickCell(6)"></div>
            <div class="cell" onclick="clickCell(7)"></div>
            <div class="cell" onclick="clickCell(8)"></div>

        </div>

        <div id="zombiesLayer"></div>

    </div>


    <div id="message">
        Поставьте Горохострел
    </div>


    <div id="gameButtons">

        <button onclick="backToLevels()">
            ← К УРОВНЯМ
        </button>

    </div>

</div>


<div id="win">

    <h1>🎉 УРОВЕНЬ ПРОЙДЕН!</h1>

    <button onclick="continueGame()">
        ▶ ПРОДОЛЖИТЬ
    </button>

</div>


<div id="lose">

    <h1>🧟 ЗОМБИ ДОШЁЛ ДО ДОМА!</h1>

    <button onclick="restartLevel()">
        🔄 ЗАНОВО
    </button>

    <button onclick="backToLevels()">
        ← К УРОВНЯМ
    </button>

</div>


<script>

let unlockedLevel =
    Number(localStorage.getItem("unlockedLevel")) || 1;

let currentLevel=1;

let selectedPea=true;
let gamePea=true;

let sun=300;

let plants=[];
let zombies=[];

let spawnTimer=null;
let moveTimer=null;
let shootTimer=null;

let spawned=0;
let maxZombies=6;

let playing=false;


/* МЕНЮ */

function openMiniGame(){
    alert("Здесь будут мини игры!");
}

function openSettings(){
    alert("Здесь будут настройки!");
}


/* УРОВНИ */

function openLevels(){

    document.getElementById("menu").style.display="none";
    document.getElementById("levels").style.display="flex";

    createLevels();
}

function createLevels(){

    let list=document.getElementById("levelList");

    list.innerHTML="";

    for(let i=1;i<=60;i++){

        let b=document.createElement("button");

        b.className="levelButton";

        if(i<=unlockedLevel){

            b.textContent="▶ "+i;

            b.onclick=()=>{
                startLevel(i);
            };

        }else{

            b.textContent="🔒 "+i;
            b.classList.add("locked");
            b.disabled=true;

        }

        list.appendChild(b);
    }
}


/* ЗАПУСК УРОВНЯ */

function startLevel(level){

    currentLevel=level;

    document.getElementById("levels").style.display="none";

    if(level===1){

        openPlantChoose();

    }else{

        document.getElementById("game").style.display="flex";

        document.getElementById("levelInfo").textContent=
            "УРОВЕНЬ "+level;

        document.getElementById("message").textContent=
            "Этот уровень пока в разработке";
    }
}


/* ВЫБОР ПЕРЕД УРОВНЕМ */

function openPlantChoose(){

    selectedPea=true;

    document.getElementById("peaCard")
        .classList.add("selected");

    document.getElementById("plantChoose").style.display="flex";
}


/* ВЗЯТЬ / УБРАТЬ ГОРОХ */

function selectPea(){

    selectedPea=!selectedPea;

    document.getElementById("peaCard")
        .classList.toggle("selected",selectedPea);
}


/* НАЧАТЬ */

function startSelectedLevel(){

    if(!selectedPea){

        alert("Выберите Горохострел!");

        return;
    }

    document.getElementById("plantChoose").style.display="none";

    document.getElementById("game").style.display="flex";

    startLevel1();
}


/* НАСТРОЙКА УРОВНЯ 1 */

function startLevel1(){

    stopGame();

    playing=true;

    sun=300;
    plants=[];
    zombies=[];
    spawned=0;
    maxZombies=6;
    gamePea=true;

    document.getElementById("sun").textContent=
        "☀️ "+sun;

    document.getElementById("levelInfo").textContent=
        "УРОВЕНЬ 1";

    document.getElementById("message").textContent=
        "Выберите Горохострел и поставьте его";

    document.getElementById("gamePeaCard")
        .classList.add("selected");

    document.querySelectorAll(".cell").forEach(c=>{
        c.innerHTML="";
    });

    document.getElementById("zombiesLayer").innerHTML="";

    /* Первый зомби появляется через 2 секунды */
    setTimeout(()=>{
        if(playing) spawnZombie();
    },2000);

    spawnTimer=setInterval(()=>{

        if(!playing)return;

        if(spawned<maxZombies){
            spawnZombie();
        }else{
            clearInterval(spawnTimer);
        }

    },4000);

    moveTimer=setInterval(moveZombies,50);

    shootTimer=setInterval(shootPlants,700);
}


/* КАРТОЧКА В ИГРЕ */

function selectGamePea(){

    gamePea=!gamePea;

    document.getElementById("gamePeaCard")
        .classList.toggle("selected",gamePea);
}


/* КЛИК ПО КЛЕТКЕ */

function clickCell(index){

    if(!playing)return;

    let old=plants.find(p=>p.cell===index);

    /* Если растение уже есть — убрать его */
    if(old){

        old.el.remove();

        plants=plants.filter(p=>p!==old);

        sun+=100;

        document.getElementById("sun").textContent=
            "☀️ "+sun;

        document.getElementById("message").textContent=
            "Горохострел убран!";

        return;
    }

    /* Если растение не выбрано */
    if(!gamePea){

        document.getElementById("message").textContent=
            "Сначала выберите Горохострел!";

        return;
    }

    /* Недостаточно солнца */
    if(sun<100){

        document.getElementById("message").textContent=
            "Недостаточно солнца!";

        return;
    }

    sun-=100;

    document.getElementById("sun").textContent=
        "☀️ "+sun;

    let el=document.createElement("div");

    el.className="plant";
    el.textContent="🌱";

    document.querySelectorAll(".cell")[index]
        .appendChild(el);

    plants.push({
        cell:index,
        el:el
    });

    document.getElementById("message").textContent=
        "Горохострел установлен!";
}


/* СОЗДАНИЕ ЗОМБИ */

function spawnZombie(){

    if(spawned>=maxZombies)return;

    spawned++;

    let el=document.createElement("div");

    el.className="zombie";
    el.textContent="🧟";

    document.getElementById("zombiesLayer")
        .appendChild(el);

    zombies.push({
        el:el,
        hp:100,
        right:0,
        speed:0.9
    });
}


/* ДВИЖЕНИЕ ЗОМБИ */

function moveZombies(){

    if(!playing)return;

    let layer=document.getElementById("zombiesLayer");

    let maxRight=
        layer.clientWidth;

    for(let i=zombies.length-1;i>=0;i--){

        let z=zombies[i];

        z.right+=z.speed;

        let maxPos=
            maxRight-z.el.offsetWidth;

        if(z.right>=maxPos){

            loseLevel();

            return;
        }

        z.el.style.right=z.right+"px";
    }
}


/* СТРЕЛЬБА ВСЕХ ГОРОХОВ */

function shootPlants(){

    if(!playing)return;

    if(plants.length===0)return;

    if(zombies.length===0)return;

    for(let p of plants){

        let target=zombies[0];

        /* Ближайший к дому зомби */
        for(let z of zombies){

            if(z.right>target.right){
                target=z;
            }

        }

        target.hp-=20;

        if(target.hp<=0){

            killZombie(target);
        }
    }

    if(zombies.length>0){

        document.getElementById("message").textContent=
            "Атака! Зомби: "+
            zombies[0].hp+" HP";
    }
}


/* УБИТЬ ЗОМБИ */

function killZombie(z){

    if(!zombies.includes(z))return;

    z.el.remove();

    zombies=zombies.filter(x=>x!==z);

    if(
        spawned>=maxZombies &&
        zombies.length===0
    ){

        winLevel();

    }
}


/* ПОБЕДА */

function winLevel(){

    if(!playing)return;

    playing=false;

    stopGame();

    if(
        currentLevel===unlockedLevel &&
        unlockedLevel<60
    ){

        unlockedLevel++;

        localStorage.setItem(
            "unlockedLevel",
            unlockedLevel
        );
    }

    document.getElementById("win")
        .style.display="flex";
}


/* ПОРАЖЕНИЕ */

function loseLevel(){

    if(!playing)return;

    playing=false;

    stopGame();

    document.getElementById("lose")
        .style.display="flex";
}


/* ЗАНОВО */

function restartLevel(){

    document.getElementById("lose")
        .style.display="none";

    startLevel1();
}


/* ПОСЛЕ ПОБЕДЫ */

function continueGame(){

    document.getElementById("win")
        .style.display="none";

    backToLevels();
}


/* ОСТАНОВКА ИГРЫ */

function stopGame(){

    clearInterval(spawnTimer);
    clearInterval(moveTimer);
    clearInterval(shootTimer);

    spawnTimer=null;
    moveTimer=null;
    shootTimer=null;
}


/* В МЕНЮ */

function backToMenu(){

    playing=false;
    stopGame();

    document.getElementById("menu").style.display="flex";
    document.getElementById("levels").style.display="none";
    document.getElementById("plantChoose").style.display="none";
    document.getElementById("game").style.display="none";
    document.getElementById("win").style.display="none";
    document.getElementById("lose").style.display="none";
}


/* К УРОВНЯМ */

function backToLevels(){

    playing=false;
    stopGame();

    document.getElementById("game").style.display="none";
    document.getElementById("plantChoose").style.display="none";
    document.getElementById("win").style.display="none";
    document.getElementById("lose").style.display="none";

    document.getElementById("levels").style.display="flex";

    createLevels();
}


createLevels();

</script>

</body>
</html>
