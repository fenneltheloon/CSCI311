<!DOCTYPE html>
<html lang="en">
<head>
    <title>AMAM Query Search Results</title>
    <style>
        details {
            padding: 10px;
            border: 1px solid grey;
            border-radius: 3px;
        }
    </style>
</head>
<body>
<h1>AMAM Search Results</h1>

<?php

function dbGetIDs($db, $filter)
{
    if ($filter['type'] == 'Dates') {
        $query = $db->prepare('select objects.ObjectID from objects join dates on objects.ObjectID = dates.ObjectID where 
        ("Start Year" >= ? and "End Year" <= ?) or
        ("Start Year" <= ? and "End Year" >= ?) or
        ("Start Year" >= ? and "Start Year" <= ?) or
        ("End Year" >= ? and "End Year" <= ?)');
        for ($i = 1; $i <= 8; $i++) {
            if ($i % 2 == 0) {
                $query->bindValue($i, $filter['endYear'], SQLITE3_INTEGER);
            } else {
                $query->bindValue($i, $filter['startYear'], SQLITE3_INTEGER);
            }
        }
        //TODO: it doesnt workkkkkk
        $result = $query->execute();
    } else if ($filter['type'] == 'Materials / Techniques'){
        $query = $db->prepare('select objects.ObjectID from (objects join object_has_material 
        on objects.ObjectID = object_has_material.ObjectID) join materials 
        on materials.MaterialID = object_has_material.MaterialID where Material = :material');
        $query->bindValue(':material', $filter['searchTerm']);
        $result = $query->execute();
    } else if ($filter['type'] == 'Keyword') {
        $query = $db->prepare('select ObjectID from object_search where object_search match :searchterm order by rank');
        $query->bindValue(':searchterm', $filter['searchTerm']);
        $result = $query->execute();
    } else {
        $query = $db->prepare('select ObjectID from objects where :column like \'%:searchterm%\'');
        $query->bindValue(':column', $filter['type']);
        $query->bindValue(':searchterm', $filter['searchTerm']);
        $result = $query->execute();
    }
    return $result;
}

function dbGetEntries($db, $ids)
{
    $query = 'select ObjectID, Title, "Object Name", "Artist/Maker", Dated, "Materials / Techniques", 
        Dimensions, "Credit Line", "Accession Number", "Object Status", Department, Classification, "Acquisition Method", 
        Description, Culture, "Period/Dynasty", "eMuseum Label Text" from objects where ObjectID in (';
    foreach ($ids as $ignored) {
        $query .= '?, ';
    }
    $query = rtrim($query, ', ');
    $query .= ')';
    $query = $db->prepare($query);
    $index = 1;
    foreach ($ids as $id) {
        $query->bindValue($index, $id);
        $index += 1;
    }
    return $query->execute();
}

function processInput($input): string
{
    $input = trim($input);
    $input = stripslashes($input);
    $input = strip_tags($input);
    return htmlspecialchars($input);
}

function formatResults($result): void
{
    while ($table = $result->fetchArray(SQLITE3_ASSOC)){
        printf("<details><summary><b>%s</b></summary>", $table["Title"]);
        foreach ($table as $colname=>$item) {
            if ($colname == 'ObjectID') {
                printf("<a href=\"https://allenartcollection.oberlin.edu/objects/%d\" target=\"_blank\">Visit AMAM Object Page</a>", $item);
            } elseif ($colname == 'Title') {
                continue;
            } else {
                printf("<p><b>%s:</b> %s</p>", $colname, processInput($item));
            }
        }
        print "</details>";

    }
}

function getFilters(): array
{
    $index = 1;
    $filters = [];
    while (isset($_GET["filterType" . $index])) {
        $filter_type = processInput($_GET["filterType" . $index]);
        if ($filter_type == 'Dates') {
            $filters[$index] = ['type' => $filter_type, 'startYear' => (int)processInput($_GET['startDateInput' . $index]), 'endYear' => (int)processInput($_GET['endDateInput' . $index])];
        } else {
            $filters[$index] = ['type' => $filter_type, 'searchTerm' => processInput($_GET['searchTerm' . $index])];
        }

        $index += 1;
    }
    return $filters;
}

function filterCombine($ids): array
{
    $combine = processInput($_GET['filterCombine']);
    $id_uniq = array_unique($ids);
    if ($combine == 'OR') {
        return $id_uniq;
    } else {
        return array_diff_assoc($ids, $id_uniq);
    }
}

$db = new SQLite3('museum.db', SQLITE3_OPEN_READONLY, "");
$filters = getFilters();
$ids = [];
foreach ($filters as $index=>$filter) {
    $result = dbGetIDs($db, $filter);
    $test = 0;
    while ($row = $result->fetchArray(SQLITE3_NUM)){
        $ids[] = $row[0];
        $test += 1;
    }
}
$ids = filterCombine($ids);
$result = dbGetEntries($db, $ids);
formatResults($result);
$db->close();
?>

</body>
</html>
