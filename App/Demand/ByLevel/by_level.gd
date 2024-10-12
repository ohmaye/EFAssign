extends Controller

# By Level
const SHOW_COLUMNS = [  
    "course",
    "level",
	"IM1",
	"IM2",
	"IM3",
	"Ia1",
	"Ia2",
	"Ia3",
	"Ia4",
	"Ia5",
	"Ga1",
	"Ga2",
	"Ga3",
	"Ga4",
	"Ga5",
    "Total"
]
const KEY = "level"

func _ready():
	_load_data_and_render()


func _on_data_changed():
	_load_data_and_render() 


func _load_data_and_render():
	var rows = AppDB.db_get(sql)

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % rows.size()
		
	var query_info = QueryInfo.new("demand_view", Utils.filtered_columns(SHOW_COLUMNS), rows, KEY )   

	$Table.render(query_info)


# Below based on filtered_demand_vew
const sql = """
SELECT course, level,
	   SUM(CASE WHEN time_slot = 'IM1' THEN 1 ELSE 0 END) AS IM1,
	   SUM(CASE WHEN time_slot = 'IM2' THEN 1 ELSE 0 END) AS IM2,
	   SUM(CASE WHEN time_slot = 'IM3' THEN 1 ELSE 0 END) AS IM3,
	   SUM(CASE WHEN time_slot = 'Ia1' THEN 1 ELSE 0 END) AS Ia1,
	   SUM(CASE WHEN time_slot = 'Ia2' THEN 1 ELSE 0 END) AS Ia2,
	   SUM(CASE WHEN time_slot = 'Ia3' THEN 1 ELSE 0 END) AS Ia3,
	   SUM(CASE WHEN time_slot = 'Ia4' THEN 1 ELSE 0 END) AS Ia4,
	   SUM(CASE WHEN time_slot = 'Ia5' THEN 1 ELSE 0 END) AS Ia5,
	   SUM(CASE WHEN time_slot = 'Ga1' THEN 1 ELSE 0 END) AS Ga1,
	   SUM(CASE WHEN time_slot = 'Ga2' THEN 1 ELSE 0 END) AS Ga2,
	   SUM(CASE WHEN time_slot = 'Ga3' THEN 1 ELSE 0 END) AS Ga3,
	   SUM(CASE WHEN time_slot = 'Ga4' THEN 1 ELSE 0 END) AS Ga4,
	   SUM(CASE WHEN time_slot = 'Ga5' THEN 1 ELSE 0 END) AS Ga5,
	   -- Total for each course and level (row total)
	   SUM(CASE WHEN time_slot IN (SELECT choice FROM choices) THEN 1 ELSE 0 END) AS Total
FROM (
	SELECT IM1 AS course, level, 'IM1' AS time_slot FROM filtered_demand_view WHERE IM1 IS NOT NULL AND IM1 != '' 
	UNION ALL
	SELECT IM2 AS course, level, 'IM2' AS time_slot FROM filtered_demand_view WHERE IM2 IS NOT NULL AND IM2 != '' 
	UNION ALL
	SELECT IM3 AS course, level, 'IM3' AS time_slot FROM filtered_demand_view WHERE IM3 IS NOT NULL AND IM3 != '' 
	UNION ALL
	SELECT Ia1 AS course, level, 'Ia1' AS time_slot FROM filtered_demand_view WHERE Ia1 IS NOT NULL AND Ia1 != '' 
	UNION ALL
	SELECT Ia2 AS course, level, 'Ia2' AS time_slot FROM filtered_demand_view WHERE Ia2 IS NOT NULL AND Ia2 != '' 
	UNION ALL
	SELECT Ia3 AS course, level, 'Ia3' AS time_slot FROM filtered_demand_view WHERE Ia3 IS NOT NULL AND Ia3 != '' 
	UNION ALL
	SELECT Ia4 AS course, level, 'Ia4' AS time_slot FROM filtered_demand_view WHERE Ia4 IS NOT NULL AND Ia4 != '' 
	UNION ALL
	SELECT Ga5 AS course, level, 'Ga5' AS time_slot FROM filtered_demand_view WHERE Ga5 IS NOT NULL AND Ga5 != '' 
	UNION ALL
	SELECT Ga1 AS course, level, 'Ga1' AS time_slot FROM filtered_demand_view WHERE Ga1 IS NOT NULL AND Ga1 != '' 
	UNION ALL
	SELECT Ga2 AS course, level, 'Ga2' AS time_slot FROM filtered_demand_view WHERE Ga2 IS NOT NULL AND Ga2 != '' 
	UNION ALL
	SELECT Ga3 AS course, level, 'Ga3' AS time_slot FROM filtered_demand_view WHERE Ga3 IS NOT NULL AND Ga3 != '' 
	UNION ALL
	SELECT Ga4 AS course, level, 'Ga4' AS time_slot FROM filtered_demand_view WHERE Ga4 IS NOT NULL AND Ga4 != '' 
	UNION ALL
	SELECT Ga5 AS course, level, 'Ga5' AS time_slot FROM filtered_demand_view WHERE Ga5 IS NOT NULL AND Ga5 != '' 
)
GROUP BY course, level
ORDER BY course, level;
"""
