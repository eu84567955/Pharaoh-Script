dofile(fullPath("script/utils/npcHelper.lua"))
addText("您好~！您想挑战"..red("蜈蚣").."吗");
answer = askYesNo();
if answer == answer_yes then
	setMap(701010323);
else
	addText("请您想好后再做决定");
	sendOk();
end