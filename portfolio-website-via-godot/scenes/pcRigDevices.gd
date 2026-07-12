extends ItemList

# --- Configuration Settings ---
# Drag and drop your custom modal scene file into this slot via the Inspector
@export var modal_scene: PackedScene

func _ready() -> void:
	max_columns = 2
	same_column_width = true

func _on_item_list_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
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
	# This adds the modal right next to your table scene, forcing it into your active UI view
	# Might have to modify the anchor point properties via code here
	#active_modal.get_property_list().set()
	get_parent().add_child(active_modal)

	
	if active_modal.has_method("populate_modal_data"):
		active_modal.populate_modal_data(unique_payload)

# --- Cell-Level Unique Database Matrix ---
func _get_cell_data(row: int, column: int) -> Dictionary:
	# ROW 0: GRAPHICS CARD ENTRY CORES
	if row == 0:
		if column == 0: # Row 0, Column 0: Clicking "Graphics Card" text label
			return {
				"title": "Category Context: Casing",
				"desc": "Why this is first in the list:\nIt's the physical size limitation of your computer build. As far as I know currently there are EATX, ATX, mATX and ITX builds all pertaining to different sizes of motherboards. This part will also tell you what size of Graphics Card you can put in it properly. It's also your expression of aesthetics like color, shape, material and so on. Or go caseless. If you can trust your system is safe in open-air. From environmental factors, kids, animals, insects, accidental watet spills or dust and so on.",
				"image_path": "res://assets/parts/casing_category.png"
			}
		elif column == 1: # Row 0, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Casing: Inplay Meteor 02 White",
				"desc": "Just need a protective case for mine:\nNot much to say here other than it's basic and has good airflow or places to attach fans to. Built this PC around Covid Pandemic's 1st Season of Stay at Home and until now the Tempered Glass is still intact with it's orginal screws. It has rubber standoffs or feet so it's not laid flat on the floor which would probably make it more susceptible to damage or quakes if so. Easy to open up and clean.",
				"image_path": "res://assets/parts/my_casing.png"
			}
			
	# ROW 1: PROCESSOR ENTRY CORES
	elif row == 1:
		if column == 0: # Row 1, Column 0: Clicking "Processor" text label
			return {
				"title": "Category Context: Central Processors (CPUs)",
				"desc": "System Pipeline Allocation:\nThe CPU dictates your memory frequencies and bus speed layout limits. Secure core throughput targets before mapping tertiary peripherals. Second because it depends on what programs you want to run and it will decide the type of motherboard you'll have to get next because CPUs have different slot size or shapes. The higher in price you go, you can expect the higher the price of the other components will be as well for optimal or avoiding bottlenecks around a certain ratio per class/level of computing.",
				"image_path": "res://assets/parts/cpu_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My CPU: AMD Ryzen 5 5500",
				"desc": "Personal Justification:\nAt the time this was the priciest I could afford forgoing the APU capaibility to focus on more compute powah~! APUs are the part of some CPUs that allows processing of display or video even without a Graphics Card. Usually marked in the CPU Model name with a letter like 'G' at the end of the name. And this one doesn't have that so I won't get display if my GPU broke.",
				"image_path": "res://assets/parts/my_cpu.png"
			}
	elif row == 2:
		if column == 0: # Row 1, Column 0: Clicking "Processor" text label
			return {
				"title": "Category Context: Graphical Processors (GPUs)",
				"desc": "Real Life Graphics Emulation/Computing?:\nThis part is after you selected your CPU if you actually need it, whether you're fine with just an APU-CPU or need a dedicated Processor for computing at this age and era- 3D(imitating physical world reality graphics) or virtual worlds where a lot of heavy-duty games are or maybe you deal with large number crunching stuff like video rendering or streaming which is kind of like on the fly video sources muxing/recording to stream video. When choosing a GPU you'll want to check your Motherboard's PCI-e Slot for it. The difference in performance could either be negligble or noticeable depending on the setup like a x8 lane GPU that is PCI-e 5 on a PCI-e 3 only Motherboard slot will definitely be not performing at full performance capability that it should be able to.",
				"image_path": "res://assets/parts/gpu_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My GPU: Zotac Mini GTX 1070 8GB",
				"desc": "Personal Justification:\nWhen I was allowed as a young boy to build my own PC after training in dad's workplace where I fixed some PSUs and built some PCs(Pentiums). The 1080 was the latest product then and it was my dream GPU. This 1070 isn't that far off in performance considering it's from the same architecture. I do have a RTX 2070 Super with me right now that has an odd issue that I might be able to repair soon. Zotac likes MAXXING their versions like Xiaomi Mi Max lines of phones(Full Aluminum Body). This GPU has a 256-Bus Width and uses all x16 PCIe lanes so even if it only has 8GB of VRAM, it can process a lot of data at once compared to the other variants of it's kind. It's only dual fan too so size factor.",
				"image_path": "res://assets/parts/my_gpu.png"
			}
	elif row == 3:
		if column == 0: # Row 1, Column 0: Clicking "Processor" text label
			return {
				"title": "Category Context: Random Access Memory (RAM)",
				"desc": "Temporary Data Storage for Faster Loading:\nEver experienced loading a gigantic word or office file like powerpoint(Try stuffing in a ton of videos in it. Then check it's file size and compare it to your RAM Size) and it crashes your PC? You need more ram. The ram loads everything that you run on your computer and only retrieves stuff from the ROM or SDD/HDD when it has to. So when there's not enough RAM to load a file, the system crashes unless it has a safety mechanic or way to handle that instead of just crashing. When it comes to the Speed Indicator(MHz), check your CPU and Motherboard's supported speeds. It's not plug and play as well, in that by default it's always set to around 2400MHz or so even if the rating you got is higher, you have to set it manually in the bios to activate that rated speed.",
				"image_path": "res://assets/parts/ram_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My RAMs: DDR4-3200MHz Kingston HyperX Fury RGB-8GB(Samsung Die) x2",
				"desc": "GPUs have their RAM too -> VRAM:\nThe Samsung Die is the actual chip inside the ram and it's like silicon lottery since I am not sure if there are people out there shopping for this part and deliberately trying to figure out which company/manufacturer made the chips inside before even buying. These are modular I guess but the motherboard and it's bios version might still be required to support DDRX and so. If you want to make sure that you get something that is compatible or works with your build, you'll want to look into your motherboard's QVL list or list of tested RAMs for that motherboard, usually on the manufacturer's website where you would also get the bios update instructions if you need to when upgrading OTHER parts that needs it; CPU mainly, GPU and RAM maybe, PSU? no. More on that on the Motherboard Section.",
				"image_path": "res://assets/parts/my_ram.png"
			}
	elif row == 4:
		if column == 0: # Row 1, Column 0: Clicking "Processor" text label
			return {
				"title": "Category Context: Motherboard (Holds Every Part Together)",
				"desc": "IMPORTANT:\nThis is like the 3rd part people see in your Computer Setup. 1st the Casing, 2nd the GPU and then the giant board that this is unless you are on a very small form factor build. READ TO THE END: People usually look into these for stuff like quality of components/durability, features like how many and what type of ports(USB/HDMI/...) and version of those ports, built-in networking card or if you would need an external WiFi/Bluetooth Dongle, number of PCIe Slots for maybe dual GPU(Crossfire and SLI?) or dual M.2 Storage Drives, RGB/ARGB/Fan Headers and their locations on the board if you are into that and planning your lighting placements/cabling and lastly aesthetics on how they look. The box looks cool too. Since you've read to this point you just saved yourself some major headache which is if you are planning on changing out this part, know that if you were using a legitimate 'Windows' license with the motherboard you are wanting to replace; you won't be able to easily boot back into your OS. That is because 'Windows' ties the first motherboard's HWID and other Metadata it is installed on with it's license and saves that on your OS and their servers. This is a non-issue if you use Linux though, and if your Windoes License isn't legitimate anyway or pirated or cracked or provided without an actual activation key then you can just get another one of that. As for your files, you can still get them back; just connect your ROM/Storage to another PC and you should be able to still access them. Maybe even through cellphone via USB-OTG and M.2/SATA to USB Adapter. You'll have to reinstall the OS though and in the process wipe all of it's contents so back them up first if they matter to you. So take note of that when choosing a Motherboard, consider possible upgrades and impossible upgrades like different CPU Socket Shapes(AM4!=AM5 | LGA1700!=LGA1851). Pretty sure they still have it, the CR2032 Battery that was widely used in watches back then, this is a separate DC Power Source for your Motherboard aside from the PSU which is needed to keep the chips storing your Bios Settings from forgetting those settings AND an internal clock. If you notice that your computer gets out of sync time or clock when it is not connected to the internet, that is because this battery is low and getting out of sync. Today's computer clocks mostly no longer need to rely on this part of the purpose of the battery because they can just sync to NTP Servers online but that would need the internet to be available to the PC. Bios Versions; some parts like CPU gets released after the time your motherboard is designed and released. If that CPU is same socket as your CPU, it might still need a Bios Version Update first to work. [url=https://www.asrock.com/mb/amd/b450m%20steel%20legend/#CPU]Checking which Bios Version for specific CPUs ON 'MY MOTHERBOARD'[/url], [url=https://www.asrock.com/mb/amd/b450m%20steel%20legend/#BIOS1]Bios Versions for Download[/url], [url=https://www.asrock.com/mb/amd/b450m%20steel%20legend/#MemoryCEZ]Tested Memory Sticks List for My Motherboard + Cezanne(CPU) Combo[/url]",
				"image_path": "res://assets/parts/motherboard_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Motherboard: ASRock Steel Legend B450m White",
				"desc": "Thanks JJ!:\nDuring the time I was building this PC, a friend happened to be upgrading theirs so I got this off him for a friendly price along with a CPU and RAM sticks that later got replaced. So far got 2 WindowsOS Licenses attached on it now. X'D",
				"image_path": "res://assets/parts/my_motherboard.png"
			}
	elif row == 5:
		if column == 0:
			return {
				"title": "Category Context: Read Only Memory (Storage HDD/SDD)",
				"desc": "Databanks:\nThese are larger than RAM sizes since they are intended to hold the data for as long as they can so they prioritize capacity over speed. Thanks to SSDs though they got a huge speed update! Just note that apparently SSDs will lose all stored data if not powered for more than a year or so unlike HDDs that has magnetic discs inside where the data is literally carved via laser onto the disk. These also has reading/writing speed ratings and cables have to be upto par with those too or that becomes a limiter to this device.",
				"image_path": "res://assets/parts/rom_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My ROM/Storage: ADATA SX8100NP 1TB M.2 NVMe SSD",
				"desc": "This is my first SSD:\nAnd dang the speed is real, hard to believe 1TB is still somehow not enough despite living through olden days where these were much smaller in available capacities. M.2 has different keying in their connection so make sure you get the correct one for your slot on your motherboard or external case. It connects directly to the Motherboard without the need for cables too so. SPEEED~",
				"image_path": "res://assets/parts/my_rom.png"
			}
	elif row == 6:
		if column == 0:
			return {
				"title": "Category Context: SSD Shield",
				"desc": "Kind of Optional?:\nThey supposed to help dissipate heat from it but you can have lighting on these too like what I have. MORE RGB/ARGB Header connections!! Careful putting this on your SSDs. Electronics rule of thumb, you don't need heavy force here.",
				"image_path": "res://assets/parts/ssdshield_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My SSD Shield: Coolmoon ARGB Thingy",
				"desc": "This has like 5 LEDs:\nAnd each can be customized with any color you want. Currently 2 types of connector for lighting peripherals aside from their power cable: ARGB 3-pin and PWM 4-pin and your motherboard decides what you can connect. You can use splitter cables but don't forget the nuances of long cabling and load on those cables. There are also Lighting Control HUB Devices where you attach all Lighting Control connecters there instead of trying to fit them all in the Motherboard Headers, The hub can be remote controlled or come with a configurator software. Some ARGB devices can be daisy-chained as well.",
				"image_path": "res://assets/parts/my_ssdshield.png"
			}
	elif row == 7:
		if column == 0:
			return {
				"title": "Category Context: Lightbar inside the Case",
				"desc": "Optional Lighting:\nYou can even hook up an LED Strip to your PC that would run through your room I guess. Given that it's length can be supported by the motherboard and PSU. Personally never tried it so.",
				"image_path": "res://assets/parts/lightbar_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Lightbar: Coolmoon 30cm Lightbar Magnetic",
				"desc": "This has like 16? LEDs:\nAnd each can be customized with any color you want for being ARGB. I just magnetically attach it to a corner inside the case.",
				"image_path": "res://assets/parts/my_lightbar.png"
			}
	elif row == 8:
		if column == 0:
			return {
				"title": "Category Context: Front Case Fans",
				"desc": "Airflow/Cooling:\nPlenty of options I guess; Radiators or just plain fans like mine. Some are quiet(lower decibel) and fast(higher RPM). You can also go water-cooling but personally never tried that and not sure I want to. Goal is to remove heat from system as efficiantly as possible so studying thermodynamics helps here. Personally I keep the intake fans in the front and bottom then the outflow to the top and back since as far as I know 'hot air rises' and that's a philosophical phrase as well.",
				"image_path": "res://assets/parts/FCFans_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Front Case Fans: Cooler Master 140 ARGB SickleFlow x2",
				"desc": "140 is the size, there are others:\nMost casing allow attaching of the 2 common sizes on the same spot with allocations of screwholes for them. These are my intake fans.",
				"image_path": "res://assets/parts/my_FCFans.png"
			}
	elif row == 9:
		if column == 0:
			return {
				"title": "Category Context: Top Case Fans",
				"desc": "Airflow/Cooling:\nSame thing to say as the one in the Front Case Fans Section.",
				"image_path": "res://assets/parts/TCFans_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Top Case Fans: ID-COOLING DF-12025-ARGB Snow x3",
				"desc": "120 is the size, there are others:\nSame thing to say as the one in the Front Case Fans Section. Except these are my outflow fans. Since heat naturally rises right? So why not leverage that and let it rise up away from your system faster.",
				"image_path": "res://assets/parts/my_TCFans.png"
			}
	elif row == 10:
		if column == 0:
			return {
				"title": "Category Context: Rear Case Fan",
				"desc": "Airflow/Cooling:\nSame thing to say as the one in the Front Case Fans Section.",
				"image_path": "res://assets/parts/RCFans_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Rear Case Fan: ID-COOLING XF-12025-RGB Black",
				"desc": "120 is the size, there are others:\nSame thing to say as the one in the Front Case Fans Section. Since my front case fans are intakes these has to be outflow fans.",
				"image_path": "res://assets/parts/my_RCFans.png"
			}
	elif row == 11:
		if column == 0:
			return {
				"title": "Category Context: Fan Power Cable Splitters",
				"desc": "Airflow/Cooling:\nSame thing to say as the one in the Front Case Fans Section.",
				"image_path": "res://assets/parts/FPCSplitter_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Fan Header Splitter: ID-COOLING FS04 ARGB",
				"desc": "Motherboard Fan Port Count:\nThis whole Lighting in PCs didn't exist back then so there weren't really much of these connections and so you might need splitters to accomodate your plentiful lighting emitters.",
				"image_path": "res://assets/parts/my_FPCSplitter.png"
			}
	elif row == 12:
		if column == 0:
			return {
				"title": "Category Context: Power Supply Unit",
				"desc": "The Part that can cause Fires:\nWhile it is pretty rare it does happen and I feel like it's only going to keep happening more until people realize that buying into unknown cheap units of these could literally not just destroy your this part and your other PC parts but even a curtain nearby and then eventually your entire wooden house and neighborhood. Calculate the total Wattage Requirement of your PC Components then add about 10% to 20% more to get the range of Wattage your Power Supply should be. This is the part I wouldn't just buy second hand and make sure I don't mind spending a little extra if it means making sure I don't lose a lot more in the possible consequence of skimping on it.",
				"image_path": "res://assets/parts/psu_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Power Supply Unit: FSP Dagger PRO Gold 80+ SFX 650W Full Modular",
				"desc": "Japanese Capacitors! Wow!~:\nLinus Tech Tips channel covered this brand and found it's actually rated for Platinum instead of Gold: [url=https://youtu.be/7h6kUNlC6cs?si=sQzQQhdWv3HCHmTj&t=356]YTLink[/url]. Ever since I built this system during Pandemic Season 1, and until now where I just relocated to an area where we suddenly experienced sudden power interruptions probably due to me moving to this grid and my electricity consumption, which in the past few weeks have settled down as the grid is proabably retrofitted or something to the demand now. It's still kicking azz. [url=https://www.fsplifestyle.com/en/product/DAGGERPRO650W.html]Product Page Specs[/url]",
				"image_path": "res://assets/parts/my_psu.png"
			}
	elif row == 13:
		if column == 0:
			return {
				"title": "Category Context: Monitor",
				"desc": "Nice GPU! Can your Monitor though?:\nStories of elderlies having very big monitors with high resolution capability connected to PCs with lower capability GPU and vice versa. You want to get the matching monitor for your GPU capability, but they are not really required since they can just adjust their resolutions to the lower of them. Monitors' resolution or pixels per inch and so on can be adjusted lower to an extent but it is marketed with it's maximum ratings and same with GPUs but your Monitor has to be equally or better in display capability than what your GPU can output or signal into it to get the most out of it. GPU showing FPS going into 200+ on the same monitor that only runs on 65Hz is actually still just around 65FPS. It's only 200+ in it's processing/generation but your monitor can only output that which is 65Hz or around same in FPS, so you're not actually seeing all those 200+ frames per seconds if your monitor can't refresh fast enough to display all of them.",
				"image_path": "res://assets/parts/monitor_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Monitor: Samsung SyncMaster 24'' SA450",
				"desc": "Office Monitor bought for cheap as Second Hand:\nIt's great in that it can be raised/rotated/angled with just it's built-in stand but no VESA screwholes though and has low refresh rate of 60 at native resolution and 75 only on a lower resolution. Saw it on Facebook Marketplace for cheap because it had water damage streaking on the right region which over time just cleared up. Most probably to heat dissipating it eventually. That's why there are videos online showing fixing water damages on monitors using hair blowers. It's not the same for OLED screens though where too much heat would burn that thing black.",
				"image_path": "res://assets/parts/my_monitor.png"
			}
	elif row == 14:
		if column == 0:
			return {
				"title": "Category Context: Monitor Cabling",
				"desc": "I've yet to see a Cable:\nFor monitors with it's designed port- doesn't transmit at the same standard's rate. It's not impossible though since cutting costs on material quality can happen and people who do those find it's profitable enough to keep doing it. Aside from the monitor and the GPU, the data goes through here before your Monitor then to your eyes so. If you're wondering how 'Cabling' affects transmission speeds; material conductivity whether that is temperature or electricity, resistance(Ohms), and what fiberoptic cable is inside and why it is fast.",
				"image_path": "res://assets/parts/MCabling_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Monitor Cabling: HDMI to DVI-D",
				"desc": "Another Lottery?:\nGot this Shoppee and it's brandless or made by another technician? Surprised it's as advertised and works really well. Will try to link the Shoppee Entry later when I start looking them up.",
				"image_path": "res://assets/parts/my_MCabling.png"
			}
	elif row == 15:
		if column == 0:
			return {
				"title": "Category Context: Gamepad/Controller",
				"desc": "Console Video Gaming / Arcade was the original Video Gaming Target:\nControl Device mostly depends on the game you are playing. Keyboard and Mouse for Shooters and MOBAs. MMORPGs are fine with either. Piloting simulations are mostly controllers even in real life. Seen an inside of a Jet Cockpit? That Submarine that went viral being controlled with a Logitech Controller? Gamepads/Controllers have fewer buttons but they require lesser muscle movement to do presses and even shorter finger travel time. 'Press-Depth' sensors too unlike keyboards that are just like On and Off switches.",
				"image_path": "res://assets/parts/gamepad_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Main Gamepad/Controller: XBox 360 Wireless + Chatpad",
				"desc": "I had Radial Nerve Palsy:\nFor some reason, I woke up one morning and I couldn't move my left hand. Using the keyboard and gaming with just one hand is kinda slow, then I got to try XBox Controllers and loved them. Tried the Playstation Controllers from PS1 era to PS4 and I prefer the XBox Layout. Also got the chatpad attachment for it. For a while played around with a GitHub project to make them work together on modern PCs with some success until someone made a 2$ version of that on Steam then just bought it instead to make setting it up next time easier.",
				"image_path": "res://assets/parts/my_gamepad.png"
			}
	elif row == 16:
		if column == 0:
			return {
				"title": "Category Context: Secondary Gamepad",
				"desc": "More players! Couch play?:\n2 Gamepads and you can have like 2 people on 1 keyboard for a total of 4 players for couch play if ever needed ever again. X'D",
				"image_path": "res://assets/parts/secgamepad_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "Secondary Gamepad: 8BitDo 2.4GHz/Wired/Wireless Ultimate",
				"desc": "First Contact with the XBox Layout:\nThis is my first XBox Layout Controller, it still works, just sitting on it's dock. It's what got me to want to try out an actual XBox Controller. Because in the past I have seen others with this type of controller and the customizations they did with theirs. The move to the Original XBox Controller was for that and the premium plastic feel.",
				"image_path": "res://assets/parts/my_secgamepad.png"
			}
	elif row == 17:
		if column == 0:
			return {
				"title": "Category Context: Speakers/Sounds",
				"desc": "Is this your Home Theater?:\nI guess you would need to check whether your motherboard has the audio ports you need for big setups of these. Something I have almost no experience at all since my uncle's audio component system.",
				"image_path": "res://assets/parts/speakers_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Speakers: Creative SBS A60",
				"desc": "I'm not an audiophile:\nWhile I do know a lot of songs of varying genre, I think I have tone-deaf ears? I can't tune a guitar or any instrument with ears alone. I was told a method to do so but I can't trust my ears as much as I can't trust myself to draw on paper or anywhere something that I can be proud of. If you try to look up this model, you might be surprised at it's production date. I like it's sleek look. Though it's sound drivers might not be as loud as new ones.",
				"image_path": "res://assets/parts/my_speakers.png"
			}
	elif row == 18:
		if column == 0:
			return {
				"title": "Category Context: Mechanical Keyboard",
				"desc": "Membrane is stressful:\nIf you ever have to work on typing jobs for extended duration of time, membrane keyboards are just not comfortable or satisfying and you will feel that strain on your fingers much less than you would on a mechanical keyboard. As long as you can ignore the cries of everyone who hears your typing. LOL, you can get silent switches and apply lubricant on the switches or attach rubber orings to the stems or add a layer of padding to the gasket underneath.",
				"image_path": "res://assets/parts/speakers_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Mechanical Keyboard: Rakk Lam-Ang PRO PBT Barebones - Some Zilents Switches",
				"desc": "Rakk is a Filipino Brand:\nActually have 2 of these boards right now but about 3 bought in total. The third one's board broke and wouldn't work wired or wireless so scrapped it. The one I am using to type this has it's battery removed and only works wired. The other one is where the battery went to double it's capacity and only works wireless. Currently in the process of transferring over the switches from the Razer Blackwidow via desoldering. I like the tactile feedback but not so much the clacky noise so I've explored lubing the switches, orings, Zilents switches and so on from the Mechanical Keyboard Community. [url=https://zealpc.net/products/zilent?variant=5894832324646]Zilents Switches - May Not be same version in mine XD[/url], Honestly this keyboard has 3 different kinds of Switches, can't remember exactly which is which. X'D",
				"image_path": "res://assets/parts/my_speakers.png"
			}
	return {} # Fallback empty tracker
