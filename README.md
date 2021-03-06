# Morse code receiver, ie converter of Morse code to characters/numbers.

### Team members

* Drápal Jakub (různé části kódu)
* Foltyn Ondřej (různé části kódu)
* Fyman Mikuláš (různé části kódu)


### Table of contents

* [Project objectives](#objectives)
* [Hardware description](#hardware)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Video](#video)
* [References](#references)

<a name="objectives"></a>

## Project objectives

Našim úkolem bylo přeložit vstup zadaný pomocí tlačítek v podobě Morseova kódu, tento vstup přeložit do písmen a čísel a přeložený výstup zobrazit na sedmisegmentovém displeji. 

<a name="hardware"></a>

## Hardware description

Pro tento projekt byla použita deska **Nexys A7-50T**.
Deska Nexys A7 je kompletní platforma pro vývoj digitálních obvodů připravená k použití, založená na nejnovějším Artix-7™ Field Programmable Gate Array (FPGA) od Xilinx®. Díky velkému, vysokokapacitnímu FPGA, velkorysým externím pamětem a sbírce USB, Ethernet a dalších portů může Nexys A7 hostit návrhy od úvodních kombinačních obvodů až po výkonné vestavěné procesory. Několik vestavěných periferních zařízení, včetně akcelerometru, teplotního senzoru, digitálního mikrofonu MEM, zesilovače reproduktorů a několika I/O zařízení, umožňuje použití Nexys A7 pro širokou škálu návrhů, aniž by potřeboval další komponenty.
![deska](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/images/NexysA7.jpg)

<a name="modules"></a>

## VHDL modules description and simulations

### Clock-enable 
V clock-enable používáme lokální proměnnou s_cnt_local, která čítá náběžné hrany clocku. Při překročení nastavené úrovně sepne výstup ce_o. Používáme ho ke zpomalení signálu clock. Z něj vysíláme signál, pomocí kterého čítáme dobu po kterou je zmáčknuté tlačítko na zadávání znaků. 

[Clock-enable module](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/projekt4/project_4/project_hlavni.srcs/sources_1/new/clock_enable.vhd)


![tb_clock-enable](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/images/tb_clock_enable.png)
*záznam původního průběhu clock-enable*

### Decoder
V dekodéru jsme na vstup přivedli tlačítko na zadávání znaků, tlačitko pro mezeru mezi znaky a tlačítko pro překlad. Tlačítko pro zadávání znaků je připojeno k čítači, který čítá dobu zmáčknutí tlačítka, tuto dobu vyhodnotí a na základě podmínky určí znak (tečka nebo čárka). Tečka je definována jako nula, čárka jako jednička. Signál z čítače jde do Shift-registru, kde se zapisují hodnoty za sebe. Dále máme čítač znaků, které čítá pomocí náběžných hran tlačíka mezery. Signály z Shift-registru a čítače znaků posílá po stisknití tlačítka pro překlad do sedmisegmentového displeje. V dekodéru je druhý Shift-registr, pomocí kterého rozsvicujeme LED diody (dvě ze tří pro čárku, jedna ze tří pro tečku). Tyto LEDky se postupně posouvájí pomocí tlačítka pro mezeru.

[Decoder module](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/projekt4/project_4/project_hlavni.srcs/sources_1/new/decoder.vhd)

### Sedmisegmenotý displej
Výstupní kód z dekodéru se rozdělí podle počtu znaků a dále je přeložen a zobrazen na displeji.

[7seg module](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/projekt4/project_4/project_hlavni.srcs/sources_1/new/hex7seg.vhd)
<a name="top"></a>

## TOP module description and simulations
V top modulu jsme propojili moduly mezi sebou a výstupy z modulů se sedmisegmentovým displejem, LED diodami a tlačítka se vstupy dekodéru. 
[Top module](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/projekt4/project_4/project_hlavni.srcs/sources_1/new/top.vhd)



[Prototyp kódu na EDA Playground](https://www.edaplayground.com/x/WCaS)
![Simulace](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/images/decoder.png)
*Výsledná simulace prototypu*

[Schéma Top modulu](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/images/schema.png)
<a name="video"></a>

## Video
 Na videu je vidět zadávání znaků a nasledné zobrazení pomocí LED. Bohužel, nám nefunguje překlad z morseovy abecedy do normální abecedy a zobrazení na displeji. 
 
[Odkaz na video](https://www.youtube.com/watch?v=4p4m_nwOK4c)

<a name="references"></a>
 
## References
- minulé cvika
- [Github pana Frýzy](https://github.com/tomas-fryza/digital-electronics-1)
- [Deska Nexys A7](https://digilent.com/reference/programmable-logic/nexys-a7/start)
