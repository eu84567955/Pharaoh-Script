# Pharaoh-Script

> 冒险樢单机版NPC脚本，如果觉得有什么好的想法或者创意可以提交NPC，一起打造一个有趣的NPC。
欢迎contribute、star、fork

## NPC相关

当前游戏集成Lua引擎，所有的NPC均采用Lua编写。
NPC路径 ：对应平台数据包位置：script/npc下

### 1.全平台路径支持
lua下引用其他文件的格式为：
> dofile("script/utils/npcHelper.lua")

为了进行全平台支持，改为 fullPath(your path) 对路径进行包装：

> dofile(fullPath("script/utils/npcHelper.lua"))

### 2.语法

#### 基本函数：
##### （1）解析代码篇


```lua
mapRef(mapId) 
解析mapId 所对应的地图名称

```



```lua
npcRef(npcId)
解析npcId 所对应的NPC名称
```



```lua
altItemRef(itemId)
解析itemId 所对应的名称
```


##### （2）文字颜色篇

```lua
red(text)
    使得包装的text为红色
blue(text)
    使得包装的text为蓝色
green(text)
    使得包装的text为绿色
purple(text)
    使得包装的text为紫色
```


##### （3）函数篇

```lua
addText("some text you want to say");
NPC对话框输出文字

choiceRef(lua table)
NPC出现选项

askYesNo()
NPC 弹出确定和否 
返回值 answer_yes or answer_no

sendOk()
NPC弹出确定按钮

sendNext()
NPC弹出下一步

sendBackNext()
NPC弹出上一步和下一步

sendBackOk()

NPC弹出上一步和OK

dispose() 
关闭对话
```
##### （4）角色函数

```lua
setMap（mapId）地图切换
giveMesos(meso) 给玩家金币
openShop(shopId) 打开一个商店窗口
```

```lua
getPlayer() 得到玩家在容器中的引用
当前玩家导出了一下的函数

setMp(value)
setHp(value)
getHp()
getMp()
getStat()
setStat(see : MapleStat)
setMap(mapId)
setLevel(levle)
gainExp(exp)
gainItem(itemId)
gainMeso(meso)
gainHp(hp)

```


同时为了方便进行角色属性值更改，角色拥有一下特征值

```lua
MapleStat = 
{
    SKIN=0,
    FACE=1,
    HAIR=2,
    LEVEL=3,
    JOB=4,
    STR=5,
    DEX=6,
    INT=7,
    LUK=8,
    HP=9,
    MAXHP=10,
    MP=11,
    MAXMP=12,
    AP=13,
    SP=14,
    EXP=15,
    FAME=16,
    MESO=17,
    PET=18,
    GACHAEXP=19,
    ITEM_LEVLE=20,
    ITEM_EXP=21
};

```

##### 下面给出一个NPC例子：


```lua
dofile(fullPath("script/utils/npcHelper.lua"))
function generateChoice(mapId, price)
    return makeChoiceData(mapRef(mapId) .. "(" .. price .. "金币) ", {mapId, price});
end

choices = {
    generateChoice(104000000,1200),
    generateChoice(101000000,100),
    generateChoice(103000000,800),
    generateChoice(100000000,1000),
    generateChoice(120000000,1000),
    generateChoice(910000000,1000),
};
addText("您好~！我是射手村中巴。你想不想又快捷又安全的到达其他地方去？那么请使用我们的出租车吧。它会马上将你送到你想去的地方，价格很便宜哦！");
sendNext();
addText("请选择你的目的地.\r\n");
addText(blue(choiceRef(choices)));
choice = askChoice();

data = selectChoice(choices, choice);
mapId, price = data[1], data[2];

addText("看来你已经在这里把事情办完了");
addText("你确定要去 " .. blue(mapRef(mapId)) .. "?");
addText("价格是" .. blue(price .. " 金币") .. ".\r\n");
answer = askYesNo();

if answer == answer_yes then
    if giveMesos(-price) then
        setMap(mapId);
    else
    addText("你好象没有足够的金币，这样的话，我不能为你服务");
        sendOk();
    end
    else
         addText("在这个村子里还有许多漂亮的景点，如果你想去其他地方，欢迎随时使用我们的出租车服务。");
    sendOk();
end
```
