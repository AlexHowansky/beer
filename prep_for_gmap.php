#!/usr/bin/env php
<?php

// Scans the latest CSV for each state, and makes one big CSV,
// excluding breweries where type=planning or address is missing.
// If you provide command line parameters, they'll be taken as
// regexes to match state names against. (Google Maps allows
// only 2000 points per map.)

require_once __DIR__ . '/vendor/autoload.php';

$out = new \Ork\Csv\Writer([
    'file' => 'gmap.csv'
]);

$patterns = array_slice($argv, 1);

foreach (scandir(__DIR__ . '/archive/United_States', SCANDIR_SORT_ASCENDING) as $state) {

    if ($state[0] === '.') {
        continue;
    }

    if (empty($patterns) === true) {
        $include = true;
    } else {
        $include = false;
        foreach ($patterns as $pattern) {
            if (preg_match('/' . $pattern. '/i', $state) > 0) {
                $include = true;
                break;
            }
        }
    }
    if ($include === false) {
        continue;
    }

    echo "Including state $state... ";

    $last = scandir(__DIR__ . "/archive/United_States/$state", SCANDIR_SORT_DESCENDING)[0];
    if ($last[0] === '.') {
        echo "no files, skipped\n";
        continue;
    }

    foreach (new \Ork\Csv\Reader(['file' => __DIR__ . "/archive/United_States/$state/$last"]) as $row) {
        if (
            $row['type'] === 'planning' ||
            empty($row['address1']) === true
        ) {
            continue;
        }
        $out->write($row);
    }

    echo "done\n";

}
