___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "CAPI Event Batcher",
  "categories": [
    "ADVERTISING",
    "CONVERSIONS",
    "UTILITY"
  ],
  "brand": {
    "id": "brand_digitalanalytix",
    "displayName": "DigitalAnalytix"
  },
  "description": "Batches server-side conversion events and sends them in bulk to OpenAI Conversions API, Meta Conversions API, TikTok Events API, or a custom endpoint. Reduces outbound requests on high-traffic containers by flushing on batch size or age thresholds.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "vendor",
    "displayName": "Vendor",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "openai",
        "displayValue": "OpenAI Conversions API"
      },
      {
        "value": "meta",
        "displayValue": "Meta Conversions API"
      },
      {
        "value": "tiktok",
        "displayValue": "TikTok Events API"
      },
      {
        "value": "custom",
        "displayValue": "Custom Endpoint"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "openai",
    "help": "The destination API. Determines endpoint, authentication, and batch body format."
  },
  {
    "type": "TEXT",
    "name": "eventPayload",
    "displayName": "Event Payload",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "A variable returning ONE event object already shaped for the selected vendor (e.g. an OpenAI event with id/type/timestamp_ms/data, or a Meta event with event_name/event_time/user_data). The batcher only queues and sends — it does not reshape events."
  },
  {
    "type": "TEXT",
    "name": "openaiPixelId",
    "displayName": "Pixel ID",
    "simpleValueType": true,
    "help": "Your OpenAI Pixel ID from the Ads Manager conversions tab.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "openai",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "openaiApiKey",
    "displayName": "API Key",
    "simpleValueType": true,
    "help": "Your OpenAI Conversions API key.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "openai",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "metaPixelId",
    "displayName": "Pixel ID",
    "simpleValueType": true,
    "help": "Your Meta Pixel ID.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "meta",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "metaAccessToken",
    "displayName": "Access Token",
    "simpleValueType": true,
    "help": "Your Meta Conversions API access token.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "meta",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "metaApiVersion",
    "displayName": "Graph API Version",
    "simpleValueType": true,
    "defaultValue": "v21.0",
    "help": "Meta Graph API version used in the endpoint URL.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "meta",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "metaTestEventCode",
    "displayName": "Test Event Code (Optional)",
    "simpleValueType": true,
    "help": "When set, events are sent with test_event_code for Meta Events Manager testing.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "meta",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "tiktokPixelCode",
    "displayName": "Pixel Code",
    "simpleValueType": true,
    "help": "Your TikTok Pixel Code (event_source_id).",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "tiktok",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "tiktokAccessToken",
    "displayName": "Access Token",
    "simpleValueType": true,
    "help": "Your TikTok Events API access token.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "tiktok",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "customEndpoint",
    "displayName": "Endpoint URL",
    "simpleValueType": true,
    "help": "Full HTTPS URL events are POSTed to. Body is {\"events\": [...]}.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "custom",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "customAuthHeaderName",
    "displayName": "Auth Header Name (Optional)",
    "simpleValueType": true,
    "help": "e.g. Authorization or X-Api-Key.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "custom",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "customAuthHeaderValue",
    "displayName": "Auth Header Value (Optional)",
    "simpleValueType": true,
    "help": "e.g. Bearer my-token.",
    "enablingConditions": [
      {
        "paramName": "vendor",
        "paramValue": "custom",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "batchingGroup",
    "displayName": "Batching",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "TEXT",
        "name": "batchSize",
        "displayName": "Batch Size",
        "simpleValueType": true,
        "defaultValue": "20",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          },
          {
            "type": "POSITIVE_NUMBER"
          }
        ],
        "help": "Flush when this many events are queued. Vendor batch limits apply (max 1000 for OpenAI, Meta, and TikTok)."
      },
      {
        "type": "TEXT",
        "name": "maxWaitSeconds",
        "displayName": "Max Wait (seconds)",
        "simpleValueType": true,
        "defaultValue": "10",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          },
          {
            "type": "POSITIVE_NUMBER"
          }
        ],
        "help": "Flush when the oldest queued event is older than this, even if the batch is not full. Checked when the next event arrives."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const sendHttpRequest = require('sendHttpRequest');
