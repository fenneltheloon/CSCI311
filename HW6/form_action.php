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
        ("Start Year" >= :startyear and "End Year" <= :endyear) or
        ("Start Year" <= :startyear and "End Year" >= :endyear) or
        ("Start Year" >= :startyear and "Start Year" <= :endyear) or
        ("End Year" >= :startyear and "End Year" <= :endyear)');
        $query->bindValue(':startyear', $filter['startYear']);
        $query->bindValue(':endyear', $filter['endYear']);
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
    foreach ($ids as $id) {
        $query .= '?,';
    }
    $query = rtrim($query, ',');
    $query .= ')';
    $query = $db->prepare($query);
    foreach ($ids as $index=>$id) {
        $query->bindValue($index+1, $id);
    }
    $result = $query->execute();
    return $result;
}

function processInput($input): string
{
    $input = trim($input);
    $input = stripslashes($input);
    $input = strip_tags($input);
    return htmlspecialchars($input);
}

function formatResults($result)
{
    while ($table = $result->fetchArray(SQLITE3_ASSOC)){
        printf("<details><summary><b>%s</b></summary>", $table["Title"]);
        foreach ($table as $colname => $item) {
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

function getFilters()
{
    $index = 1;
    $filters = [];
    while (isset($_GET["filterType" . $index])) {
        $filter_type = processInput($_GET["filterType" . $index]);
        if ($filter_type == 'dates') {
            $filters[$index] = ['type' => $filter_type, 'startYear' => processInput($_GET['startDateInput' . $index]), 'endYear' => processInput($_GET['endDateInput' . $index])];
        } else {
            $filters[$index] = ['type' => $filter_type, 'searchTerm' => processInput($_GET['searchTerm' . $index])];
        }

        $index += 1;
    }
    return $filters;
}

$db = new SQLite3('museum.db', SQLITE3_OPEN_READONLY, "");
formatResults(dbkeyword($db));
$db->close();
?>

</body>
</html>
