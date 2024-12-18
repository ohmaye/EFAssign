- 2024.09.04 SQLITE
  - From Neo4j download query as CSV
  - Number and order of columns must match the target table
  - Using DB Browser for SQLITE import CSV to table
  - Load it to the target table

- 2024.09.05 Project Settings
  - Plugin: SQLITE
  - Global: Run main.gd
  - Display background set to white
  - Window/Stretch: Will control how the contents scale as the window size changes


Color Palette:

1. Demand (e.g., Students’ Demands)

	•	Primary: A light blue or teal tone.
	•	Hex: #4CAFDF (Light Blue)
	•	Secondary: A softer blue for less emphasis.
	•	Hex: #A9D6F9 (Soft Blue)
	•	Rationale: Blue tones evoke calm and trust, perfect for displaying demand in a balanced, less overwhelming way.

2. Supply (e.g., Supply of Teachers, Classes, etc.)

	•	Primary: A lively green, symbolizing availability and growth.
	•	Hex: #66BB6A (Medium Green)
	•	Secondary: A light mint tone to complement.
	•	Hex: #A5D6A7 (Light Mint Green)
	•	Rationale: Green is associated with resources and growth, which matches well with the concept of supply.

3. Assign (Assigning Supply to Demand)

	•	Primary: A warm, energetic orange to denote the action of assigning.
	•	Hex: #FFA726 (Orange)
	•	Secondary: A softer peach for background or subtle actions.
	•	Hex: #FFCC80 (Peach)
	•	Rationale: Orange adds a bit of energy and excitement, making the action of assigning feel more dynamic.

4. General Functions (e.g., Neutral/White Area)

	•	Primary: White or off-white for neutral areas.
	•	Hex: #FFFFFF (White)
	•	Hex: #F5F5F5 (Light Gray)
	•	Secondary: Light gray to create subtle dividers or areas where general functions are performed.
	•	Hex: #E0E0E0 (Gray)

Example of Color Assignment:

	•	Demand: Light Blue (#4CAFDF) for primary headers and buttons, with Soft Blue (#A9D6F9) for backgrounds or secondary areas.
	•	Supply: Medium Green (#66BB6A) for primary actions and accents, with Light Mint Green (#A5D6A7) for backgrounds.
	•	Assign: Orange (#FFA726) for the most critical buttons or actions, with Peach (#FFCC80) for lighter areas.
	•	General: White (#FFFFFF) and Light Gray (#F5F5F5) for neutral areas like general functions or panels that don’t belong to a specific section.

Playful Yet Discreet Tone:

	•	The blue-green palette for “Demand” and “Supply” is calming and professional but still engaging.
	•	The orange accents in the “Assign” section add energy and make the action clear without being overbearing.
	•	The neutral tones (white and gray) keep the interface clean and organized, ensuring the application doesn’t feel overwhelming.

This palette balances a professional, business-like feel with subtle, playful undertones, making it ideal for a school environment while allowing clear, discrete distinctions between the major sections.


DATA 2024.09.25
- Demand
  - survey
  - demand
  - students
  - studentpreferences
- Assign
  - assignments	
  - teacherpreferences
- Supply
  - classes
  - courses
  - rooms
  - teachers
  - timeslots
- Utils
  - weekdays


ToDo:
- Add New only works for teachers (2024.09.26)
- Assign
  - Can be much more powerful
  - When assigned, disable and don't count assigned students
  - On the supply side, show who is assigned
  - From the supply, allow to be de-assigned. Returning to demand
  - Show checkmark in the selected students (center panel) to confirm assignment
  - Make the Class Selected a bit more clear about Single Selection
- Assignments
  - Allow them to mark "Uploaded"
- CanvasLayers
  - Powerful to create unusual effects for a business app...
- Survey
  - Add or Replace to handle trickle down students.
- File/DB
  - Should load preferences and check if there's a saved path
  - If there is one, see if the file can be open and open that DB
  - If it cannot be open, then open the default DB (in project)
  - Save it in user://
  - If it opens, that'll become the active DB
  - OPEN:
    - Check if the DB can be open.
    - If not, then indicate so, and wait for another selection
    - If yes, then that becomes the active DB. Save path to prefs. Next default.
  - UserPreferences
    - Trying to load a non-existend file first time app runs
  - NEW: 
    - Load an empty (default) DB (in project)
    - Save it in user://
  - Teacher Note
    - Strange behavior. Adding "-" or "" causes problems
- Godot Engine v4.3.stable.official.77dcf97d8 - https://godotengine.org
- Check EDITING features given all the views used
- Totals:
  - Need to work on the totals in the demand tab.
  - When we selected choices, the total is still counting rows from the entire set
  - That query needs to be written in gdscript and run agains sqlite -- sqlite can't create queries dynamically.


- Naming case errors show up in exported app. Log files:
  - /Library/Application Support/Godot
  - Very helpful

4.4.3 - Had problems with SQLITE. 4.4.3 was deleting .godot/extension_list.cfg on start. SQLITE not found.
4.4.2 - Rolled back and SQLITE was okay. Now, Windows goes fullscreen. Need to solve that but otherwise seems okay.

4.4.2 To make it run on Windows
- Tricky combo
  - Export x86 (otherwise SQLITE won't work on ARM, if it is compiled to ARM)
  - Look at performance issues on ARM with an emulator (Parallels)
2024.10.14
- VIEWS
  - Gotta be careful with the panels based on views. They cannot be edited directly.
    - Students: OK
    - By Student: Based on Demand_view. NOT OK
    - By Course
    - By Level
    - Teacher Preferences
    - Classes 
  2024.10.16
  - Better to put Control (or Node) at the top of a scene to make it easier to shuffle the tree around
  - Did that with Assignments. Also, aligning coluns with the Tree columns (columns of a gridcontainer). If done via "resized" signal can keep things aligned perfectly. Get the column width from the Tree and set the size in the gridcontainer.
  - Doing that for filters.
  - EO Note: Every time I want to do something in Godot, I end up finding the path to a solution. 
      - Very satisfying.
- 2024.10.18 Friday (Kozue/Haruna)
  - Preserve filters when assigning in Assignments
  - Changed since 2438: Classes, Teachers
  - Need to add "Uploaded to Atlantis"
- 2024.11.04
  - The options in Class all have an empty item in the .tscn
  - Is there any case where this will cause problems in the index?...
- 2024.11.11
  - Will try 4.4 Dev 4