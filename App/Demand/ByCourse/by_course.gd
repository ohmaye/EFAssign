extends Controller

const COLUMN_NAMES  = Constants.BY_COURSE_SHOW_COLUMNS
const KEY = Constants.BY_COURSE_KEY

func _ready():
	_load_data_and_render()


func _on_data_changed():
	_load_data_and_render() 


func _load_data_and_render():
	var rows = AppDB.db_get(sql)

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % rows.size()
		
	var query_info = QueryInfo.new("demand_view", Utils.filtered_columns(COLUMN_NAMES), rows, KEY )

	$Table.render(query_info)



# Below based on filtered_demand_vew
const sql = """
-- Main query for pivot table
SELECT course,
	   SUM(CASE WHEN choice = 'IM1' THEN 1 ELSE 0 END) AS IM1,
	   SUM(CASE WHEN choice = 'IM2' THEN 1 ELSE 0 END) AS IM2,
	   SUM(CASE WHEN choice = 'IM3' THEN 1 ELSE 0 END) AS IM3,
	   SUM(CASE WHEN choice = 'Ia1' THEN 1 ELSE 0 END) AS Ia1,
	   SUM(CASE WHEN choice = 'Ia2' THEN 1 ELSE 0 END) AS Ia2,
	   SUM(CASE WHEN choice = 'Ia3' THEN 1 ELSE 0 END) AS Ia3,
	   SUM(CASE WHEN choice = 'Ia4' THEN 1 ELSE 0 END) AS Ia4,
	   SUM(CASE WHEN choice = 'Ia5' THEN 1 ELSE 0 END) AS Ia5,
	   SUM(CASE WHEN choice = 'Ga1' THEN 1 ELSE 0 END) AS Ga1,
	   SUM(CASE WHEN choice = 'Ga2' THEN 1 ELSE 0 END) AS Ga2,
	   SUM(CASE WHEN choice = 'Ga3' THEN 1 ELSE 0 END) AS Ga3,
	   SUM(CASE WHEN choice = 'Ga4' THEN 1 ELSE 0 END) AS Ga4,
	   SUM(CASE WHEN choice = 'Ga5' THEN 1 ELSE 0 END) AS Ga5,
	   -- Total for each row (course)
	   SUM(CASE WHEN choice IN (SELECT choice FROM choices) THEN 1 ELSE 0 END) AS Total
FROM (
	SELECT IM1 AS course, 'IM1' AS choice, program FROM filtered_demand_view WHERE IM1 IS NOT NULL AND IM1 != ''
	UNION ALL
	SELECT IM2 AS course, 'IM2' AS choice, program FROM filtered_demand_view WHERE IM2 IS NOT NULL AND IM2 != ''
	UNION ALL
	SELECT IM3 AS course, 'IM3' AS choice, program FROM filtered_demand_view WHERE IM3 IS NOT NULL AND IM3 != ''
	UNION ALL
	SELECT Ia1 AS course, 'Ia1' AS choice, program FROM filtered_demand_view WHERE Ia1 IS NOT NULL AND Ia1 != ''
	UNION ALL
	SELECT Ia2 AS course, 'Ia2' AS choice, program FROM filtered_demand_view WHERE Ia2 IS NOT NULL AND Ia2 != ''
	UNION ALL
	SELECT Ia3 AS course, 'Ia3' AS choice, program FROM filtered_demand_view WHERE Ia3 IS NOT NULL AND Ia3 != ''
	UNION ALL
	SELECT Ia4 AS course, 'Ia4' AS choice, program FROM filtered_demand_view WHERE Ia4 IS NOT NULL AND Ia4 != ''
	UNION ALL
	SELECT Ia5 AS course, 'Ia5' AS choice, program FROM filtered_demand_view WHERE Ia5 IS NOT NULL AND Ia5 != ''
	UNION ALL
	SELECT Ga1 AS course, 'Ga1' AS choice, program FROM filtered_demand_view WHERE Ga1 IS NOT NULL AND Ga1 != ''
	UNION ALL
	SELECT Ga2 AS course, 'Ga2' AS choice, program FROM filtered_demand_view WHERE Ga2 IS NOT NULL AND Ga2 != ''
	UNION ALL
	SELECT Ga3 AS course, 'Ga3' AS choice, program FROM filtered_demand_view WHERE Ga3 IS NOT NULL AND Ga3 != ''
	UNION ALL
	SELECT Ga4 AS course, 'Ga4' AS choice, program FROM filtered_demand_view WHERE Ga4 IS NOT NULL AND Ga4 != ''
	UNION ALL
	SELECT Ga5 AS course, 'Ga5' AS choice, program FROM filtered_demand_view WHERE Ga5 IS NOT NULL AND Ga5 != ''
)
GROUP BY course

-- Add the row for column totals using a UNION ALL
UNION ALL

SELECT 'Total' AS course,
	   SUM(CASE WHEN choice = 'IM1' THEN 1 ELSE 0 END) AS IM1,
	   SUM(CASE WHEN choice = 'IM2' THEN 1 ELSE 0 END) AS IM2,
	   SUM(CASE WHEN choice = 'IM3' THEN 1 ELSE 0 END) AS IM3,
	   SUM(CASE WHEN choice = 'Ia1' THEN 1 ELSE 0 END) AS Ia1,
	   SUM(CASE WHEN choice = 'Ia2' THEN 1 ELSE 0 END) AS Ia2,
	   SUM(CASE WHEN choice = 'Ia3' THEN 1 ELSE 0 END) AS Ia3,
	   SUM(CASE WHEN choice = 'Ia4' THEN 1 ELSE 0 END) AS Ia4,
	   SUM(CASE WHEN choice = 'Ia5' THEN 1 ELSE 0 END) AS Ia5,
	   SUM(CASE WHEN choice = 'Ga1' THEN 1 ELSE 0 END) AS Ga1,
	   SUM(CASE WHEN choice = 'Ga2' THEN 1 ELSE 0 END) AS Ga2,
	   SUM(CASE WHEN choice = 'Ga3' THEN 1 ELSE 0 END) AS Ga3,
	   SUM(CASE WHEN choice = 'Ga4' THEN 1 ELSE 0 END) AS Ga4,
	   SUM(CASE WHEN choice = 'Ga5' THEN 1 ELSE 0 END) AS Ga5,
	   -- Total across all columns (time slots)
	   SUM(CASE WHEN choice IN (SELECT choice FROM choices) THEN 1 ELSE 0 END) AS Total
FROM (
	SELECT IM1 AS course, 'IM1' AS choice, program FROM filtered_demand_view WHERE IM1 IS NOT NULL AND IM1 != ''
	UNION ALL
	SELECT IM2 AS course, 'IM2' AS choice, program FROM filtered_demand_view WHERE IM2 IS NOT NULL AND IM2 != ''
	UNION ALL
	SELECT IM3 AS course, 'IM3' AS choice, program FROM filtered_demand_view WHERE IM3 IS NOT NULL AND IM3 != ''
	UNION ALL
	SELECT Ia1 AS course, 'Ia1' AS choice, program FROM filtered_demand_view WHERE Ia1 IS NOT NULL AND Ia1 != ''
	UNION ALL
	SELECT Ia2 AS course, 'Ia2' AS choice, program FROM filtered_demand_view WHERE Ia2 IS NOT NULL AND Ia2 != ''
	UNION ALL
	SELECT Ia3 AS course, 'Ia3' AS choice, program FROM filtered_demand_view WHERE Ia3 IS NOT NULL AND Ia3 != ''
	UNION ALL
	SELECT Ia4 AS course, 'Ia4' AS choice, program FROM filtered_demand_view WHERE Ia4 IS NOT NULL AND Ia4 != ''
	UNION ALL
	SELECT Ia5 AS course, 'Ia5' AS choice, program FROM filtered_demand_view WHERE Ia5 IS NOT NULL AND Ia5 != ''
	UNION ALL
	SELECT Ga1 AS course, 'Ga1' AS choice, program FROM filtered_demand_view WHERE Ga1 IS NOT NULL AND Ga1 != ''
	UNION ALL
	SELECT Ga2 AS course, 'Ga2' AS choice, program FROM filtered_demand_view WHERE Ga2 IS NOT NULL AND Ga2 != ''
	UNION ALL
	SELECT Ga3 AS course, 'Ga3' AS choice, program FROM filtered_demand_view WHERE Ga3 IS NOT NULL AND Ga3 != ''
	UNION ALL
	SELECT Ga4 AS course, 'Ga4' AS choice, program FROM filtered_demand_view WHERE Ga4 IS NOT NULL AND Ga4 != ''
	UNION ALL
	SELECT Ga5 AS course, 'Ga5' AS choice, program FROM filtered_demand_view WHERE Ga5 IS NOT NULL AND Ga5 != ''
)
"""
