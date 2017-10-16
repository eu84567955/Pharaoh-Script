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
