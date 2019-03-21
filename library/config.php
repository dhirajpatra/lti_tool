<?php

// FOR data base tc_lti
define('TC_LOCALHOST', 'localhost');
define('TC_USERNAME', 'root');
define('TC_PASSWORD', 'mysqladmin');
define('TC_DATABASE', 'tc_lti');

// FOR data base tp_lti
define('TP_LOCALHOST', 'localhost');
define('TP_USERNAME', 'root');
define('TP_PASSWORD', 'mysqladmin');
define('TP_DATABASE', 'tp_lti');

define('ACTIVE', 1);
define('INACTIVE', 2);

define('REGISTRATION_PROXY_TABLE', 'lti_tool_proxy_reg');        //Stores User information during TOOL PROXY REGISTRATION PROCESS.
define('LTI_CONSUMER_SECRET', 'lti_consumer_secret');            // Stores the Basic USER INFORMATION for SECRET KEY.
define('LTI_CAPABILITIES', 'lti_capability');                  // STORES DEFAULT TOOL PROVIDER capabilities for validation purpose.
define('LTI_TOOLCONSUMER_CAPABILITIES', 'lti_tc_capability');  // STORES all Tool Consumer provided capabilities.
define('LTI_TOOLCONSUMER_SERVICES', 'lti_tc_service');          //STORES all the SERIVES that are offered by the Tool Consumer.
define('LTI_TC_LAUNCH_DETAILS', 'lti_tc_launch_detail');
define('LTI_USER_ROLE', 'lti_user_roles');
define('LTI_RESOURCE_INFO', 'lti_resource_info');
define('LTI_RESOURCE_ACCESS', 'lti_resource_access');
define('LTI_CONSUMER_CANVAS', 'lti_consumer_canvas');
define('LTI_ASSIGNMENTS', 'lti_assignments');

define('HOST', 'http://localhost');
define('DOCUMENT_ROOT', '/var/www/html/lti_v2');

// Following values needs to update from CP4 team
// http://dev-thepoint.hlrpphoenix.com/gateway [login]
// tcsall / TCSQAtest
define('x_access_token', 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzc28ud2tocGUuY29tIiwiYXVkIjoiM2MzOTg0NmMtODg2YS1kZjExLWIxMTUtMDA1MDU2YzAwMDA4IiwiYXV0aF90aW1lIjoxNTUzMTU4OTg3LCJuYW1lIjoiVENTIFNhbGVzIFVzZXIiLCJqdGkiOiJmMDc0ZGUwOC1lZDhiLTRhZWUtODQxZi1iNzlkNTM1NGM2NGIiLCJpYXQiOjE1NTMxNTg5ODcsImV4cCI6MTU1MzI0NTM4Nywic3ViIjoiZDg2ZDYwNWMtN2M1Ny00MGM2LThkODgtMzk0NTAxNDA2NTE4Iiwicm9sZXMiOiJ3a2hwZS1hZG1pbiIsIndraHBlX3Blcm1pc3Npb25zIjpbIkhhc0FjY2Vzc1RvQWxsQ29udGVudCIsIkNhblVzZVBlcnNvbmFsaXphdGlvbkZlYXR1cmVzIl0sIndraHBlX3Rva2VuIjoiVkpzb2hLME4rM1hjLzFMNDVyRlFBQjg1RDdldHIwQWlQam1icUZxYlJET3RTcmRWRjBSN1NEVXVSdUYxa0p5Z2R5bnVPTGhlRHRqT1BLOUhaZDhQcHFiUEJPQUt4TXhoQVhUS29jS2UvZHdrT2x4c2IzaGg0NGxYb2dtcTlmbHF2RkFTb2F4UndLMmlPY2ZGVTBCcFNZWSt2OXhRRWsxOEkrTXNscVJ0Ti9BZWN4dThmSlI1cFZtcXBtaEFwM3ZZOE90V3NZblBMOEViS0RqRmRoTXFPc1A4Y3Z0VW90bndhcnVaZnlPL1lOYz0iLCJ0b2tlbl90eXBlIjoiYmVhcmVyIn0.Rs7pu6ig1FZPWyjxj2Ppgl4CDDLOm6m_BPZ89kVLpXqljVmFbA0iHmM0bWvA8ycKsB0kWlAQAkHf65rdimThG9nD0hPdIXDS4sVmvdSktu1fCOLqeDwAny_C-RqrKiKOWlRRdtFuuEncPA6xMDE8dtWcUAf5iwhWLxS8NivRITY');

define('CP4_DEV_API', 'http://dev01-api.hlrpphoenix.com/api/asset-meta-aggregator-management/v1/assets');
define('CP4_RETRIEVE_DEV_API', 'http://dev01-api.hlrpphoenix.com/api/asset-management/v1/assets/');
// Above values needs to update from CP4 team