const templateDataStorage = require('templateDataStorage');
const getTimestampMillis = require('getTimestampMillis');
const encodeUriComponent = require('encodeUriComponent');
const makeString = require('makeString');
const makeInteger = require('makeInteger');
const makeNumber = require('makeNumber');
const getType = require('getType');
const JSON = require('JSON');
const log = require('logToConsole');

const payload = data.eventPayload;
if (!payload || getType(payload) !== 'object') {
  log('CAPI Batcher: Event Payload must be an object — got ' + getType(payload));
  data.gtmOnFailure();
  return;
}

const vendor = data.vendor;
const queueKey = 'capi_batch_queue_' + vendor + '_' + vendorId();
const tsKey = queueKey + '_first_ts';

let queue = templateDataStorage.getItemCopy(queueKey);
if (!queue || getType(queue) !== 'array') {
  queue = [];
}

queue.push(payload);

let firstTs = templateDataStorage.getItemCopy(tsKey);
const now = getTimestampMillis();
if (queue.length === 1 || !firstTs) {
  firstTs = now;
  templateDataStorage.setItemCopy(tsKey, firstTs);
}

const batchSize = clampInt(data.batchSize, 1, 1000, 20);
const maxWaitMs = clampInt(data.maxWaitSeconds, 1, 3600, 10) * 1000;

const shouldFlush = queue.length >= batchSize || (now - makeNumber(firstTs)) >= maxWaitMs;

if (!shouldFlush) {
  templateDataStorage.setItemCopy(queueKey, queue);
  data.gtmOnSuccess();
  return;
}

templateDataStorage.removeItem(queueKey);
templateDataStorage.removeItem(tsKey);

const request = buildRequest(vendor, queue);
if (!request) {
  log('CAPI Batcher: Missing configuration for vendor ' + vendor);
  data.gtmOnFailure();
  return;
}

sendHttpRequest(request.url, {
  headers: request.headers,
  method: 'POST',
  timeout: 10000
}, JSON.stringify(request.body)).then(function(response) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    data.gtmOnSuccess();
  } else {
    log('CAPI Batcher: HTTP ' + response.statusCode + ' from ' + vendor + ' — ' + response.body);
    data.gtmOnFailure();
  }
}, function(reason) {
  log('CAPI Batcher: Request failed — ' + reason);
  data.gtmOnFailure();
});

function vendorId() {
  if (vendor === 'openai') return makeString(data.openaiPixelId || '');
  if (vendor === 'meta') return makeString(data.metaPixelId || '');
  if (vendor === 'tiktok') return makeString(data.tiktokPixelCode || '');
  return makeString(data.customEndpoint || '');
}

