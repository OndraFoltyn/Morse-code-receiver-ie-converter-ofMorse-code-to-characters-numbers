# Morse code receiver, ie converter of Morse code to characters/numbers.

### Team members

* Drápal Jakub (responsible for )
* Foltyn Ondřej (responsible for )
* Fyman Mikuláš (responsible for )


### Table of contents

* [Project objectives](#objectives)
* [Hardware description](#hardware)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Video](#video)
* [References](#references)

<a name="objectives"></a>

## Project objectives

Našim úkolem bylo přeložit vstup zadaný pomocí tlačítek v podobě Morseova kódu, tento vstup přeložit do písmen a čísel a přeložený výstup zobrazit na sedmi-segmentovém displeji. 

<a name="hardware"></a>

## Hardware description

Pro tento projekt byla použita deska **Nexys A7-50T**.
Deska Nexys A7 je kompletní platforma pro vývoj digitálních obvodů připravená k použití, založená na nejnovějším Artix-7™ Field Programmable Gate Array (FPGA) od Xilinx®. Díky velkému, vysokokapacitnímu FPGA, velkorysým externím pamětem a sbírce USB, Ethernet a dalších portů může Nexys A7 hostit návrhy od úvodních kombinačních obvodů až po výkonné vestavěné procesory. Několik vestavěných periferních zařízení, včetně akcelerometru, teplotního senzoru, digitálního mikrofonu MEM, zesilovače reproduktorů a několika I/O zařízení, umožňuje použití Nexys A7 pro širokou škálu návrhů, aniž by potřeboval další komponenty.
![deska](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/images/NexysA7.jpg)

<a name="modules"></a>

## VHDL modules description and simulations

### Clock-enable 
V clock-enable používáme lokální proměnnou s_cnt_local, která čítá náběžné hrany clocku. Při překročení nastavené úrovně sepne výstup ce_o. Používáme ho ke zpomalení signálu clock. 

![clock](https://github.com/OndraFoltyn/Morse-code-receiver-ie-converter-ofMorse-code-to-characters-numbers/blob/main/projekt4/project_4/project_hlavni.srcs/sources_1/new/clock_enable.vhd)
### Sedmisegmenotý displej


### Decoder

<a name="top"></a>

## TOP module description and simulations

Write your text here.

<a name="video"></a>

## Video

Write your text here

<a name="references"></a>

## References

1. Write your text here.

