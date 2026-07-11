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
				"desc": "Why this is first in the list:\nIt's the physical size limitation of your computer build. As far as I know currently there are ATX-e, ATX, m-ATX and ITX builds all pertaining to different sizes of motherboards. This part will also tell you what size of Graphics Card you can put in it properly. It's also your expression of aesthetics like color, shape, material and so on.",
				"image_path": "res://assets/parts/casing_category.png"
			}
		elif column == 1: # Row 0, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Casing: Inplay Meteor 02 White",
				"desc": "Personal Justification:\nNot much to say here other than it's basic and has good airflow or places to attach fans to. Built this PC around Covid Pandemic 1st Season of Stay at Home and until now the Temered Glass is still intact with it's orginal screws. It has rubber standoffs or feet so it's not laid flat on the floor which would probably make it more susceptible to damage or quakes if so. Easy to open up and clean.",
				"image_path": "res://assets/parts/my_casing.png"
			}
			
	# ROW 1: PROCESSOR ENTRY CORES
	elif row == 1:
		if column == 0: # Row 1, Column 0: Clicking "Processor" text label
			return {
				"title": "Category Context: Central Processors (CPUs)",
				"desc": "System Pipeline Allocation:\nThe CPU dictates your memory frequencies and bus speed layout limits. Secure core throughput targets before mapping tertiary peripherals. Second because it depends on what programs you want to run and it will decide the type of motherboard you'll have to get next because CPUs have different slot size or shapes. The higher in price you go, you can expect the higher the price of the other componenets will be as well around a certain ratio per class of computing.",
				"image_path": "res://assets/parts/cpu_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My CPU: AMD Ryzen 5 5500",
				"desc": "Personal Justification:\nAt the time this was the priciest I could afford forgoing the APU capaibility to focus on more compute powah~! APUs are the part of some CPUs that allows processing of display or video even without a Graphics Card. Usually marked in the CPU Model name with a letter like 'G' at the end of the name.",
				"image_path": "res://assets/parts/my_cpu.png"
			}
	elif row == 2:
		if column == 0: # Row 1, Column 0: Clicking "Processor" text label
			return {
				"title": "Category Context: Graphical Processors (GPUs)",
				"desc": "Real Life Graphics Emulation/Computing?:\nThis part is after you selected your CPU if you actually need it, whether you're fine with just an APU-CPU or need a dedicated Processor for computing at this age and era- 3D(imitating physical world reality graphics) or virtual worlds where a lot of heavy-duty games are or maybe you deal with large number crunching stuff. When choosing a GPU you'll want to check your Motherboard's PCI-e Slot for it. The difference in performance could either negligble or noticeable depending on the setup like a x8 lane GPU that is PCI-e 5 on a PCI-e 3 Only Motherboard slot will tank a lot of the performance you should be able to get from it like that.",
				"image_path": "res://assets/parts/gpu_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My GPU: Zotac Mini GTX 1070 8GB",
				"desc": "Personal Justification:\nWhen I was allowed as a young boy to build my own PC after training in dad's showroom where I fixed some PSUs and build some PCs. The 1080 was the latest product then and it was my dream GPU. This 1070 isn't that far off in performance considering it's from the same architecture. I do have a RTX 2070 Super with me right now that has an odd issue that I might be able to repair soon. Zotac likes MAXXING their versions like Xiaomi Mi Max lines of phones. This GPU has a 256-Bus Width and uses all x16 lanes so even if it only has 8GB of VRAM, it can process a lot of data at once compared to the other variants of it's kind. It's only dual fan too so size factor.",
				"image_path": "res://assets/parts/my_gpu.png"
			}
	elif row == 3:
		if column == 0: # Row 1, Column 0: Clicking "Processor" text label
			return {
				"title": "Category Context: Random Access Memory (RAM)",
				"desc": "Temporary Data Storage for Faster Loading:\nEver experienced loading a gigantic word or office file like powerpoint and it crashes your PC? You need more ram. The ram loads everything that you run on your computer and only retrieves stuff from the ROM or SDD/HDD when it has to. So when there's not enough RAM to load a file, the system crashes unless it has a safety mechanic or way to handle that instead of just crashing. When it comes to the Speed Indicator, check your CPU and Motherboard's supported speeds. It's not plug and play as well in that, by default it's always set to 2400MHz or so even if the rating you got is higher, you have to set it manyually in the bios to activate that rated speed.",
				"image_path": "res://assets/parts/ram_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My RAMs: DDR4-3200MHz Kingston HyperX Fury RGB-8GB(Samsung Die) x2",
				"desc": "GPUs have their RAM too -> VRAM:\nThe Samsung Die is the actual chip inside the ram and it's like silicon lottery since I am not sure if there are people out there shopping for this part and deliberately trying to figure out which company made the chips inside before even buying. These are modular I guess but if you want to make sure that you get something that is compatible or works with your build, you'll want to look into your motherboard's QVL list or list of tested RAMs for that motherboard usually on the manufacturer's website where you would also get the bios update instructions if you need to when upgrading other parts.",
				"image_path": "res://assets/parts/my_ram.png"
			}
	elif row == 4:
		if column == 0: # Row 1, Column 0: Clicking "Processor" text label
			return {
				"title": "Category Context: Motherboard (Connects the parts to each other)",
				"desc": "What to look for:\nThis is like the 3rd part people see in your CPU. 1st the Casing, 2nd the GPU and then the giant board that this is unless you are on a very small form factor build. People usually look into these for stuff like quality of components/durability, features like how many and what type of ports(USB/HDMI/...) and version of those ports, built-in networking card or do you need an external WiFi/Bluetooth Dongle, number of PCIe Slots for maybe dual GPU or dual M.2 Storage Drives, RGB/ARGB/Fan Headers and their locations on the board if you are into that and lastly aesthetics on how they look. The box looks cool too.",
				"image_path": "res://assets/parts/motherboard_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Motherboard: ASRock Steel Legend B450m White",
				"desc": "Thanks JJ!:\nDuring the time I was building this PC, a friend happened to be upgrading theirs so I got this off him for a friendly price along with a CPU and RAM sticks that later got replaced.",
				"image_path": "res://assets/parts/my_motherboard.png"
			}
	elif row == 5:
		if column == 0:
			return {
				"title": "Category Context: Read Only Memory (Storage HDD/SDD)",
				"desc": "Databanks:\nThese are larger than RAM sizes since they are intended to hold the data for as long as they can so they prioritize capacity over speed. Thanks to SSDs though they got a huge speed update! Just note that apparently SSDs will lose all stored data if not powered for more than a year or so unlike HDDs that has magnetic discs inside where the data is literally carved via laser onto the disk. These also has reading/writing speed ratings.",
				"image_path": "res://assets/parts/rom_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My ROM/Storage: ADATA SX8100NP 1TB M.2 NVMe SSD",
				"desc": "This is my first SSD:\nAnd dang the speed is real, hard to believe 1TB is still somehow not enough despite living through olden days where these were much smaller in available capacities. M.2 has different keying in their connection so make sure you get the correct one for your slot on your motherboard or external case.",
				"image_path": "res://assets/parts/my_rom.png"
			}
	elif row == 6:
		if column == 0:
			return {
				"title": "Category Context: SSD Shield",
				"desc": "Kind of Optional?:\nThey supposed to help dissipate heat from it but you can have lighting on these too like what I have. MOAR RGB/ARGB Header connections!! Careful putting this on your SSDs. Electronic rule of thumb, you don't need heavy force here.",
				"image_path": "res://assets/parts/ssdshield_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My SSD Shield: Coolmoon ARGB Thingy",
				"desc": "This has like 5 LEDs:\nAnd each can be customized with any color you want. Currently 2 types of connector for Lighting peripherals: ARGB 3-pin and PWM 4-pin and your motherboard decides what you can connect. You can use splitter cables but don't forget the nuances of long cabling and load on those cables.",
				"image_path": "res://assets/parts/my_ssdshield.png"
			}
	elif row == 7:
		if column == 0:
			return {
				"title": "Category Context: Lightbar inside the Case",
				"desc": "Optional Lighting?:\nYou can even hookup an LED Strip from your PC that would run through your room I guess. Given it's length can be supported by the motherboard and PSU.",
				"image_path": "res://assets/parts/lightbar_category.png"
			}
		elif column == 1: # Row 1, Column 1: Clicking the actual chosen component text name
			return {
				"title": "My Lightbar: Coolmoon 30cm Lightbar Magnetic",
				"desc": "This has like 16? LEDs:\nAnd each can be customized with any color you want for being ARGB.",
				"image_path": "res://assets/parts/my_lightbar.png"
			}
	return {} # Fallback empty tracker
