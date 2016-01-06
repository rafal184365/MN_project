showconsole()

myDir="./"

open(myDir .. "motor_test.fem")
--mi_saveas(myDir .. "temp.fem")
file="results.txt"
file_to_write=openfile(file,"w")
write(file_to_write,"kąt\tMoment sily[Nm]")
closefile(file_to_write)
alfa=40
tab = {}
for n = 1,10 do
	mi_analyze(3);
	mi_loadsolution();
	tab[n]={};
	tab[n][1] = (n-1)*alfa;
	mo_groupselectblock(1);
	tab[n][2] = mo_blockintegral(22);-- olicza calke  dla danego bloku   22: Steady-state weighted stress tensor torque
	mo_clearblock();
	mi_selectgroup(1);
	
		mo_showdensityplot(1,0,1,0,"bmag")
		mo_savebitmap(myDir.." kat " .. alfa*(n-1) .. ".bmp")	--zapis obrazu

	mi_moverotate(0,0,alfa,4);-- 4 oznacza ze chodzi o grupe
	mi_clearselected();
	file_to_write=openfile(myDir .. file,"a");
	write(file_to_write,"\n",tab[n][1],"\t",tab[n][2])
	closefile(file_to_write);

	
end
print("koniec")