function buildRequest(vendor, events) {
  if (vendor === 'openai') {
    if (!data.openaiPixelId || !data.openaiApiKey) return null;
    return {
      url: 'https://bzr.openai.com/v1/events?pid=' + encodeUriComponent(makeString(data.openaiPixelId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + makeString(data.openaiApiKey)
      },
      body: { events: events }
    };
  }

  if (vendor === 'meta') {
    if (!data.metaPixelId || !data.metaAccessToken) return null;
    const version = makeString(data.metaApiVersion || 'v21.0');
    const body = { data: events };
    if (data.metaTestEventCode) {
      body.test_event_code = makeString(data.metaTestEventCode);
    }
    return {
      url: 'https://graph.facebook.com/' + version + '/' + encodeUriComponent(makeString(data.metaPixelId)) +
        '/events?access_token=' + encodeUriComponent(makeString(data.metaAccessToken)),
      headers: { 'Content-Type': 'application/json' },
      body: body
    };
  }

  if (vendor === 'tiktok') {
    if (!data.tiktokPixelCode || !data.tiktokAccessToken) return null;
    return {
      url: 'https://business-api.tiktok.com/open_api/v1.3/event/track/',
      headers: {
        'Content-Type': 'application/json',
        'Access-Token': makeString(data.tiktokAccessToken)
      },
      body: {
        event_source: 'web',
        event_source_id: makeString(data.tiktokPixelCode),
        data: events
      }
    };
  }

  if (vendor === 'custom') {
    if (!data.customEndpoint) return null;
    const headers = { 'Content-Type': 'application/json' };
    if (data.customAuthHeaderName && data.customAuthHeaderValue) {
      headers[makeString(data.customAuthHeaderName)] = makeString(data.customAuthHeaderValue);
    }
    return {
      url: makeString(data.customEndpoint),
      headers: headers,
      body: { events: events }
    };
  }

  return null;
}

function clampInt(value, min, max, fallback) {
  const n = makeInteger(value);
  if (!n || n !== n) return fallback;
  if (n < min) return min;
  if (n > max) return max;
  return n;
}


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_template_storage",
        "versionId": "1"
      },
      "param": []
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Queues event below batch size without sending
  code: |-
    const storage = {};
    mockObject('templateDataStorage', {
      getItemCopy: function(k) { return storage[k]; },
      setItemCopy: function(k, v) { storage[k] = v; },
      removeItem: function(k) { storage[k] = undefined; }
    });

    let httpCalled = false;
    mock('sendHttpRequest', function() {
      httpCalled = true;
      return { then: function(ok) { ok({ statusCode: 200, body: '{}' }); } };
    });

    mock('getTimestampMillis', function() { return 1718100000000; });

    runCode({
      vendor: 'openai',
      eventPayload: { id: 'e1', type: 'order_created' },
      openaiPixelId: 'px-1',
      openaiApiKey: 'key-1',
      batchSize: '3',
      maxWaitSeconds: '60'
    });

    assertThat(httpCalled).isFalse();
    assertApi('gtmOnSuccess').wasCalled();
- name: Flushes when batch size reached
  code: |-
    const JSON = require('JSON');

    const storage = {};
    mockObject('templateDataStorage', {
      getItemCopy: function(k) { return storage[k]; },
      setItemCopy: function(k, v) { storage[k] = v; },
      removeItem: function(k) { storage[k] = undefined; }
    });

    let sentUrl, sentBody;
    mock('sendHttpRequest', function(url, options, body) {
      sentUrl = url;
      sentBody = JSON.parse(body);
      return { then: function(ok) { ok({ statusCode: 200, body: '{}' }); } };
    });

    mock('getTimestampMillis', function() { return 1718100000000; });

    const config = {
      vendor: 'openai',
      eventPayload: { id: 'e1', type: 'order_created' },
      openaiPixelId: 'px-1',
      openaiApiKey: 'key-1',
      batchSize: '2',
      maxWaitSeconds: '60'
    };

    runCode(config);
    runCode(config);

    assertThat(sentUrl).contains('pid=px-1');
    assertThat(sentBody.events.length).isEqualTo(2);
- name: Flushes when max wait exceeded
  code: |-
    const JSON = require('JSON');

    const storage = {};
    mockObject('templateDataStorage', {
      getItemCopy: function(k) { return storage[k]; },
      setItemCopy: function(k, v) { storage[k] = v; },
      removeItem: function(k) { storage[k] = undefined; }
    });

    let sentBody;
    mock('sendHttpRequest', function(url, options, body) {
      sentBody = JSON.parse(body);
      return { then: function(ok) { ok({ statusCode: 200, body: '{}' }); } };
    });

    let now = 1718100000000;
    mock('getTimestampMillis', function() { return now; });

    const config = {
      vendor: 'openai',
      eventPayload: { id: 'e1', type: 'order_created' },
      openaiPixelId: 'px-1',
      openaiApiKey: 'key-1',
      batchSize: '100',
      maxWaitSeconds: '10'
    };

    runCode(config);
    now = now + 11000;
    runCode(config);

    assertThat(sentBody.events.length).isEqualTo(2);
