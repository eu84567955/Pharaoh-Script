--[[

转职NPC

--]]

dofile(fullPath("script/utils/npcHelper.lua"))
function generateChoice(jobId, name)
	return makeChoiceData(name, {jobId, name});
end

choicesBeginner = {
	generateChoice(100,"战士"),
	generateChoice(200,"魔法师"),
	generateChoice(300,"弓箭手"),
	generateChoice(400,"飞侠"),
	generateChoice(500,"海盗"),
};

choicesWarrior = {
	generateChoice(110,"剑客"),
	generateChoice(120,"准骑士"),
	generateChoice(130,"枪战士"),
};

choicesMagican = {
	generateChoice(210,"火毒法师"),
	generateChoice(220,"冰雷法师"),
	generateChoice(230,"牧师"),
};

choicesBowman = {
	generateChoice(310,"猎人"),
	generateChoice(320,"弩弓手"),
};

choicesThief = {
	generateChoice(410,"刺客"),
	generateChoice(420,"侠客"),
};

choicesPirate= {
	generateChoice(510,"拳手"),
	generateChoice(520,"火枪手"),
};




addText("您好欢迎来到"..red("法老王冒险岛\r\n").."我这里可以为您提供转职服务哦！");
sendNext();
local player = getPlayer();
local jobId = player.getJob();

local status = 1;

if player.getLevel() >= 10 and (not player.isFourth()) then


	if player.getLevel() >= 70 and (not player.isThird()) then
		addText("恭喜您已经到达了70级，您需要现在进行三转吗？")
		answer = askYesNo();
		if answer == answer_yes then
			jobId = jobId+1;
			player.changeJob(jobId)
			addText("转职成功！加油锻炼，当你变的强大的时候记的来找我哦！")
		else
			addText("想好了在来找我哦")
		end
		sendOk();
		return
	end
	
	if player.getLevel() >= 120 then
		addText("恭喜您已经到达了120级，您需要现在进行四转吗？")
		answer = askYesNo();
		if answer == answer_yes then
			jobId = jobId+1;
			player.changeJob(jobId)
			addText("转职成功！恭喜您完成了所有的转职")
		else
			addText("想好了在来找我哦")
		end
		sendOk();
		return
	end
	

	addText("请选择你要转的职业哦.\r\n");
	local selChoice = nil;
	if jobId == 0 then
		selChoice = choicesBeginner;
		addText(blue(choiceRef(selChoice)));
	end
	
	if player.getLevel() >= 30 then
		if jobId == 100 then
			selChoice = choicesWarrior;
			addText(blue(choiceRef(choicesWarrior)));
		elseif jobId == 200 then
			selChoice = choicesMagican;
			addText(blue(choiceRef(choicesMagican)));
		elseif jobId == 300 then
			selChoice = choicesBowman;
			addText(blue(choiceRef(choicesBowman)));
		elseif jobId == 400 then
			selChoice = choicesThief;
			addText(blue(choiceRef(choicesThief)));
		elseif jobId == 500 then
			selChoice = choicesPirate;
			addText(blue(choiceRef(choicesPirate)));
		else
			log("目前不支持这个职业转职哦~");
			return
		end
	end
	
	choice = askChoice();
	data = selectChoice(selChoice, choice);
	newJob , name = data[1],data[2];

	if newJob == 200 then
		addText("我们需要集结魔法师的精神力去封印魔王的力量,#b管理员#k 正在与魔王对抗,我们应该尽快赶过去支援他,因此你必须比其他职业提前进行修炼并领悟魔法的精髓,这是一条艰苦的道路,那么你想成为 #b魔法师#k 吗？");
	else
		addText("你确定要转职成为"..red(name).."吗？")
	end
	answer = askYesNo();
	if answer == answer_yes then
		player.changeJob(newJob)
		addText("转职成功！加油锻炼，当你变的强大的时候记的来找我哦！")
		sendOk()
	else
		addText("想好了在来找我哦~")
	end
elseif player.isFourth() then
	addText("您无需转职~");


else
	addText("等级不够哦~");
end

