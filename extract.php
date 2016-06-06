#!/usr/bin/env php
<?php

function filter($value)
{
    return preg_replace('/\s+/', ' ', trim($value));
}

function untag($value)
{
    return substr($value, strpos($value, ':') + 2);
}

function phone($value)
{
    $phone = preg_replace('/[^\d]+/', '', $value);
    if (strlen($phone) !== 10) {
        return $value;
    }
    return sprintf('(%s) %s-%s', substr($phone, 0, 3), substr($phone, 3, 3), substr($phone, 6, 4));
}

$config = [
    'add-xml-decl' => true,
    'add-xml-space' => true,
    'output-xml' => true,
    'indent' => true,
    'indent-cdata' => true,
    'indent-spaces' => 4,
];

$fp = fopen('php://stdout', 'w');
fputcsv($fp, ['name', 'address1', 'address2', 'city', 'state', 'zip', 'phone', 'type', 'url']);
$xml = new SimpleXMLElement(tidy_repair_string(file_get_contents('php://stdin'), $config, 'utf8'));
foreach ($xml->xpath('//div[@class="brewery"]/ul[@class="vcard simple"]') as $block) {

    $name = filter((string) $block->xpath('li[@class="name"]')[0]);

    $addrBlock = $block->xpath('li[@class="address"]');
    if (empty($addrBlock)) {
        $address1 = '';
        $address2 = filter((string) $block->xpath('li[@class="name"]/following-sibling::li')[0]);
    } else {
        $address1 = filter((string) $addrBlock[0]);
        $address2 = filter((string) $block->xpath('li[@class="address"]/following-sibling::li')[0]);
    }
    if (preg_match('/^([^,]+)\s*,\s*([A-Z]{2})\s+([\d-]+)/', $address2, $match)) {
        $address2 = '';
        $city = $match[1];
        $state = $match[2];
        $zip = $match[3];
    } else {
        $city = '';
        $state = '';
        $zip = '';
    }

    $phoneBlock = $block->xpath('li[@class="telephone"]');
    $phone = empty($phoneBlock) ? '' : phone(untag(filter((string) $phoneBlock[0])));

    $typeBlock = $block->xpath('li[@class="brewery_type"]');
    $type = empty($typeBlock) ? '' : strtolower(untag(filter((string) $typeBlock[0])));

    $urlBlock = $block->xpath('li[@class="url"]/a');
    $url = empty($urlBlock) ? '' : strtolower(filter((string) $urlBlock[0]->attributes()->href));

    $data = [
        'name' => $name,
        'address1' => $address1,
        'address2' => $address2,
        'city' => $city,
        'state' => $state,
        'zip' => $zip,
        'phone' => $phone,
        'type' => $type,
        'url' => $url,
    ];

    fputcsv($fp, $data);
}

fclose($fp);
