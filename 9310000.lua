dofile(fullPath("script/utils/npcHelper.lua"))
function generateChoice(mapId, price)
	return makeChoiceData(mapRef(mapId) .. "(" .. price .. "金币) ", {mapId, price});
end

choices = {
	generateChoice(701000000,1200)
};
addText("您好~！我能把帮您进行传送。");
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
