extends ItemList

# --- Configuration Settings ---
# Drag and drop your custom modal scene file into this slot via the Inspector
@export var modal_scene: PackedScene

func _ready() -> void:
	max_columns = 2
	same_column_width = true

func _on_item_list_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	if not _mouse_button_index == MOUSE_BUTTON_LEFT:
		return
		
	if not modal_scene:
		push_error("Modal scene asset is missing from the ItemList Inspector!")
		return
		
	# 1. SLICE FLAT INDEX INTO EXPLICIT COORDINATES
	var current_row: int = index / max_columns    # Drops remainder (The item entry level)
	var current_column: int = index % max_columns # Extracts remainder (0 = Left, 1 = Right)
	
	# 2. FETCH CELL-SPECIFIC DATA PAYLOAD
	var unique_payload: Dictionary = _get_cell_data(current_row, current_column)
	
	if unique_payload.is_empty():
		return
		
	# 3. INSTANTIATE AND SPAWN POPUP MODAL OVERLAY
	var active_modal = modal_scene.instantiate()
	get_parent().get_parent().get_parent().get_parent().add_child(active_modal)
	
	if active_modal.has_method("populate_modal_data"):
		active_modal.populate_modal_data(unique_payload)

# --- Cell-Level Unique Database Matrix ---
func _get_cell_data(row: int, column: int) -> Dictionary:
	
	if row == 0:
		if column == 0:
			return {
				"title": "Category Context: Casing",
				"desc": "Why this is first in the list:\nIt's the physical size limitation of your computer build. As far as I know, currently there are E-ATX, ATX, mATX and ITX builds all pertaining to different sizes of motherboards. This part will also tell you what size of Graphics Card you can put in it properly. It's also your expression of aesthetics like color, shape, material and so on and most importantly protection against the elements. Or go caseless which some call the benchtest setup if you can trust your system is safe in open-air. From environmental factors, kids, animals, insects, accidental water spills or dust and so on.",
				"image_path": "res://assets/parts/casing_category.png"
			}
		elif column == 1:
			return {
				"title": "My Casing: Inplay Meteor 02 White",
				"desc": "Just need a protective case for mine:\nNot much to say here other than it's basic and has good airflow or places to attach fans to. Built this PC around Covid Pandemic's 1st Season of Stay at Home and until now the Tempered Glass is still intact with it's orginal screws. It has rubber standoffs or feet so it's not laid flat on the floor which would probably make it more susceptible to damage or quakes if so. Easy to open up and clean.",
				"image_path": "res://assets/parts/my_casing.png"
			}
			
	elif row == 1:
		if column == 0:
			return {
				"title": "Category Context: Central Processors (CPUs)",
				"desc": "System Pipeline Allocation:\nThe CPU dictates your memory frequencies and bus speed layout limits. Secure core throughput targets before mapping tertiary peripherals. Second because it depends on what programs you want to run and it will decide the type of motherboard you'll have to get next because CPUs have different slot size or shapes. The higher in price you go, you can expect the higher the price of the other components will be as well for optimal or avoiding bottlenecks around a certain ratio per class/level of computing.",
				"image_path": "res://assets/parts/cpu_category.png"
			}
		elif column == 1:
			return {
				"title": "My CPU: AMD Ryzen 5 5500",
				"desc": "Personal Justification:\nAt the time this was the priciest I could afford forgoing the APU capaibility to focus on more compute powah~! APUs are the part or what some of CPUs are called when they can process display or video even without a Graphics Card. Usually marked in the CPU Model name with a letter like 'G', in the case of Ryzen but IIRC it's the same for Intel, at the end of the CPU's complete name. And this one doesn't have that so I won't get any display output if my GPU breaks. APUs originally had to have the monitor cable attached to the motherboard's video out to be used as the graphics process instead of the video card. But nowadays, if you have both. You can set them in software. I recently just came across a post asking about this. And by default, software supposedly handles this automatically to your dedicated graphics or GPU if it detects that there is one and it's working. So in that post's state, it seems like the gpu was faulty and the graphics processing went on falling back onto the back up graphics processer which is the APU. I can't remember exactly what applications or software that allows you to choose the graphics processer you want to use with an application without ever having to reconnect the monitor cable to the motherboard or videa card ports. But back then, that feature wasn't a thing yet, you had to swap the connection if you want to use the other graphics processor. Explaining the Classes? Like the difference betwen Ryzen 3 or 5 or 7 and Intel i3 or i5 or i7 and so on; they're essentially all the exact same architectural blueprint in construction. Difference being in the manufacturing process because of them being very small parts inside, some break. And depending on the amount that is broken, they get classified in those tiers. Until a new set of generation comes and they also do the whole 'binning' to classify again as i3 or i5 and so on.",
				"image_path": "res://assets/parts/my_cpu.png"
			}
	elif row == 2:
		if column == 0:
			return {
				"title": "Category Context: CPU Cooler/Fan",
				"desc": "Required:\nBut what type of it depends on the tier of the CPU. Never bought a high tier CPU that doesn't come with a cooler. I heard the Huge 'Tower' Heatsink Blocks with Fans are quite effective but that looks of that thing mounted sideways worries me, so might want to have the case sit sideways. I presumed they should always should come with a tailor made cooler by the same manufacturer of the CPU or at least have a version of it that does. But apparently at those prices, your on your own and presumed to know what you are doing.",
				"image_path": "res://assets/parts/cpucooler_category.png"
			}
		elif column == 1:
			return {
				"title": "My CPU Cooler: Wraith Stealth bundled with the CPU",
				"desc": "Mine came with the stock cooler:\nAnd personally if the temperatures get too high, it just means a thermal paste replacement is due. Never in software usage have I pushed a CPU to extreme temperatures unless that thermal paste is due for replacement but then again I mostly just play in the 1080p resolution of games and don't really do much CPU intensive applications. And I don't run stress testing or benchmarking applications that long. Only time I ever do stress testing is when undervolting RAMs, GPU and CPU or so. Before that I was overclocking when I felt like I need to squeeze out more performance.",
				"image_path": "res://assets/parts/my_cpucooler.png"
			}
	elif row == 3:
		if column == 0:
			return {
				"title": "Category Context: Graphical Processors (GPUs)",
				"desc": "IMPORTANT IF YOU ARE UPGRADING GPUs at the END OF THIS TEXT BLOCK:\nReal Life Graphics Emulation? Large Number Computing? 3D Rendering? This part is normally picked after you selected your CPU if you actually need it, and with respect to your case's dimensions. Whether you're fine with just an APU/CPU/iGPU or need a dedicated Processor for computing at this age and era- The 3D(imitating physical world graphics with higher pixel counts) or virtual worlds where a lot of heavy-duty games are or maybe you deal with large number crunching stuff like video rendering or streaming which is kind of like an on-the-fly video-sources-remixing/recording in real time to streaming video. When choosing a GPU you'll want to check your Motherboard's PCI-e Slot for it. The difference in performance could either be negligble or noticeable depending on the setup like a x8 only lane GPU that is PCI-e 5(theoretical) on a PCI-e 3 only Motherboard slot will definitely be not performing at full performance capability that it should be able to. !IMPORTANT! If you don't have a APU for your computer to fall back on for graphics processing or visual output to your monitor, and you are planning on changing out your GPU. Right before you swap out the GPUs, first run DDU or DisplayDriverUninstaller to fully remove that old GPUs driver that may conflict with the new GPU once that is mounted. Right after the Uninstallation of the driver, you shold shut your computer off or before starting the uninstallation check the settings of DDU to ensure that the computer either Shuts Down Automatically or Not At All and NOT To Reboot. If the option to automatically Shut Down is not there then just manually Shut it down yourself. Once it is off, you can remove the old GPU and plug in your new GPU. First boot up with that new GPU will be the Operating System loading Generic Drivers for that GPU IF it can't find in it's online database a latest stable driver version for it which it would automatically install instead. Modern Operating Systems have this feature now but back then, boy the horror. Although old hardware like that still exists out there so that might still apply. Take this as a 'Cautionary Tale'. GPUs also need Thermal Repasting from time to time.",
				"image_path": "res://assets/parts/gpu_category.png"
			}
		elif column == 1:
			return {
				"title": "My GPU: Zotac Mini GTX 1070 8GB",
				"desc": "Personal Justification:\nWhen I was allowed as a young boy to build my own PC after training in dad's workplace where I fixed some PSUs and built some PCs(Pentiums). The 1080 was the latest product then and it was my dream GPU. This 1070 isn't that far off in performance considering it's from the same architecture. I do have a RTX 2070 Super with me right now that has an odd issue that I might be able to repair soon. Zotac likes MAXXING their versions like Xiaomi Mi Max lines of phones(Full Aluminum Body). This GPU has a 256-Bus Width and uses all x16 PCIe lanes so even if it only has 8GB of VRAM, it can process a lot of data at once compared to the other variants of it's kind. It's only dual fan too so size factor.",
				"image_path": "res://assets/parts/my_gpu.png"
			}
	elif row == 4:
		if column == 0:
			return {
				"title": "Category Context: Random Access Memory (RAM)",
				"desc": "Temporary Data/App/File Storage for Faster Loading:\nEver experienced loading a gigantic word or office file like a 'x.ppt or x.pptx'(Try stuffing in a ton of videos in it. Then check it's file size and compare it to your RAM Size, once it's bigger than your RAM Size, try opening it. My experience with this led my system back then to crash but only every time it tries to load that file.) and it crashes your PC? You need more RAM. The ram loads everything that you need to have fast retrieval to when running apps and opening files on your computer and only retrieves stuff from the ROM or SDD/HDD when it has to which then transfers it to itself for faster transmission of data and in the whole data storm, data that is deemed no longer need in the ram gets replaced with the data from ROM that is expected to be needed(look-ahead?). So when there's not enough RAM Capacity to load a single file into it along with the application needed to operate on that file where the fast loading is needed, the system crashes unless it has a safety mechanic or way to handle that instead of just crashing. When it comes to the Speed Indicator(MHz), check your CPU and Motherboard's supported speeds. It's not totally plug and play as well, in that by default it's always set to around 2400MHz or so even if the rating you got is higher, you have to set it manually in the bios to activate that rated speed. You could also undervolt these but I guess there's not much benefit to it other than maybe when it's acting up at default voltages due to long time usage? Might be saved by an undervolt but thats UV/OC territory and you'd have to test configurations for stability if there's even any left.",
				"image_path": "res://assets/parts/ram_category.png"
			}
		elif column == 1:
			return {
				"title": "My RAMs: DDR4-3200MHz Kingston HyperX Fury RGB-8GB(Samsung Die) x2",
				"desc": "GPUs have their RAM too -> VRAM:\nThe Samsung Die is the actual chip inside the ram and it's like silicon lottery since I am not sure if there are people out there shopping for this part and deliberately trying to figure out which company/manufacturer made the chips inside before even buying. These are modular I guess but the motherboard and it's bios version might still be required to support DDRX(Haven't gotten into looking into DDR5) and so. These also have different size factors but as far as I know, 2 of them, one mostly the smaller(SODIMM) in laptops but also in OptiFlex Dells? Then the usual Desktop PC size like your DDR4s. If you want to make sure that you get something that is compatible or works with your build, you'll want to look into your motherboard's QVL list or list of tested RAMs for that motherboard, usually on the motherboard manufacturer's website where you would also get the bios update instructions if you need to when upgrading OTHER parts that needs it; CPU mainly, GPU and RAM maybe, PSU? no. More on that on the Motherboard Section.",
				"image_path": "res://assets/parts/my_ram.png"
			}
	elif row == 5:
		if column == 0:
			return {
				"title": "Category Context: Motherboard (Holds Every Part Together)",
				"desc": "IMPORTANT:\nThis is like the 3rd part most people see in your Computer Setup. 1st the Casing, 2nd the GPU and then the Giant Board that this is unless you are on a very small form factor build. READ TO THE END: People usually look into these for stuff like quality of components/durability, features like how many and what type of ports(USB/HDMI/...) and version of those ports, built-in networking card or if you would need an external WiFi/Bluetooth Dongle, number of PCIe Slots for maybe dual GPU(Crossfire and SLI?) or dual M.2 Storage Drives, even Dual CPUs(Epyc and ThreadRippers) and RGB/ARGB/Fan Headers and their locations on the board if you are into that and planning your lighting placements/cabling and lastly aesthetics on how they look. The box looks cool too. Since you've read to this point you just saved yourself some major headache which is if you are planning on changing out this part, know that if you were using a legitimate 'Windows' license(one tied to a microsoft account where it will show under your devices on their website, singling out your motherboard name for a reason) with the motherboard you are wanting to replace; you won't be able to easily boot back into your OS. That is because 'Windows' ties the first motherboard's HWID or it's Metadata to that license and saves that on your OS and their servers. This is a non-issue if you use Linux though, and if your Windoes License isn't legitimate anyway, pirated, cracked or provided without an actual activation key then you can just get another one of that. As for your files, you can still get them back; just connect your ROM/Storage to another PC and you should be able to still access them hopefully without any special software. Maybe even through cellphone via USB-OTG and M.2/SATA to USB Adapter. You'll have to reinstall the OS though and in the process wipe all of it's contents so back them up first if they matter to you. So take note of that when choosing a Motherboard, consider possible upgrades and impossible upgrades like different CPU Socket Shapes(AM4!=AM5 | LGA1700!=LGA1851). Knowing how to use the command line interface or the 'Hackur Monitor' to copy files is good. Pretty sure they still have these; the CR2032 Battery that was widely used in watches back then, this is a separate DC Power Source for your Motherboard(Apart from your PSU which converts AC to DC) to keep the Bios Settings in it's own little memory(That's why to reset the BIOS Settings without actually accessing the interface to edit them, you remove this battery for a few seconds then put them back in.) AND run an internal clock. If you notice that your computer gets out of sync with time or clock when it is not connected to the internet, that is because this battery is low and getting out of sync. Today's computer clocks mostly no longer need to rely on this part of the purpose of the battery because they can just sync to NTP Servers online but that would need the internet to be available to the PC at least periodically when it checks if the time is still right. Bios Versions; some parts like CPU gets released after the time your motherboard is designed and released or distributed for selling to the public. If that CPU has the same socket(Synonymous to Same Generation) as your CPU, it might still need a Bios Version Update first to work.\n[url=https://www.asrock.com/mb/amd/b450m%20steel%20legend/#CPU][b][color=blue]Checking which Bios Version for specific CPUs ON 'MY MOTHERBOARD'.[/color][/b][/url], | \n[url=https://www.asrock.com/mb/amd/b450m%20steel%20legend/#BIOS1][b][color=blue]Bios Versions for Download[/color][/b][/url], | \n[url=https://www.asrock.com/mb/amd/b450m%20steel%20legend/#MemoryCEZ][b][color=blue]Tested Memory Sticks List for My Motherboard + Cezanne(CPU) Combo[/color][/b][/url] |",
				"image_path": "res://assets/parts/motherboard_category.png"
			}
		elif column == 1:
			return {
				"title": "My Motherboard: ASRock Steel Legend B450m White",
				"desc": "Thanks JJ!:\nDuring the time I was building this PC, a friend happened to be upgrading theirs so I got this off him for a friendly price along with a CPU and RAM sticks that later got replaced. So far gotten 2 WindowsOS Licenses attached on it somehow. They're pretty cheap when bought as keys only online. Your jaws would drop if you saw the price on those physical disc installers back then. X'D",
				"image_path": "res://assets/parts/my_motherboard.png"
			}
	elif row == 6:
		if column == 0:
			return {
				"title": "Category Context: Read Only Memory (Storage HDD/SDD)",
				"desc": "Databanks:\nThese are larger than RAM sizes since they are intended to hold the data for as long as they can so they prioritize mainly capacity over speed in making these. Thanks to SSDs though we now have much faster option! Just note that apparently SSDs will lose all stored data if not powered for more than a year or so unlike HDDs that has magnetic discs inside where the data is literally carved via laser onto the disk. These also has reading/writing speed ratings and cables have to be upto par with those too or that becomes a limiter to this device though they usually come with their bundled cables unless you're buying from the secondhand market then Godspeed~",
				"image_path": "res://assets/parts/rom_category.png"
			}
		elif column == 1:
			return {
				"title": "My ROM / Storage: ADATA SX8100NP 1TB M.2 NVMe SSD",
				"desc": "[url=https://www.techpowerup.com/ssd-specs/xpg-sx8100-1-tb.d166][b][color=blue]This[/color][/b][/url] is my first SSD:\nAnd dang the speed is real, hard to believe 1TB is still somehow not enough for me despite living through olden days where these were much smaller in available capacities and speeds. M.2 has different keying in their connection so make sure you get the correct one for your slot on your motherboard or external case. It connects directly to the Motherboard without the need for cables too so. SPEEED~",
				"image_path": "res://assets/parts/my_rom.png"
			}
	elif row == 7:
		if column == 0:
			return {
				"title": "Category Context: SSD Shield",
				"desc": "Kind of Optional?:\nThey supposed to help dissipate heat from it but you can have lighting on these too like what I have. MORE RGB/ARGB Header connections!! Careful putting this on your SSDs. Electronics rule of thumb, you don't need heavy force on the boards or the electronic parts or even on their connections, unless if it's the 12-Pin Power Connector of the PSU to Motherboard then I guess yeah.",
				"image_path": "res://assets/parts/ssdshield_category.png"
			}
		elif column == 1:
			return {
				"title": "My SSD Shield: Coolmoon ARGB NVMe SSD Heatsink with ARGB",
				"desc": "[url=https://shopee.ph/Coolmoon-Rgb-Argb-Led-M.2-M2-Ngff-Cooler-Cooling-Heatsink-Ssd-Nvme-i.345965854.5366249793][b][color=blue]This[/color][/b][/url] has like 5 LEDs:\nAnd each can be customized with any color you want. Currently 2 types of connector for lighting peripherals aside from their power cable; ARGB 3-pin and PWM 4-pin and your motherboard decides what you can connect. You can use splitter cables but don't forget the nuances of long cabling and load on those cables. There are also Lighting Control HUB Devices where you attach all Lighting Control connectors there instead of trying to fit them all in the Motherboard Headers probably via splitters, The hub can be remote controlled or come with a configurator software or you can use OpenRGB. Some ARGB devices can be daisy-chained as well.",
				"image_path": "res://assets/parts/my_ssdshield.png"
			}
	elif row == 8:
		if column == 0:
			return {
				"title": "Category Context: Lightbar inside the Case",
				"desc": "Optional Lighting:\nYou can even hook up an LED Strip to your PC that would run through your room I guess. Given that it's length can be supported by the motherboard and PSU. Personally never tried it so.",
				"image_path": "res://assets/parts/lightbar_category.png"
			}
		elif column == 1:
			return {
				"title": "My Lightbar: Coolmoon 30cm Lightbar Magnetic",
				"desc": "[url=https://shopee.ph/-Getdouble-COOLMOON-30cm-Light-Strip-Aluminum-Magnetic-RGB-LED-Color-Atmosphere-Lamp-i.129778469.9800348275][b][color=blue]This[/color][/b][/url] has like 16? LEDs:\nAnd each can be customized with any color you want for being ARGB(RGB variant doesn't allow individual LED customization.). I just magnetically attach it to a corner inside the case.",
				"image_path": "res://assets/parts/my_lightbar.png"
			}
	elif row == 9:
		if column == 0:
			return {
				"title": "Category Context: Front Case Fans",
				"desc": "Airflow / Cooling:\nPlenty of options I guess; Radiators or just plain fans like mine. Some are quiet(lower decibel) and fast(higher RPM). You can also go water-cooling but personally never tried that and not sure I want to. Goal is to remove heat from the computer's hardware system as efficiantly as possible so studying thermoaerodynamics helps here I guess. Personally I keep the intake fans in the front and bottom then the outflow to the top and back since as far as I know 'hot air rises' and that's a philosophical phrase as well.",
				"image_path": "res://assets/parts/FCFans_category.png"
			}
		elif column == 1:
			return {
				"title": "My Front Case Fans: Cooler Master 140 ARGB SickleFlow x2",
				"desc": "[url=https://www.coolermaster.com/en-sg/products/sickleflow-140-argb.html][b][color=blue]140[/color][/b][/url] is the size, there are other sizes:\nMost casing allow attaching of the 2 common sizes on the same spot with allocations of screwholes for them. These are my intake fans at the front inner side of the case.",
				"image_path": "res://assets/parts/my_FCFans.png"
			}
	elif row == 10:
		if column == 0:
			return {
				"title": "Category Context: Top Case Fans",
				"desc": "Airflow / Cooling:\nSame thing to say as the one in the Front Case Fans Section.",
				"image_path": "res://assets/parts/TCFans_category.png"
			}
		elif column == 1:
			return {
				"title": "My Top Case Fans: ID-COOLING DF-12025-ARGB Snow x3",
				"desc": "120 is the size of [url=https://www.idcooling.com/product/detail?id=242][b][color=blue]this[/color][/b][/url] fan:\nSame thing to say as the one in the Front Case Fans Section. Except these are my outflow fans. Since heat naturally rises right? So why not leverage that and let it rise up away from your system faster.",
				"image_path": "res://assets/parts/my_TCFans.png"
			}
	elif row == 11:
		if column == 0:
			return {
				"title": "Category Context: Rear Case Fan",
				"desc": "Airflow / Cooling:\nSame thing to say as the one in the Front Case Fans Section.",
				"image_path": "res://assets/parts/RCFans_category.png"
			}
		elif column == 1:
			return {
				"title": "My Rear Case Fan: ID-COOLING XF-12025-RGB Black",
				"desc": "120 is the size of [url=https://www.idcooling.com/product/detail?id=159&name=XF-12025-RGB-TRIO][b][color=blue]this[/color][/b][/url] fan:\nSame thing to say as the one in the Front Case Fans Section. Since my front case fans are intakes these has to be outflow fans.",
				"image_path": "res://assets/parts/my_RCFans.png"
			}
	elif row == 12:
		if column == 0:
			return {
				"title": "Category Context: Fan Power Cable Splitters",
				"desc": "With Limited Fan Headers for Power and Lighting Control:\nComes possibly a couple of splitter cables.",
				"image_path": "res://assets/parts/FPCSplitter_category.png"
			}
		elif column == 1:
			return {
				"title": "My Fan Header Splitter: ID-COOLING FS04 ARGB",
				"desc": "Motherboard Fan Port Count:\nThis whole overkill Lighting in PC Cases didn't exist back then so there weren't really much of these connectors and probably still not that many on a board even today. Might need [url=https://www.idcooling.com/product/detail?id=259&name=FS-04%20ARGB][b][color=blue]splitters[/color][/b][/url] to accomodate plentiful lighting emitters for your PC Case Nightlight.",
				"image_path": "res://assets/parts/my_FPCSplitter.png"
			}
	elif row == 13:
		if column == 0:
			return {
				"title": "Category Context: Power Supply Unit",
				"desc": "The Part that can cause Fires:\nWhile it is pretty rare it does happen and I feel like it's only going to keep happening more until people realize that buying into unknown cheap units of these could literally not just destroy this part and your other PC parts but even a curtain nearby and then eventually your entire wooden house and neighborhood. Calculate the total Wattage Requirement of your PC Components then add about 10% to 20% more to get the range of Wattage your Power Supply should be. This is the part I wouldn't just buy second hand and make sure I don't mind spending a little extra if it means making sure I don't lose a lot more in the possible consequence of skimping on it. Cabling is not exactly same as other models or brands cabling, the output ports sure is the same but the input from the PSUnit is proprietary or may be mixed up by the manufacturer meaning a cable from another model bundle may not work and even break your parts if used with other PSU models without modification.",
				"image_path": "res://assets/parts/psu_category.png"
			}
		elif column == 1:
			return {
				"title": "My Power Supply Unit: FSP Dagger PRO Gold 80+ SFX 650W Full Modular",
				"desc": "[url=https://www.fsplifestyle.com/en/product/DAGGERPRO650W.html][b][color=blue]Japanese Capacitors! Wow!~[/color][/b][/url]:\nLinus Tech Tips channel covered this brand and found it's actually rated for Platinum instead of Gold: [url=https://youtu.be/7h6kUNlC6cs?si=sQzQQhdWv3HCHmTj&t=356][b][color=blue]Their Youtube Video on it.[/color][/b][/url]. Ever since I built this system during Pandemic Season 1, and until now where I just relocated to an area where we suddenly experienced sudden power interruptions probably due to me moving to this grid and my electricity consumption, which in the past few weeks have settled down as the grid is proabably acclimated or something to the demand now. It's still kicking azz after like 6 power interruptions where a couple were like blinking christmas lights way which prompted me to have to unplug for precaution since I don't use UPS or Surge Protects. The former apparently being the better choice.",
				"image_path": "res://assets/parts/my_psu.png"
			}
	elif row == 14:
		if column == 0:
			return {
				"title": "Category Context: Monitor",
				"desc": "Nice GPU! Can your Monitor display all it can generate though?:\nStories of elderlies having very big monitors with high resolution capability connected to PCs with lower capability GPU and vice versa. You want to get the matching monitor for your GPU capability, but they are not really required since they can mostly just adjust their resolutions to the lower of the two of them. Monitors' resolution can be adjusted lower to an extent but it is marketed with it's maximum reslutions as the marketing hook. Another specification is the PixelsPerInch or PPI which is kind of similar to DotsPerInch or DPI for mouse but the former is something you can't change as it's pertaining to how many or how small you can get your individual led or 'pixel' within a measurement of an inch, this makes the image more finer or grainier like sand while Resolution is actually just a count of Pixels Horizontally and Vertically so even if a Display may be smaller it doesn't always mean it has lower resolution. The DPI, check the mouse section for it. Your Monitor has to be equal or better in display capability than what your GPU can output or signal into it to get the most out of it which is a clearer(HighResolution and PPI) and smoother transition(Hz or Refresh Rate) imagery. GPU showing FPS going into 200+ on the same monitor that only runs on 65Hz is actually still just around 65FPS as you view it from that monitor. It's only 200+ in it's processing/generation but your monitor can only output that which is 65Hz or around the same amount in FPS(I am not sure about the metrics but it's like that.), so you're not actually seeing all those 200+ frames per seconds that are actually consuming energy and being produced if your monitor can't refresh fast enough to display all of them.",
				"image_path": "res://assets/parts/monitor_category.png"
			}
		elif column == 1:
			return {
				"title": "My Monitor: Samsung SyncMaster 24'' SA450",
				"desc": "[url=https://www.samsung.com/us/business/support/owners/product/sa450-series-s24a450bw-1/][b][color=blue]Office Monitor[/color][/b][/url] bought for cheap as Second Hand:\nIt's great in that it can be raised/rotated/angled with just it's built-in stand but no VESA screwholes though and has low refresh rate of 60 at native resolution and 75 only on a lower resolution. Saw it on Facebook Marketplace for cheap because it had water damage streaking on the right region which over time just cleared up. Most probably to heat dissipating it eventually. That's why there are videos online showing fixing water damages on monitors using hair blowers. It's not the same for OLED screens though where too much heat would burn that thing black. Found that out when I had to try and fix a cellphone that had that screen...",
				"image_path": "res://assets/parts/my_monitor.png"
			}
	elif row == 15:
		if column == 0:
			return {
				"title": "Category Context: Monitor Cabling",
				"desc": "I've yet to see a Cable:\nFor monitors with it's designed port- not transmit at that port's standard rate. It's not impossible though since cutting costs on material quality can happen and if people who do those find it's profitable enough to keep doing it then it will happen I guess. Aside from the monitor and the GPU, the data goes through here before your Monitor. If you're wondering how 'Cabling' affects transmission speeds; material conductivity whether that is temperature or electricity, resistance(Ohms), and what fiberoptic cable is inside and why it is fast.",
				"image_path": "res://assets/parts/MCabling_category.png"
			}
		elif column == 1:
			return {
				"title": "My Monitor Cabling: HDMI to DVI-D",
				"desc": "Another Gamble?:\nCan't remember exactly whether Shopee or FB Marketplace bought but it's a thick cable and actually works pretty well.",
				"image_path": "res://assets/parts/my_MCabling.png"
			}
	elif row == 16:
		if column == 0:
			return {
				"title": "Category Context: Gamepad/Controller",
				"desc": "Console Video Gaming / Arcade was the original Video Gaming Device Target:\nPhysical Control Interface preference mostly depends on the game you are playing and what is allowed for it so as to not get banned(Because I see Macros as Un-manned Programmed Controllers and are bannable in some games.) or what you are using it for. Keyboard and Mouse for Shooters and Real-Time Strategy War Games(RTS - StarCraft, the OG WarCraft, Command & Conquer Games, Battle Realms)/MOBAs(League of Legends, DotA). MMORPGs are fine with either. Piloting simulations are mostly controllers even in real life. Seen an inside of a Jet Cockpit? The main steering is a big Joystick right? That Submarine that was a scandalous accident being controlled with a Logitech Controller? Gamepads/Controllers have fewer buttons but they require lesser muscle movement to do presses and even shorter finger travel time. Analog sensors for precise control too unlike keyboards or digital that are basically like On and Off switches only.",
				"image_path": "res://assets/parts/gamepad_category.png"
			}
		elif column == 1:
			return {
				"title": "My Main Gamepad/Controller: XBox 360 Wireless + Chatpad",
				"desc": "I had Radial Nerve Palsy:\nFor some reason, I woke up one morning and I couldn't move my left hand. Using the keyboard and gaming with just one hand is kind of slow, hard and not that fun, then I got to try an XBox Layout Controller and loved it. Originally used the Playstation Controllers as my first hand at console controllers from PS1 era to PS4 and I now prefer the XBox Layout more. Also got the chatpad attachment for it. Also found a GitHub project to make them work together on modern PCs with some success until someone made a 2$ version of that on Steam then I just bought it instead to make setting it up next time easier. Here's a [url=https://shopee.ph/nslikey.ph?entryPoint=OrderDetail][b][color=blue]Shopee Store[/color][/b][/url] that sells replacement parts and cases for standard or popular controllers. [url=https://shopee.ph/-Fast-delivery-33pcs-Tamper-Proof-CRV6150-Torx-Hex-Star-Bit-Set-with-Magnetic-Holder-for-Any-Drills-Screwdriver-Nutdrivers-Bits-Hand-Tools-with-Storage-Case-i.778753425.23420890136][b][color=blue]Bought the torx security screwbit from this shoppee link to be able to replace the casing.[/color][/b][/url]",
				"image_path": "res://assets/parts/my_gamepad.png"
			}
	elif row == 17:
		if column == 0:
			return {
				"title": "Category Context: Secondary Gamepad",
				"desc": "More players! Couch play?:\n2 Gamepads and you can have like 2 more people on 1 keyboard(like we used to do playing on PS Emulators on PC) for a total of 4 players for couch play if ever needed ever again. X'D",
				"image_path": "res://assets/parts/secgamepad_category.png"
			}
		elif column == 1:
			return {
				"title": "Secondary Gamepad: 8BitDo 2.4GHz / Wired / Wireless Ultimate",
				"desc": "First Contact with the XBox Controller Layout:\nThis is my first XBox Layout Controller, it still works, just sitting on it's dock. It's what got me to want to try out an actual XBox Controller. Because in the past I have seen others with this type of controller and the customizations they did with theirs and MadCatz controllers that IIRC had the same Layout. The move to the Original XBox Controller was for that, the joystick placements and the premium plastic feel(That I hope to get if I ever end up getting the newer controllers). This specific model's production has been discontinued. It's like another first generation just like the GPU I use right now.",
				"image_path": "res://assets/parts/my_secgamepad.png"
			}
	elif row == 18:
		if column == 0:
			return {
				"title": "Category Context: Speakers/Sounds",
				"desc": "Is this your Home Theater?:\nI guess you would need to check whether your motherboard has the audio ports you need for big setups of these. Something I have almost no experience at all since my uncle's audio component system.",
				"image_path": "res://assets/parts/speakers_category.png"
			}
		elif column == 1:
			return {
				"title": "My Speakers: Creative SBS A60",
				"desc": "I'm not an audiophile:\nWhile I do know a lot of songs of varying genre, I think I have tone-deaf ears? I can't tune a guitar or any instrument with ears alone. I was told a method to do so but I can't trust my ears as much as I can't trust myself to draw on paper or anywhere something that I can be proud of. If you try to look up [url=https://global.microless.com/product/creative-sbs-a60-2-0-desktop-speaker/][b][color=blue]this[/color][/b][/url] model, you might be surprised at it's production date. I like it's sleek look. Though it's sound drivers might not be as loud as new ones.",
				"image_path": "res://assets/parts/my_speakers.png"
			}
	elif row == 19:
		if column == 0:
			return {
				"title": "Category Context: Mechanical Keyboard",
				"desc": "Membrane Keyboards aren't that comfortable in long typing sessions:\nIf you ever have to work on typing jobs for extended duration of time, membrane keyboards are just not comfortable or satisfying and you will feel that strain on your fingers much less than you would on a mechanical keyboard. As long as you can ignore the cries of everyone who hears your typing. LOL, you can get silent switches and apply lubricant on the switches or attach rubber orings to the stems or add a layer of padding to the gasket underneath.",
				"image_path": "res://assets/parts/keyboard_category.png"
			}
		elif column == 1:
			return {
				"title": "My Mechanical Keyboard: Rakk Lam-Ang PRO PBT Barebones - Some Zilents Switches",
				"desc": "[url=https://rakk.ph/product/rakk-lam-ang-pro-barebone-rgb-mechanical-gaming-keyboard-pbt-doubleshot-white-keycaps-5-pin-mechanical-switch-bundles/][b][color=blue]Rakk[/color][/b][/url] is a Filipino Brand:\nActually have 2 of these boards right now but about 3 bought in total. The third one's board broke and wouldn't work wired or wireless so scrapped it. The one I am using to type this has it's battery removed and only works wired. The other one is where the battery went to double it's capacity and only works wireless. Currently in the process of transferring over the switches from the Razer Blackwidow via desoldering. I like the tactile feedback but not so much the clacky noise so I've explored lubing the switches, orings, Zilents switches and so on from the Mechanical Keyboard Community. [url=https://zealpc.net/products/zilent?variant=5894832324646][b][color=blue]Zilents Switches - May Not be same version in mine XD[/color][/b][/url], Honestly this keyboard has 3 different kinds of Switches, can't remember exactly which is which. X'D",
				"image_path": "res://assets/parts/my_keyboard.png"
			}
	elif row == 20:
		if column == 0:
			return {
				"title": "Category Context: Keycap Set #1",
				"desc": "Bit painful on the wallet, these hobbies:\nAll the information is kind of online already but look into PBT Material and ABS Material Keycaps and Artisan Customs and their switch compatibility, most are MX Stems as the most common as standard.",
				"image_path": "res://assets/parts/KCap1_category.png"
			}
		elif column == 1:
			return {
				"title": "Keycap Set #1: Ahegao Anime Girls",
				"desc": "Link:\n[url=https://shopee.ph/108key-PBT-Keycap-Dye-Sublimation-OEM-ProfileKeycap-Ahegao-Anime-Keycap-For-Cherry-Mx-Gateron-Kailh-Switch-Mechanical-Keyboard-i.313210658.6253938166?extraParams=%7B%22display_model_id%22%3A61311918539%2C%22model_selection_logic%22%3A3%7D&sp_atk=ca3b2654-752c-470e-8add-f3608a42e5ef&xptdk=ca3b2654-752c-470e-8add-f3608a42e5ef][b][color=blue]The Original Listing I got it from is delisted on Shopee, here's a similar listing.[/color][/b][/url]",
				"image_path": "res://assets/parts/my_KCap1.png"
			}
	elif row == 21:
		if column == 0:
			return {
				"title": "Category Context: Keycap Set #2",
				"desc": "Bit painful on the wallet, these hobbies:\nAll the information is kind of online already but look into PBT Material and ABS Material Keycaps and Artisan Customs and their switch compatibility, most are MX Stems as the most common as standard.",
				"image_path": "res://assets/parts/KCap2_category.png"
			}
		elif column == 1:
			return {
				"title": "Keycap Set #2: Black on White Pudding Backlit",
				"desc": "Link:\n[url=https://shopee.ph/Pudding-Keycaps-129keys-Backlit-Keycap-OEM-Profile-PBT-Material-for-RK61-RK100-Mechanical-Keyboard-i.20011698.18302687318?extraParams=%7B%22display_model_id%22%3A226154779116%2C%22model_selection_logic%22%3A3%7D&sp_atk=a6adad1a-a496-4179-bbca-7eb5672c3b35&xptdk=a6adad1a-a496-4179-bbca-7eb5672c3b35][b][color=blue]The Original Listing I got it from is delisted on Shopee, here's a similar listing.[/color][/b][/url]",
				"image_path": "res://assets/parts/my_KCap2.png"
			}
	elif row == 22:
		if column == 0:
			return {
				"title": "Category Context: Keycap Set #3",
				"desc": "Bit painful on the wallet, these hobbies:\nAll the information is kind of online already but look into PBT Material and ABS Material Keycaps and Artisan Customs and their switch compatibility, most are MX Stems as the most common as standard.",
				"image_path": "res://assets/parts/KCap3_category.png"
			}
		elif column == 1:
			return {
				"title": "Keycap Set #3: White Frosted Backlit",
				"desc": "Link:\n[url=https://shopee.ph/115-Keys-MDA-Profile-Frosted-Matte-White-Keycaps-PC-Double-Shot-Key-Caps-Set-Keycaps-for-Mechanical-Keyboard-i.1333199702.28780592236?extraParams=%7B%22display_model_id%22%3A138267808855%2C%22model_selection_logic%22%3A3%7D&sp_atk=82a27543-1ed0-457e-b4d5-7a4e6dc5757b&xptdk=82a27543-1ed0-457e-b4d5-7a4e6dc5757b][b][color=blue]The Original Listing I got it from is delisted on Shopee, here's a similar listing.[/color][/b][/url]",
				"image_path": "res://assets/parts/my_KCap3.png"
			}
	elif row == 23:
		if column == 0:
			return {
				"title": "Category Context: Mouse",
				"desc": "Actually should be optional:\nThe first computers didn't really have this control device. And until today you mostly really just need a keyboard if you know what it can do. Tab key switches between GUI elements in combination of the arrow keys and Enter key as your sort of Left-Mouse Click. Alt-Tab or some other new methods to switch between applications and so on... Ctrl+F5 to Hard Refresh a browser forcing it reload what it knows about a website by flushing or removing it's saved copy on your local system. Useful info if you are starting out on web-development. What DPI(Apparently should be CPI since DPI came first for Printers but the idea to be described is logically sound) is almost same as PPI except it is referencing the number of pixels that your mouse moves over within an a physical size of an inch().",
				"image_path": "res://assets/parts/mouse_category.png"
			}
		elif column == 1:
			return {
				"title": "Mouse: Brandless 2.4GHz",
				"desc": "Link:\n[url=https://shopee.ph/Gamer-2.4GHz-Wireless-Mouse-Office-Mice-2000DPI-Basic-Mouse-With-USB-Receiver-For-Computer-PC-Laptop-i.650861756.52652570459][b][color=blue]This is bought fairly recent so here[/color][/b][/url], I am going to replace it's switches for more silent [url=https://shopee.ph/OMG-for-HUANO-Silent-Mouse-Micro-Switch-Micro-Mute-Button-Microswitch-2-10Piece-Set-Mouse-Switch-i.758343628.22787326555][b][color=blue]ones[/color][/b][/url].",
				"image_path": "res://assets/parts/my_mouse.png"
			}
	elif row == 24:
		if column == 0:
			return {
				"title": "Category Context: Headphones",
				"desc": "NOT AN AUDIOPHILE:\nAgain with the sound devices that honestly aren't that great because they can get quite expensive too and I am not into that much. This is like a matter of taste or standard where once you've sensed that higher tier you just can't go back lower since you all the flaws easily.",
				"image_path": "res://assets/parts/hphones_category.png"
			}
		elif column == 1:
			return {
				"title": "Headphones: MS-B2 (Damaged)",
				"desc": "I don't even use [url=https://shopee.ph/MS-B2-original-headphone-Bluetooth-wireless-high-quality-headset-with-folding-microphone-i.378859210.20456198353][b][color=blue]this[/color][/b][/url] much anymore:\nCommon experience with headphones for me is that the band that connects the left and right drivers can be flimsy and break easily. The only brand of headphones I've had where that didn't happen is with Razer Krakens.",
				"image_path": "res://assets/parts/my_hphones.png"
			}
	elif row == 25:
		if column == 0:
			return {
				"title": "Category Context: Earphones",
				"desc": "NOT AN AUDIOPHILE:\nAgain with the sound devices that honestly aren't that great because they can get quite expensive too and I am not into that much. This is like a matter of taste or standard where once you've sensed that higher tier you just can't go back lower since you all the flaws easily.",
				"image_path": "res://assets/parts/ephones_category.png"
			}
		elif column == 1:
			return {
				"title": "Earphones: Baseus Encok WM01 Bluetooth(One Side Failing)",
				"desc": "More like regular earplugs:\nIt did work fine but eventually the connection between the charging dock and one side may have gotten faulty or the bud itself is just failing already. Just use it nowadays as an earplug to reduce perceived noise. Or when sleeping.",
				"image_path": "res://assets/parts/my_ephones.png"
			}
	elif row == 26:
		if column == 0:
			return {
				"title": "Category Context: Mousepad",
				"desc": "This is actually more aesthetic and comfort due to the material on your skin than practical:\nIt's not totally required to have a mousepad for the mouse to work.",
				"image_path": "res://assets/parts/mousepad_category.png"
			}
		elif column == 1:
			return {
				"title": "Mousepad: Felt & Cork by MD Custom 800mmx300mm",
				"desc": "Hard to describe it:\nIt's the feeling of the material on your skin as you type and hold your mouse over it.",
				"image_path": "res://assets/parts/my_mousepad.png"
			}
	elif row == 27:
		if column == 0:
			return {
				"title": "Category Context: Microphone",
				"desc": "NOT AN AUDIOPHILE:\nAnother audio device. There are videos online on software that you can use to make it sound better and control it's routing to your apps.",
				"image_path": "res://assets/parts/microphone_category.png"
			}
		elif column == 1:
			return {
				"title": "Microphone: Cheap but very sensitive lapel mic.",
				"desc": "It's small and supposed to be used in traveling:\nThat is why it is very sensitive to sounds and works fine as a computer microphone for my use as well.",
				"image_path": "res://assets/parts/my_microphone.png"
			}
	elif row == 28:
		if column == 0:
			return {
				"title": "Category Context: Video Capture Card",
				"desc": "Why? What it is?:\nIt's for when you want to record or stream a Display Output of another device that can't be directly or simultaneously mirrored onto your recorder device such as a PC while you having it output to it's sole intended display output. An example of why I even had something like this is the Nintendo Switch. The device connects to it and from it to the main display output AND the PC or recording device. Because of this there might be a little delay in the output since it has to go through another layer.",
				"image_path": "res://assets/parts/vccard_category.png"
			}
		elif column == 1:
			return {
				"title": "Video Capture Card: EZCAP284 HD Video Capture (Selling)",
				"desc": "[url=https://www.ezcap.com/ezcap284][b][color=blue]Cheap Alternative[/color][/b][/url] to Elgato:\nPersonally can't compare their performance since I've never used the other. But this is real 1080p Passthrough capturing for when you want to stream into your PC the Display Output of another device like Nintendo Switch with minimal latency or delay int he signal.",
				"image_path": "res://assets/parts/my_vccard.png"
			}
	elif row == 29:
		if column == 0:
			return {
				"title": "Category Context: Router",
				"desc": "Your Own Router:\nSo you can customize your local network without having to ask for unlock permission or so from your ISP for their provided router. You connect their router to your router and configure your router however way you want as a local network basically outsourcing it's internet from the ISPs Router. If you try to turn this into commercial use, your ISP will notice the surge in data consumption that is totally not normal for a household in a private/resident plan instead of a commercial one. And may fine you.",
				"image_path": "res://assets/parts/router_category.png"
			}
		elif column == 1:
			return {
				"title": "Router: MikroTik HomeAP AC Lite",
				"desc": "[url=https://mikrotik.com/product/RB952Ui-5ac2nD-TC][b][color=blue]Seems to be the competitor to CISCO[/color][/b][/url]:\nThey both offer certifications. That last time I checked, have to be renewed with an exam and a fee.",
				"image_path": "res://assets/parts/my_router.png"
			}
	elif row == 30:
		if column == 0:
			return {
				"title": "Category Context: Network Connectivity",
				"desc": "Because my Motherboard doesn't have built-in Wireless Card or capability:\nUSB Dongles now comes in having both Wireless and Bluetooth. Back then Wireless or Modem Cards look like board only GPUs of today without the shroud and massive heatsinks.",
				"image_path": "res://assets/parts/networking_category.png"
			}
		elif column == 1:
			return {
				"title": "Network Adaptor: TP Link Nano UB Bluetooth + WiFi",
				"desc": "[url=https://www.tp-link.com/ph/home-networking/adapter/archer-t2u-nano/][b][color=blue]They're[/color][/b][/url] fine and really small:\nWired is still king though... Having stuff in wireless today is still actually broadcasting your device to everyone around it and that can be a vulnerability. Hiding the SSID of your WiFi doesn't hide it from those with Kali Linux Kernels sniffing every WiFi in the coverage of their antennae.",
				"image_path": "res://assets/parts/my_networking.png"
			}
	elif row == 31:
		if column == 0:
			return {
				"title": "Category Context: Webcam",
				"desc": "Used to have a Action Cam as a Webcam:\nCameras! Need I say more? I am not into photography so. But ofcourse better image sensors/image quality is what you want. When it comes to these things I guess aside from brand what you want to check is their USB Version with your PC port's USB Version. I don't just mean the different slot shapes but actual version since there are differences in their speed or data transfer rates.",
				"image_path": "res://assets/parts/webcam_category.png"
			}
		elif column == 1:
			return {
				"title": "My Webcam: Some Cheap Low Quality",
				"desc": "No Idea why I even mention [url=https://shopee.ph/1080p-Hd-Webcam-Web-Camera-With-Mic-Computer-Pc-Laptop-Skype-Msn-i.9277068.4760523907][b][color=blue]this[/color][/b][/url]:\nIt's what it's as at least having one I guess.",
				"image_path": "res://assets/parts/my_webcam.png"
			}
	elif row == 32:
		if column == 0:
			return {
				"title": "Category Context: Cellphone",
				"desc": "Ah the last gadget to live with:\nWhen the time comes to leave to the grid. This is essentially a mini computer running on linux as well which is what Android is based on? I think the same goes for Apple.. Check online how much of the entire internet infrastracture runs on Linux and how many devices actually run it underneath or as the basis. You would normally look for Snapdragon and a screen that is like Gorilla Glass for toughness. That is in Year 2020+ or so.",
				"image_path": "res://assets/parts/cellphone_category.png"
			}
		elif column == 1:
			return {
				"title": "My Cellphone: Xiaomi POCO M4 Pro 5G",
				"desc": "I choose [url=https://www.gsmarena.com/xiaomi_poco_m4_pro_5g-11193.php][b][color=blue]specifications[/color][/b][/url] and Reviews over Hype:\nInfrared for when I want to use it as a universal remote. Headphone Jack, because wired headphones are cheap and more secure and doesn't need batteries also required in some models in order to run the radio app. Huge battery capacity. Decent body material. 5G capability in the bands that I need, that is both Mobile Network 5G and WiFi 5'G'. Unfortunately not Snapdragon but I don't use this to run heavy games. Don't really care about MOBAs on phone.",
				"image_path": "res://assets/parts/my_cellphone.png"
			}
	elif row == 33:
		if column == 0:
			return {
				"title": "Main Appliance I can't live without at this point.",
				"desc": "That one comfort appliance:\nWhat's yours?",
				"image_path": "res://assets/parts/mappliance_category.png"
			}
		elif column == 1:
			return {
				"title": "Countertop Tube Ice Maker",
				"desc": "Pour water in and it makes ice:\nThis thing is like a mini fridge. And I need cold drinks consistently. To cool down processing brain rather than trying hard to start it up. But it really depends on the wheather, that's the reality, the wheather dictates whether you want to actually regulate our body temperature. In using this I've learned to fix it by replacing it's rotating basin switches, rotator motor, water pump(cleaning out hair that clogs it), water hose and even bypassing it's control interface board.",
				"image_path": "res://assets/parts/my_mappliance.png"
			}
	elif row == 34:
		if column == 0:
			return {
				"title": "Secondary Appliance I can't live without.",
				"desc": "That second comfort appliance:\nWhat's yours?",
				"image_path": "res://assets/parts/sappliance_category.png"
			}
		elif column == 1:
			return {
				"title": "Electric Kettle",
				"desc": "But only because I need [url=https://shopee.ph/2L-stainless-steel-electric-kettle-i.773865746.50210081802?extraParams=%7B%22display_model_id%22%3A360887040095%2C%22model_selection_logic%22%3A3%7D&sp_atk=aca87fd0-e7c4-41d5-8df4-2125334bdf09&xptdk=aca87fd0-e7c4-41d5-8df4-2125334bdf09][b][color=blue]it[/color][/b][/url] to melt the coffee powder:\nThen add ice to it. The airpot that I am selling now consumes like 7$ per month being plugged in 24/7 and having hot water available anytime as long there is water in it. I changed it into a simpler heater that I am just borrowing because that is actually way easier to fix and maintain as it is just passing AC current right through water and making sure the contact points connect as they can wear down and get pushed out thru repeated use. You just push them back in. Takes some time but it does heat up fast and doesn't consume that much electricity in the process. The trade-off is the convenience of having it readily available as you need it or having to wait like 40 seconds...",
				"image_path": "res://assets/parts/my_sappliance.png"
			}
	elif row == 35:
		if column == 0:
			return {
				"title": "Another Body Temperature Regulator",
				"desc": "Air Condition? Electric Fan? Heater?:\nWhat does your local climate need?",
				"image_path": "res://assets/parts/tappliance_category.png"
			}
		elif column == 1:
			return {
				"title": "Some DTI Certified Safe Mini Clip 5 Harmless Blades Fan",
				"desc": "[url=https://shopee.ph/Table-Clip-Fan-5-Blades-Fan-Portable-Mini-fan-Home-Electric-Fan-portable-fan-table-fan-desk-fan-i.100257214.3670192912][b][color=blue]This[/color][/b][/url] thing blows air that I feel like I am drowning from it if directed at me and close enough:\nFor something this small and cheap it really does blow air effectively. I saw it on shopee with Stamps of Certification and thought to try it out and it's awesome. I am on my second of these now as the first one failed right above my head as I was sleeping. All my hair are still intact atleast until I shave them all off again. Yes, it didn't burn. I tried to fix it by opening it up since I have once repaired an exhaust fan by replacing it's thermal fuse, albeit in poor manner as it was my very first time doing that. But this fan specifically has the fuse in a place that's not easily reachable so I just salvaged the copper wire and magnet instead. It's only 150PHP? 3$? I also prefer this over AC after living with AC for a long time. Because I noticed that if you get too used to that. Even though it does aid in sleeping as it cools your body to slow processes down. The moment you get out in that blistering sun and humid air. In my case I just bursting in flames, I mean squirting all over in sweat. Something about your body getting to acclimated with cold artificial weather rooms and suddenly adjusting to extreme opposites in the actual local climate. I am not sure how true it is though but so far haven't really noticed the rumour that fans makes the skin darker if always directed at it. No idea how long you have to be exposed to it to be so.",
				"image_path": "res://assets/parts/my_tappliance.png"
			}
	return {}