- name: Meta batch uses data array and test event code
  code: |-
    const JSON = require('JSON');

    const storage = {};
    mockObject('templateDataStorage', {
      getItemCopy: function(k) { return storage[k]; },
      setItemCopy: function(k, v) { storage[k] = v; },
      removeItem: function(k) { storage[k] = undefined; }
    });

    let sentUrl, sentBody;
    mock('sendHttpRequest', function(url, options, body) {
      sentUrl = url;
      sentBody = JSON.parse(body);
      return { then: function(ok) { ok({ statusCode: 200, body: '{}' }); } };
    });

    mock('getTimestampMillis', function() { return 1718100000000; });

    runCode({
      vendor: 'meta',
      eventPayload: { event_name: 'Purchase', event_time: 1718100000 },
      metaPixelId: '123456',
      metaAccessToken: 'token-1',
      metaApiVersion: 'v21.0',
      metaTestEventCode: 'TEST123',
      batchSize: '1',
      maxWaitSeconds: '60'
    });

    assertThat(sentUrl).contains('graph.facebook.com/v21.0/123456/events');
    assertThat(sentBody.data.length).isEqualTo(1);
    assertThat(sentBody.test_event_code).isEqualTo('TEST123');
- name: TikTok batch uses event_source_id and Access-Token header
  code: |-
    const JSON = require('JSON');

    const storage = {};
    mockObject('templateDataStorage', {
      getItemCopy: function(k) { return storage[k]; },
      setItemCopy: function(k, v) { storage[k] = v; },
      removeItem: function(k) { storage[k] = undefined; }
    });

    let sentUrl, sentOptions, sentBody;
    mock('sendHttpRequest', function(url, options, body) {
      sentUrl = url;
      sentOptions = options;
      sentBody = JSON.parse(body);
      return { then: function(ok) { ok({ statusCode: 200, body: '{}' }); } };
    });

    mock('getTimestampMillis', function() { return 1718100000000; });

    runCode({
      vendor: 'tiktok',
      eventPayload: { event: 'CompletePayment', event_time: 1718100000 },
      tiktokPixelCode: 'PIXEL-CODE',
      tiktokAccessToken: 'tt-token',
      batchSize: '1',
      maxWaitSeconds: '60'
    });

    assertThat(sentUrl).contains('business-api.tiktok.com');
    assertThat(sentOptions.headers['Access-Token']).isEqualTo('tt-token');
    assertThat(sentBody.event_source_id).isEqualTo('PIXEL-CODE');
    assertThat(sentBody.data.length).isEqualTo(1);
- name: Fails on non-object payload
  code: |-
    runCode({
      vendor: 'openai',
      eventPayload: 'not-an-object',
      openaiPixelId: 'px-1',
      openaiApiKey: 'key-1',
      batchSize: '1',
      maxWaitSeconds: '60'
    });

    assertApi('gtmOnFailure').wasCalled();
- name: Fails on HTTP error during flush
  code: |-
    const storage = {};
    mockObject('templateDataStorage', {
      getItemCopy: function(k) { return storage[k]; },
      setItemCopy: function(k, v) { storage[k] = v; },
      removeItem: function(k) { storage[k] = undefined; }
    });

    mock('sendHttpRequest', function() {
      return { then: function(ok) { ok({ statusCode: 401, body: 'Unauthorized' }); } };
    });

    mock('getTimestampMillis', function() { return 1718100000000; });

    runCode({
      vendor: 'openai',
      eventPayload: { id: 'e1', type: 'order_created' },
      openaiPixelId: 'px-1',
      openaiApiKey: 'bad-key',
      batchSize: '1',
      maxWaitSeconds: '60'
    });

    assertApi('gtmOnFailure').wasCalled();


___NOTES___

CAPI Event Batcher — batches server-side conversion events for
OpenAI, Meta, TikTok, or a custom endpoint.