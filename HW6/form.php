<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AMAM Database App</title>
    <script type="text/javascript">
        function handleSelection(value, formId) {
            document.getElementById('filterType'+formId).disabled=true;
            if (value === "Dates") {
                document.getElementById('startDateInput'+formId).hidden=false;
                document.getElementById('startDateInput'+formId).disabled=false;
                document.getElementById('endDateInput'+formId).hidden=false;
                document.getElementById('endDateInput'+formId).disabled=false;

                document.getElementById('searchTerm'+formId).hidden=true;
                document.getElementById('searchTerm'+formId).disabled=true;
                document.getElementById('materialInput'+formId).hidden=true;
                document.getElementById('materialInput'+formId).disabled=true;
            } else if (value === "Materials/Techniques") {
                document.getElementById('startDateInput'+formId).hidden=true;
                document.getElementById('startDateInput'+formId).disabled=true;
                document.getElementById('endDateInput'+formId).hidden=true;
                document.getElementById('endDateInput'+formId).disabled=true;
                document.getElementById('searchTerm'+formId).hidden=true;
                document.getElementById('searchTerm'+formId).disabled=true;

                document.getElementById('materialInput'+formId).hidden=false;
                document.getElementById('materialInput'+formId).disabled=false;
            } else {
                document.getElementById('startDateInput'+formId).hidden=true;
                document.getElementById('startDateInput'+formId).disabled=true;
                document.getElementById('endDateInput'+formId).hidden=true;
                document.getElementById('endDateInput'+formId).disabled=true;
                document.getElementById('materialInput'+formId).hidden=true;
                document.getElementById('materialInput'+formId).disabled=true;

                document.getElementById('searchTerm'+formId).hidden=false;
                document.getElementById('searchTerm'+formId).disabled=false;
            }
            document.getElementById('filterType'+formId).disabled=false;
        }

        function addFilter(formId) {
            document.getElementById('addFilter' + formId).remove();
            var removebutton = document.getElementById('removeFilter' + (formId - 1));
            if (removebutton) {
                removebutton.remove();
            }
            var fieldset = document.createElement('fieldset');
            fieldset.setAttribute('id', 'filter' + formId);
            var legend = document.createElement('legend');
            legend.innerText = 'Filter ' + formId;
            fieldset.appendChild(legend);

            var filtertype = document.createElement("select");
            filtertype.setAttribute('name', 'filterType' + formId);
            filtertype.setAttribute('id', 'filterType' + formId);
            filtertype.setAttribute('onchange', 'handleSelection(value, ' + formId + ')');
            filtertype.innerHTML = '<option value="Keyword" selected>Keyword</option>\n' +
                '<option value="ObjectID">Object ID</option>\n' +
                '<option value="Accession Number">Accession Number</option>\n' +
                '<option value="Object Number">Object Number</option>\n' +
                '<option value="Sort Number">Sort Number</option>\n' +
                '<option value="Department">Department</option>\n' +
                '<option value="Classification">Classification</option>\n' +
                '<option value="Acquisition Method">Acquisition Method</option>\n' +
                '<option value="Object Status">Object Status</option>\n' +
                '<option value="Artist/Maker">Artist/Maker</option>\n' +
                '<option value="Title">Title</option>\n' +
                '<option value="Object Name">Object Name</option>\n' +
                '<option value="Dates">Dates</option>\n' +
                '<option value="Materials/Techniques">Materials/Techniques</option>\n' +
                '<option value="Dimensions">Dimensions</option>\n' +
                '<option value="Description">Description</option>\n' +
                '<option value="Credit Line">Credit Line</option>\n' +
                '<option value="Culture">Culture</option>\n' +
                '<option value="Period/Dynasty">Period/Dynasty</option>\n' +
                '<option value="eMuseum Label Text">eMuseum Label Text</option>\n';
            fieldset.appendChild(filtertype);

            var searchterm = document.createElement("input");
            searchterm.setAttribute('type', 'text');
            searchterm.setAttribute('name', 'searchTerm' + formId);
            searchterm.setAttribute('id', 'searchTerm' + formId);
            searchterm.setAttribute('placeholder', 'Enter search term');
            fieldset.appendChild(searchterm)

            var startdateinput = document.createElement('input');
            startdateinput.setAttribute('type', 'number');
            startdateinput.setAttribute('name', 'startDateInput' + formId);
            startdateinput.setAttribute('id', 'startDateInput' + formId);
            startdateinput.setAttribute('placeholder', 'Enter start year');
            startdateinput.setAttribute('hidden', true);
            startdateinput.setAttribute('disabled', true);
            fieldset.appendChild(startdateinput);

            var enddateinput = document.createElement('input');
            enddateinput.setAttribute('type', 'number');
            enddateinput.setAttribute('name', 'endDateInput' + formId);
            enddateinput.setAttribute('id', 'endDateInput' + formId);
            enddateinput.setAttribute('placeholder', 'Enter end year');
            enddateinput.setAttribute('hidden', 'true');
            enddateinput.setAttribute('disabled', 'true');
            fieldset.appendChild(enddateinput);

            var materialinput = document.createElement('input');
            materialinput.setAttribute('type', 'text');
            materialinput.setAttribute('name', 'materialInput' + formId);
            materialinput.setAttribute('id', 'materialInput' + formId);
            materialinput.setAttribute('placeholder', 'Enter search term');
            materialinput.setAttribute('list', 'materialList');
            materialinput.setAttribute('hidden', 'true');
            materialinput.setAttribute('disabled', 'true');
            fieldset.appendChild(materialinput);

            var addbutton = document.createElement("button");
            addbutton.setAttribute('id', 'addFilter' + (formId + 1));
            addbutton.setAttribute('onclick', 'addFilter(' + (formId + 1) + ')');
            addbutton.innerText = "Add Filter";

            removebutton = document.createElement('button');
            removebutton.setAttribute('id', 'removeFilter' + formId);
            removebutton.setAttribute('onclick', 'removeFilter(' + formId + ')');
            removebutton.innerText = "Remove Filter";

            if (formId === 1) {
                var filtercombine = document.getElementById('filterCombineSet');
                filtercombine.after(fieldset, addbutton, removebutton);
            } else {
                var lastfilter = document.getElementById('filter' + (formId - 1));
                lastfilter.after(fieldset, addbutton, removebutton);
            }
        }

        function removeFilter(formId) {
            document.getElementById('addFilter' + (formId + 1)).remove();
            document.getElementById('removeFilter' + formId).remove();
            document.getElementById('filter' + formId).remove();

            var addbutton = document.createElement("button");
            addbutton.setAttribute('id', 'addFilter' + formId);
            addbutton.setAttribute('onclick', 'addFilter(' + formId + ')');
            addbutton.innerText = "Add Filter";
            if (formId !== 1) {
                var removebutton = document.createElement('button');
                removebutton.setAttribute('id', 'removeFilter' + (formId - 1));
                removebutton.setAttribute('onclick', 'removeFilter(' + (formId - 1) + ')');
                removebutton.innerText = "Remove Filter";
                var lastfilter = document.getElementById('filter' + (formId - 1));
                lastfilter.after(addbutton, removebutton);
            } else {
                var filtercombine = document.getElementById('filterCombineSet');
                filtercombine.after(addbutton);
            }
        }
    </script>
</head>
<body onload="addFilter(1)">
<h1>AMAM Database Lookup</h1>
<form id="queryForm" action="form_action.php" method="get">
    <datalist id="materialList">
        <?php
        $db = new SQLite3('museum.db', SQLITE3_OPEN_READONLY, "");
        $materials = $db->query('select Material from materials');
        while ($material = $materials->fetchArray(SQLITE3_NUM)) {
            printf('<option value="%s">', $material[0]);
        }
        ?>
    </datalist>
    <fieldset id="filterCombineSet">
        <legend>Filter Combine</legend>
        <label>AND<input type="radio" name="filterCombine" id="filterCombineAnd" value="AND" checked></label>
        <label>OR<input type="radio" name="filterCombine" id="filterCombineOr" value="OR"></label>
    </fieldset>
    <button id="addFilter1" onclick="addFilter(1)">Add Filter</button>
    <br><br>
    <input type="submit" name="submitButton" id="submitButton">

</form>
</body>
</html>