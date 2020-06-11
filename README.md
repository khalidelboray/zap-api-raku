[OWASP ZAP API](https://www.zaproxy.org/docs/api/) Raku module
==============================================================

SYNOPSIS
========

## `Zap`

```perl6
use lib 'lib';
use Zap;
# Config Zap Client
ZapConfig(:apikey<apikey12345>,:port<8081>,:addr<127.0.0.1>);
# send a url to the spider
my $scanId = Zap::Spider.scan(:url<https://perl.org>);
# get the spider status
my $status = Zap::Spider.status(:$scanId);
# wait for the spider to finish then get the result
$*OUT = $*OUT.open(:!buffer);
while Zap::Spider.status(:$scanId) < 100 {
    print "Spider progress {Zap::Spider.status(:$scanId)}  \r";
}
$*OUT = $*OUT.open(:buffer);
put "URL : $_" for Zap::Spider.results(:$scanId);
my @scans = Zap::Spider.scans; # this needs some work
put "ID , Progress , State";
for @scans -> %scan {
    put %scan<id progress state>.fmt("%s",', ')
}

```
Installation
============

`zef install Zap`

TODO
====

* Make the code and API Response more easy to handle
* Write a Script to provide a CLI `raku-zap` maybe ?
* Write an Interface for the zap CLI 
* Automate Spider and Scanners 

Bad Generated Docs (needs more work)
================== 

class Zap::Ruleconfig
---------------------

class `Zap::Ruleconfig` Methods

### method resetAllRuleConfigValues

```perl6
method resetAllRuleConfigValues() returns Mu
```

Reset all of the rule configurations

### method resetRuleConfigValue

```perl6
method resetRuleConfigValue(
    :$key!
) returns Mu
```

Reset the specified rule configuration, which must already exist

### method setRuleConfigValue

```perl6
method setRuleConfigValue(
    :$key!,
    :$value
) returns Mu
```

Set the specified rule configuration, which must already exist

class Zap::Break
----------------

class `Zap::Break` Methods

### method isBreakRequest

```perl6
method isBreakRequest() returns Mu
```

Returns True if ZAP will break on requests

### method isBreakResponse

```perl6
method isBreakResponse() returns Mu
```

Returns True if ZAP will break on responses

### method waitForHttpBreak

```perl6
method waitForHttpBreak(
    :$poll,
    :$keepalive
) returns Mu
```

Waits until an HTTP breakpoint has been hit, at which point it returns the message. Poll is the number of milliseconds ZAP will pause between checking for breakpoints being hit (default 500). If keepalive is zero or less then the response will be returned as a Server Sent Event, otherwise it is used as the frequency in seconds at which 'keepalive' events should be returned and the response is sent as a standard response.

### method addHttpBreakpoint

```perl6
method addHttpBreakpoint(
    :$string!,
    :$location!,
    :$match!,
    :$inverse!,
    :$ignorecase!
) returns Mu
```

Adds a custom HTTP breakpoint. The string is the string to match. Location may be one of: url, request_header, request_body, response_header or response_body. Match may be: contains or regex. Inverse (match) may be true or false. Lastly, ignorecase (when matching the string) may be true or false.

### method break

```perl6
method break(
    :$type!,
    :$state!,
    :$scope
) returns Mu
```

Controls the global break functionality. The type may be one of: http-all, http-request or http-response. The state may be true (for turning break on for the specified type) or false (for turning break off). Scope is not currently used.

### method continue

```perl6
method continue() returns Mu
```

Submits the currently intercepted message and unsets the global request/response breakpoints

### method drop

```perl6
method drop() returns Mu
```

Drops the currently intercepted message

### method removeHttpBreakpoint

```perl6
method removeHttpBreakpoint(
    :$string!,
    :$location!,
    :$match!,
    :$inverse!,
    :$ignorecase!
) returns Mu
```

Removes the specified breakpoint

### method setHttpMessage

```perl6
method setHttpMessage(
    :$httpHeader!,
    :$httpBody
) returns Mu
```

Overwrites the currently intercepted message with the data provided

### method step

```perl6
method step() returns Mu
```

Submits the currently intercepted message, the next request or response will automatically be intercepted

class Zap::Hud
--------------

class `Zap::Hud` Methods

### method hudAlertData

```perl6
method hudAlertData(
    :$url!
) returns Mu
```

Returns the alert summary needed by the HUD for the specified URL

### method optionAllowUnsafeEval

```perl6
method optionAllowUnsafeEval() returns Mu
```

Returns true if the 'Allow unsafe-eval' option is set

### method optionBaseDirectory

```perl6
method optionBaseDirectory() returns Mu
```

Returns the base directory from which the HUD files are loaded

### method optionDevelopmentMode

```perl6
method optionDevelopmentMode() returns Mu
```

Returns true if the 'Development mode' option is set

### method optionEnableOnDomainMsgs

```perl6
method optionEnableOnDomainMsgs() returns Mu
```

No Doc

### method optionEnabledForDaemon

```perl6
method optionEnabledForDaemon() returns Mu
```

No Doc

### method optionEnabledForDesktop

```perl6
method optionEnabledForDesktop() returns Mu
```

No Doc

### method optionInScopeOnly

```perl6
method optionInScopeOnly() returns Mu
```

Returns true if the 'In scope only' option is set

### method optionRemoveCSP

```perl6
method optionRemoveCSP() returns Mu
```

Returns true if the 'Remove CSP' option is set

### method optionShowWelcomeScreen

```perl6
method optionShowWelcomeScreen() returns Mu
```

No Doc

### method optionSkipTutorialTasks

```perl6
method optionSkipTutorialTasks() returns Mu
```

No Doc

### method optionTutorialHost

```perl6
method optionTutorialHost() returns Mu
```

No Doc

### method optionTutorialPort

```perl6
method optionTutorialPort() returns Mu
```

No Doc

### method optionTutorialTasksDone

```perl6
method optionTutorialTasksDone() returns Mu
```

No Doc

### method optionTutorialTestMode

```perl6
method optionTutorialTestMode() returns Mu
```

No Doc

### method optionTutorialUpdates

```perl6
method optionTutorialUpdates() returns Mu
```

No Doc

### method tutorialUpdates

```perl6
method tutorialUpdates() returns Mu
```

No Doc

### method upgradedDomains

```perl6
method upgradedDomains() returns Mu
```

No Doc

### method changesInHtml

```perl6
method changesInHtml() returns Mu
```

Returns the changelog in HTML format

### method log

```perl6
method log(
    :$record!
) returns Mu
```

Used by the HUD to log messages from the browser

### method recordRequest

```perl6
method recordRequest(
    :$header!,
    :$body!
) returns Mu
```

Used by the HUD to cache a request the user wants to send in the browser

### method resetTutorialTasks

```perl6
method resetTutorialTasks() returns Mu
```

Reset the tutorial tasks so that they must be completed again

### method setOptionBaseDirectory

```perl6
method setOptionBaseDirectory(
    :$String!
) returns Mu
```

Set the base directory from which the HUD files are loaded

### method setOptionDevelopmentMode

```perl6
method setOptionDevelopmentMode(
    :$Boolean!
) returns Mu
```

Sets the boolean option 'Development mode'

### method setOptionEnableOnDomainMsgs

```perl6
method setOptionEnableOnDomainMsgs(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionEnabledForDaemon

```perl6
method setOptionEnabledForDaemon(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionEnabledForDesktop

```perl6
method setOptionEnabledForDesktop(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionInScopeOnly

```perl6
method setOptionInScopeOnly(
    :$Boolean!
) returns Mu
```

Sets the boolean option 'In scope only'

### method setOptionRemoveCSP

```perl6
method setOptionRemoveCSP(
    :$Boolean!
) returns Mu
```

Sets the boolean option 'Remove CSP'

### method setOptionShowWelcomeScreen

```perl6
method setOptionShowWelcomeScreen(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionSkipTutorialTasks

```perl6
method setOptionSkipTutorialTasks(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionTutorialTaskDone

```perl6
method setOptionTutorialTaskDone(
    :$String!
) returns Mu
```

No Doc

### method setOptionTutorialTestMode

```perl6
method setOptionTutorialTestMode(
    :$Boolean!
) returns Mu
```

No Doc

### method setUiOption

```perl6
method setUiOption(
    :$key!,
    :$value
) returns Mu
```

Sets a UI option with the given key and value. The key must be 50 or fewer alphanumeric characters

class Zap::Forceduser
---------------------

class `Zap::Forceduser` Methods

### method setForcedUser

```perl6
method setForcedUser(
    :$contextId!,
    :$userId!
) returns Mu
```

Sets the user (ID) that should be used in 'forced user' mode for the given context (ID)

### method setForcedUserModeEnabled

```perl6
method setForcedUserModeEnabled(
    :$boolean!
) returns Mu
```

Sets if 'forced user' mode should be enabled or not

class Zap::Stats
----------------

class `Zap::Stats` Methods

### method clearStats

```perl6
method clearStats(
    :$keyPrefix
) returns Mu
```

Clears all of the statistics

### method setOptionInMemoryEnabled

```perl6
method setOptionInMemoryEnabled(
    :$Boolean!
) returns Mu
```

Sets whether in memory statistics are enabled

### method setOptionStatsdHost

```perl6
method setOptionStatsdHost(
    :$String!
) returns Mu
```

Sets the Statsd service hostname, supply an empty string to stop using a Statsd service

### method setOptionStatsdPort

```perl6
method setOptionStatsdPort(
    :$Integer!
) returns Mu
```

Sets the Statsd service port

### method setOptionStatsdPrefix

```perl6
method setOptionStatsdPrefix(
    :$String!
) returns Mu
```

Sets the prefix to be applied to all stats sent to the configured Statsd service

### method optionStatsdEnabled

```perl6
method optionStatsdEnabled() returns Mu
```

Returns 'true' if a Statsd server has been correctly configured, otherwise returns 'false'

### method optionStatsdHost

```perl6
method optionStatsdHost() returns Mu
```

Gets the Statsd service hostname

### method optionStatsdPort

```perl6
method optionStatsdPort() returns Mu
```

Gets the Statsd service port

### method optionStatsdPrefix

```perl6
method optionStatsdPrefix() returns Mu
```

Gets the prefix to be applied to all stats sent to the configured Statsd service

### method siteStats

```perl6
method siteStats(
    :$site!,
    :$keyPrefix
) returns Mu
```

Gets all of the global statistics, optionally filtered by a key prefix

### method stats

```perl6
method stats(
    :$keyPrefix
) returns Mu
```

Statistics

class Zap::Alertfilter
----------------------

class `Zap::Alertfilter` Methods

### method addAlertFilter

```perl6
method addAlertFilter(
    :$contextId!,
    :$ruleId!,
    :$newLevel!,
    :$url,
    :$urlIsRegex,
    :$parameter,
    :$enabled,
    :$parameterIsRegex,
    :$attack,
    :$attackIsRegex,
    :$evidence,
    :$evidenceIsRegex
) returns Mu
```

Adds a new alert filter for the context with the given ID.

### method addGlobalAlertFilter

```perl6
method addGlobalAlertFilter(
    :$ruleId!,
    :$newLevel!,
    :$url,
    :$urlIsRegex,
    :$parameter,
    :$enabled,
    :$parameterIsRegex,
    :$attack,
    :$attackIsRegex,
    :$evidence,
    :$evidenceIsRegex
) returns Mu
```

Adds a new global alert filter.

### method removeAlertFilter

```perl6
method removeAlertFilter(
    :$contextId!,
    :$ruleId!,
    :$newLevel!,
    :$url,
    :$urlIsRegex,
    :$parameter,
    :$enabled,
    :$parameterIsRegex,
    :$attack,
    :$attackIsRegex,
    :$evidence,
    :$evidenceIsRegex
) returns Mu
```

Removes an alert filter from the context with the given ID.

### method removeGlobalAlertFilter

```perl6
method removeGlobalAlertFilter(
    :$ruleId!,
    :$newLevel!,
    :$url,
    :$urlIsRegex,
    :$parameter,
    :$enabled,
    :$parameterIsRegex,
    :$attack,
    :$attackIsRegex,
    :$evidence,
    :$evidenceIsRegex
) returns Mu
```

Removes a global alert filter.

class Zap::Ascan
----------------

class `Zap::Ascan` Methods

### method addExcludedParam

```perl6
method addExcludedParam(
    :$name!,
    :$type,
    :$url
) returns Mu
```

Adds a new parameter excluded from the scan, using the specified name. Optionally sets if the new entry applies to a specific URL (default, all URLs) and sets the ID of the type of the parameter (default, ID of any type). The type IDs can be obtained with the view excludedParamTypes.

### method addScanPolicy

```perl6
method addScanPolicy(
    :$scanPolicyName!,
    :$alertThreshold,
    :$attackStrength
) returns Mu
```

No Doc

### method clearExcludedFromScan

```perl6
method clearExcludedFromScan() returns Mu
```

Clears the regexes of URLs excluded from the active scans.

### method disableAllScanners

```perl6
method disableAllScanners(
    :$scanPolicyName
) returns Mu
```

Disables all scanners of the scan policy with the given name, or the default if none given.

### method disableScanners

```perl6
method disableScanners(
    :$ids!,
    :$scanPolicyName
) returns Mu
```

Disables the scanners with the given IDs (comma separated list of IDs) of the scan policy with the given name, or the default if none given.

### method enableAllScanners

```perl6
method enableAllScanners(
    :$scanPolicyName
) returns Mu
```

Enables all scanners of the scan policy with the given name, or the default if none given.

### method enableScanners

```perl6
method enableScanners(
    :$ids!,
    :$scanPolicyName
) returns Mu
```

Enables the scanners with the given IDs (comma separated list of IDs) of the scan policy with the given name, or the default if none given.

### method excludeFromScan

```perl6
method excludeFromScan(
    :$regex!
) returns Mu
```

Adds a regex of URLs that should be excluded from the active scans.

### method importScanPolicy

```perl6
method importScanPolicy(
    :$path!
) returns Mu
```

Imports a Scan Policy using the given file system path.

### method modifyExcludedParam

```perl6
method modifyExcludedParam(
    :$idx!,
    :$name,
    :$type,
    :$url
) returns Mu
```

Modifies a parameter excluded from the scan. Allows to modify the name, the URL and the type of parameter. The parameter is selected with its index, which can be obtained with the view excludedParams.

### method pause

```perl6
method pause(
    :$scanId!
) returns Mu
```

No Doc

### method pauseAllScans

```perl6
method pauseAllScans() returns Mu
```

No Doc

### method removeAllScans

```perl6
method removeAllScans() returns Mu
```

No Doc

### method removeExcludedParam

```perl6
method removeExcludedParam(
    :$idx!
) returns Mu
```

Removes a parameter excluded from the scan, with the given index. The index can be obtained with the view excludedParams.

### method removeScan

```perl6
method removeScan(
    :$scanId!
) returns Mu
```

No Doc

### method removeScanPolicy

```perl6
method removeScanPolicy(
    :$scanPolicyName!
) returns Mu
```

No Doc

### method resume

```perl6
method resume(
    :$scanId!
) returns Mu
```

No Doc

### method resumeAllScans

```perl6
method resumeAllScans() returns Mu
```

No Doc

### method scan

```perl6
method scan(
    :$url,
    :$recurse,
    :$inScopeOnly,
    :$scanPolicyName,
    :$method,
    :$postData,
    :$contextId
) returns Mu
```

Runs the active scanner against the given URL and/or Context. Optionally, the 'recurse' parameter can be used to scan URLs under the given URL, the parameter 'inScopeOnly' can be used to constrain the scan to URLs that are in scope (ignored if a Context is specified), the parameter 'scanPolicyName' allows to specify the scan policy (if none is given it uses the default scan policy), the parameters 'method' and 'postData' allow to select a given request in conjunction with the given URL.

### method scanAsUser

```perl6
method scanAsUser(
    :$url,
    :$contextId,
    :$userId,
    :$recurse,
    :$scanPolicyName,
    :$method,
    :$postData
) returns Mu
```

Active Scans from the perspective of a User, obtained using the given Context ID and User ID. See 'scan' action for more details.

### method setEnabledPolicies

```perl6
method setEnabledPolicies(
    :$ids!,
    :$scanPolicyName
) returns Mu
```

No Doc

### method setOptionAddQueryParam

```perl6
method setOptionAddQueryParam(
    :$Boolean!
) returns Mu
```

Sets whether or not the active scanner should add a query param to GET requests which do not have parameters to start with.

### method setOptionAllowAttackOnStart

```perl6
method setOptionAllowAttackOnStart(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionAttackPolicy

```perl6
method setOptionAttackPolicy(
    :$String!
) returns Mu
```

No Doc

### method setOptionDefaultPolicy

```perl6
method setOptionDefaultPolicy(
    :$String!
) returns Mu
```

No Doc

### method setOptionDelayInMs

```perl6
method setOptionDelayInMs(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionHandleAntiCSRFTokens

```perl6
method setOptionHandleAntiCSRFTokens(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionHostPerScan

```perl6
method setOptionHostPerScan(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionInjectPluginIdInHeader

```perl6
method setOptionInjectPluginIdInHeader(
    :$Boolean!
) returns Mu
```

Sets whether or not the active scanner should inject the HTTP request header X-ZAP-Scan-ID, with the ID of the scanner that's sending the requests.

### method setOptionMaxChartTimeInMins

```perl6
method setOptionMaxChartTimeInMins(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionMaxResultsToList

```perl6
method setOptionMaxResultsToList(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionMaxRuleDurationInMins

```perl6
method setOptionMaxRuleDurationInMins(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionMaxScanDurationInMins

```perl6
method setOptionMaxScanDurationInMins(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionMaxScansInUI

```perl6
method setOptionMaxScansInUI(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionPromptInAttackMode

```perl6
method setOptionPromptInAttackMode(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionPromptToClearFinishedScans

```perl6
method setOptionPromptToClearFinishedScans(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionRescanInAttackMode

```perl6
method setOptionRescanInAttackMode(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionScanHeadersAllRequests

```perl6
method setOptionScanHeadersAllRequests(
    :$Boolean!
) returns Mu
```

Sets whether or not the HTTP Headers of all requests should be scanned. Not just requests that send parameters, through the query or request body.

### method setOptionShowAdvancedDialog

```perl6
method setOptionShowAdvancedDialog(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionTargetParamsEnabledRPC

```perl6
method setOptionTargetParamsEnabledRPC(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionTargetParamsInjectable

```perl6
method setOptionTargetParamsInjectable(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionThreadPerHost

```perl6
method setOptionThreadPerHost(
    :$Integer!
) returns Mu
```

No Doc

### method setPolicyAlertThreshold

```perl6
method setPolicyAlertThreshold(
    :$id!,
    :$alertThreshold!,
    :$scanPolicyName
) returns Mu
```

No Doc

### method setPolicyAttackStrength

```perl6
method setPolicyAttackStrength(
    :$id!,
    :$attackStrength!,
    :$scanPolicyName
) returns Mu
```

No Doc

### method setScannerAlertThreshold

```perl6
method setScannerAlertThreshold(
    :$id!,
    :$alertThreshold!,
    :$scanPolicyName
) returns Mu
```

No Doc

### method setScannerAttackStrength

```perl6
method setScannerAttackStrength(
    :$id!,
    :$attackStrength!,
    :$scanPolicyName
) returns Mu
```

No Doc

### method skipScanner

```perl6
method skipScanner(
    :$scanId!,
    :$scannerId!
) returns Mu
```

Skips the scanner using the given IDs of the scan and the scanner.

### method stop

```perl6
method stop(
    :$scanId!
) returns Mu
```

No Doc

### method stopAllScans

```perl6
method stopAllScans() returns Mu
```

No Doc

### method updateScanPolicy

```perl6
method updateScanPolicy(
    :$scanPolicyName!,
    :$alertThreshold,
    :$attackStrength
) returns Mu
```

No Doc

### method excludedFromScan

```perl6
method excludedFromScan() returns Mu
```

Gets the regexes of URLs excluded from the active scans.

### method excludedParamTypes

```perl6
method excludedParamTypes() returns Mu
```

Gets all the types of excluded parameters. For each type the following are shown: the ID and the name.

### method excludedParams

```perl6
method excludedParams() returns Mu
```

Gets all the parameters that are excluded. For each parameter the following are shown: the name, the URL, and the parameter type.

### method messagesIds

```perl6
method messagesIds(
    :$scanId!
) returns Mu
```

Gets the IDs of the messages sent during the scan with the given ID. A message can be obtained with 'message' core view.

### method optionAddQueryParam

```perl6
method optionAddQueryParam() returns Mu
```

Tells whether or not the active scanner should add a query parameter to GET request that don't have parameters to start with.

### method optionAllowAttackOnStart

```perl6
method optionAllowAttackOnStart() returns Mu
```

No Doc

### method optionAttackPolicy

```perl6
method optionAttackPolicy() returns Mu
```

No Doc

### method optionDefaultPolicy

```perl6
method optionDefaultPolicy() returns Mu
```

No Doc

### method optionDelayInMs

```perl6
method optionDelayInMs() returns Mu
```

No Doc

### method optionExcludedParamList

```perl6
method optionExcludedParamList() returns Mu
```

Use view excludedParams instead.

### method optionHandleAntiCSRFTokens

```perl6
method optionHandleAntiCSRFTokens() returns Mu
```

No Doc

### method optionHostPerScan

```perl6
method optionHostPerScan() returns Mu
```

No Doc

### method optionInjectPluginIdInHeader

```perl6
method optionInjectPluginIdInHeader() returns Mu
```

Tells whether or not the active scanner should inject the HTTP request header X-ZAP-Scan-ID, with the ID of the scanner that's sending the requests.

### method optionMaxChartTimeInMins

```perl6
method optionMaxChartTimeInMins() returns Mu
```

No Doc

### method optionMaxResultsToList

```perl6
method optionMaxResultsToList() returns Mu
```

No Doc

### method optionMaxRuleDurationInMins

```perl6
method optionMaxRuleDurationInMins() returns Mu
```

No Doc

### method optionMaxScanDurationInMins

```perl6
method optionMaxScanDurationInMins() returns Mu
```

No Doc

### method optionMaxScansInUI

```perl6
method optionMaxScansInUI() returns Mu
```

No Doc

### method optionPromptInAttackMode

```perl6
method optionPromptInAttackMode() returns Mu
```

No Doc

### method optionPromptToClearFinishedScans

```perl6
method optionPromptToClearFinishedScans() returns Mu
```

No Doc

### method optionRescanInAttackMode

```perl6
method optionRescanInAttackMode() returns Mu
```

No Doc

### method optionScanHeadersAllRequests

```perl6
method optionScanHeadersAllRequests() returns Mu
```

Tells whether or not the HTTP Headers of all requests should be scanned. Not just requests that send parameters, through the query or request body.

### method optionShowAdvancedDialog

```perl6
method optionShowAdvancedDialog() returns Mu
```

No Doc

### method optionTargetParamsEnabledRPC

```perl6
method optionTargetParamsEnabledRPC() returns Mu
```

No Doc

### method optionTargetParamsInjectable

```perl6
method optionTargetParamsInjectable() returns Mu
```

No Doc

### method optionThreadPerHost

```perl6
method optionThreadPerHost() returns Mu
```

No Doc

### method policies

```perl6
method policies(
    :$scanPolicyName,
    :$policyId
) returns Mu
```

No Doc

### method scanPolicyNames

```perl6
method scanPolicyNames() returns Mu
```

No Doc

### method scanProgress

```perl6
method scanProgress(
    :$scanId
) returns Mu
```

No Doc

### method scanners

```perl6
method scanners(
    :$scanPolicyName,
    :$policyId
) returns Mu
```

Gets the scanners, optionally, of the given scan policy and/or scanner policy/category ID.

### method scans

```perl6
method scans() returns Mu
```

No Doc

### method status

```perl6
method status(
    :$scanId
) returns Mu
```

No Doc

class Zap::Spider
-----------------

class `Zap::Spider` Methods

### method domainsAlwaysInScope

```perl6
method domainsAlwaysInScope() returns Mu
```

Gets all the domains that are always in scope. For each domain the following are shown: the index, the value (domain), if enabled, and if specified as a regex.

### method excludedFromScan

```perl6
method excludedFromScan() returns Mu
```

Gets the regexes of URLs excluded from the spider scans.

### method fullResults

```perl6
method fullResults(
    :$scanId!
) returns Mu
```

No Doc

### method optionAcceptCookies

```perl6
method optionAcceptCookies() returns Mu
```

Gets whether or not a spider process should accept cookies while spidering.

### method optionDomainsAlwaysInScope

```perl6
method optionDomainsAlwaysInScope() returns Mu
```

Use view domainsAlwaysInScope instead.

### method optionDomainsAlwaysInScopeEnabled

```perl6
method optionDomainsAlwaysInScopeEnabled() returns Mu
```

Use view domainsAlwaysInScope instead.

### method optionHandleODataParametersVisited

```perl6
method optionHandleODataParametersVisited() returns Mu
```

No Doc

### method optionHandleParameters

```perl6
method optionHandleParameters() returns Mu
```

No Doc

### method optionMaxChildren

```perl6
method optionMaxChildren() returns Mu
```

Gets the maximum number of child nodes (per node) that can be crawled, 0 means no limit.

### method optionMaxDepth

```perl6
method optionMaxDepth() returns Mu
```

Gets the maximum depth the spider can crawl, 0 if unlimited.

### method optionMaxDuration

```perl6
method optionMaxDuration() returns Mu
```

No Doc

### method optionMaxParseSizeBytes

```perl6
method optionMaxParseSizeBytes() returns Mu
```

Gets the maximum size, in bytes, that a response might have to be parsed.

### method optionMaxScansInUI

```perl6
method optionMaxScansInUI() returns Mu
```

No Doc

### method optionParseComments

```perl6
method optionParseComments() returns Mu
```

No Doc

### method optionParseGit

```perl6
method optionParseGit() returns Mu
```

No Doc

### method optionParseRobotsTxt

```perl6
method optionParseRobotsTxt() returns Mu
```

No Doc

### method optionParseSVNEntries

```perl6
method optionParseSVNEntries() returns Mu
```

No Doc

### method optionParseSitemapXml

```perl6
method optionParseSitemapXml() returns Mu
```

No Doc

### method optionPostForm

```perl6
method optionPostForm() returns Mu
```

No Doc

### method optionProcessForm

```perl6
method optionProcessForm() returns Mu
```

No Doc

### method optionRequestWaitTime

```perl6
method optionRequestWaitTime() returns Mu
```

No Doc

### method optionScope

```perl6
method optionScope() returns Mu
```

No Doc

### method optionScopeText

```perl6
method optionScopeText() returns Mu
```

No Doc

### method optionSendRefererHeader

```perl6
method optionSendRefererHeader() returns Mu
```

Gets whether or not the 'Referer' header should be sent while spidering.

### method optionShowAdvancedDialog

```perl6
method optionShowAdvancedDialog() returns Mu
```

No Doc

### method optionSkipURLString

```perl6
method optionSkipURLString() returns Mu
```

No Doc

### method optionThreadCount

```perl6
method optionThreadCount() returns Mu
```

No Doc

### method optionUserAgent

```perl6
method optionUserAgent() returns Mu
```

No Doc

### method results

```perl6
method results(
    :$scanId
) returns Mu
```

No Doc

### method scans

```perl6
method scans() returns Mu
```

No Doc

### method status

```perl6
method status(
    :$scanId
) returns Mu
```

No Doc

### method addDomainAlwaysInScope

```perl6
method addDomainAlwaysInScope(
    :$value!,
    :$isRegex,
    :$isEnabled
) returns Mu
```

Adds a new domain that's always in scope, using the specified value. Optionally sets if the new entry is enabled (default, true) and whether or not the new value is specified as a regex (default, false).

### method clearExcludedFromScan

```perl6
method clearExcludedFromScan() returns Mu
```

Clears the regexes of URLs excluded from the spider scans.

### method disableAllDomainsAlwaysInScope

```perl6
method disableAllDomainsAlwaysInScope() returns Mu
```

Disables all domains that are always in scope.

### method enableAllDomainsAlwaysInScope

```perl6
method enableAllDomainsAlwaysInScope() returns Mu
```

Enables all domains that are always in scope.

### method excludeFromScan

```perl6
method excludeFromScan(
    :$regex!
) returns Mu
```

Adds a regex of URLs that should be excluded from the spider scans.

### method modifyDomainAlwaysInScope

```perl6
method modifyDomainAlwaysInScope(
    :$idx!,
    :$value,
    :$isRegex,
    :$isEnabled
) returns Mu
```

Modifies a domain that's always in scope. Allows to modify the value, if enabled or if a regex. The domain is selected with its index, which can be obtained with the view domainsAlwaysInScope.

### method pause

```perl6
method pause(
    :$scanId!
) returns Mu
```

No Doc

### method pauseAllScans

```perl6
method pauseAllScans() returns Mu
```

No Doc

### method removeAllScans

```perl6
method removeAllScans() returns Mu
```

No Doc

### method removeDomainAlwaysInScope

```perl6
method removeDomainAlwaysInScope(
    :$idx!
) returns Mu
```

Removes a domain that's always in scope, with the given index. The index can be obtained with the view domainsAlwaysInScope.

### method removeScan

```perl6
method removeScan(
    :$scanId!
) returns Mu
```

No Doc

### method resume

```perl6
method resume(
    :$scanId!
) returns Mu
```

No Doc

### method resumeAllScans

```perl6
method resumeAllScans() returns Mu
```

No Doc

### method scan

```perl6
method scan(
    :$url,
    :$maxChildren,
    :$recurse,
    :$contextName,
    :$subtreeOnly
) returns Mu
```

Runs the spider against the given URL (or context). Optionally, the 'maxChildren' parameter can be set to limit the number of children scanned, the 'recurse' parameter can be used to prevent the spider from seeding recursively, the parameter 'contextName' can be used to constrain the scan to a Context and the parameter 'subtreeOnly' allows to restrict the spider under a site's subtree (using the specified 'url').

### method scanAsUser

```perl6
method scanAsUser(
    :$contextId!,
    :$userId!,
    :$url,
    :$maxChildren,
    :$recurse,
    :$subtreeOnly
) returns Mu
```

Runs the spider from the perspective of a User, obtained using the given Context ID and User ID. See 'scan' action for more details.

### method setOptionAcceptCookies

```perl6
method setOptionAcceptCookies(
    :$Boolean!
) returns Mu
```

Sets whether or not a spider process should accept cookies while spidering.

### method setOptionHandleODataParametersVisited

```perl6
method setOptionHandleODataParametersVisited(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionHandleParameters

```perl6
method setOptionHandleParameters(
    :$String!
) returns Mu
```

No Doc

### method setOptionMaxChildren

```perl6
method setOptionMaxChildren(
    :$Integer!
) returns Mu
```

Sets the maximum number of child nodes (per node) that can be crawled, 0 means no limit.

### method setOptionMaxDepth

```perl6
method setOptionMaxDepth(
    :$Integer!
) returns Mu
```

Sets the maximum depth the spider can crawl, 0 for unlimited depth.

### method setOptionMaxDuration

```perl6
method setOptionMaxDuration(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionMaxParseSizeBytes

```perl6
method setOptionMaxParseSizeBytes(
    :$Integer!
) returns Mu
```

Sets the maximum size, in bytes, that a response might have to be parsed. This allows the spider to skip big responses/files.

### method setOptionMaxScansInUI

```perl6
method setOptionMaxScansInUI(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionParseComments

```perl6
method setOptionParseComments(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionParseGit

```perl6
method setOptionParseGit(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionParseRobotsTxt

```perl6
method setOptionParseRobotsTxt(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionParseSVNEntries

```perl6
method setOptionParseSVNEntries(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionParseSitemapXml

```perl6
method setOptionParseSitemapXml(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionPostForm

```perl6
method setOptionPostForm(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionProcessForm

```perl6
method setOptionProcessForm(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionRequestWaitTime

```perl6
method setOptionRequestWaitTime(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionScopeString

```perl6
method setOptionScopeString(
    :$String!
) returns Mu
```

Use actions [add|modify|remove]DomainAlwaysInScope instead.

### method setOptionSendRefererHeader

```perl6
method setOptionSendRefererHeader(
    :$Boolean!
) returns Mu
```

Sets whether or not the 'Referer' header should be sent while spidering.

### method setOptionShowAdvancedDialog

```perl6
method setOptionShowAdvancedDialog(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionSkipURLString

```perl6
method setOptionSkipURLString(
    :$String!
) returns Mu
```

No Doc

### method setOptionThreadCount

```perl6
method setOptionThreadCount(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionUserAgent

```perl6
method setOptionUserAgent(
    :$String!
) returns Mu
```

No Doc

### method stop

```perl6
method stop(
    :$scanId
) returns Mu
```

No Doc

### method stopAllScans

```perl6
method stopAllScans() returns Mu
```

No Doc

class Zap::Selenium
-------------------

class `Zap::Selenium` Methods

### method setOptionChromeDriverPath

```perl6
method setOptionChromeDriverPath(
    :$String!
) returns Mu
```

Sets the current path to ChromeDriver

### method setOptionFirefoxBinaryPath

```perl6
method setOptionFirefoxBinaryPath(
    :$String!
) returns Mu
```

Sets the current path to Firefox binary

### method setOptionFirefoxDriverPath

```perl6
method setOptionFirefoxDriverPath(
    :$String!
) returns Mu
```

Sets the current path to Firefox driver (geckodriver)

### method setOptionIeDriverPath

```perl6
method setOptionIeDriverPath(
    :$String!
) returns Mu
```

No Doc

### method setOptionPhantomJsBinaryPath

```perl6
method setOptionPhantomJsBinaryPath(
    :$String!
) returns Mu
```

Sets the current path to PhantomJS binary

### method optionFirefoxDriverPath

```perl6
method optionFirefoxDriverPath() returns Mu
```

Returns the current path to Firefox driver (geckodriver)

### method optionIeDriverPath

```perl6
method optionIeDriverPath() returns Mu
```

No Doc

### method optionPhantomJsBinaryPath

```perl6
method optionPhantomJsBinaryPath() returns Mu
```

Returns the current path to PhantomJS binary

class Zap::Httpsessions
-----------------------

class `Zap::Httpsessions` Methods

### method addDefaultSessionToken

```perl6
method addDefaultSessionToken(
    :$sessionToken!,
    :$tokenEnabled
) returns Mu
```

Adds a default session token with the given name and enabled state.

### method addSessionToken

```perl6
method addSessionToken(
    :$site!,
    :$sessionToken!
) returns Mu
```

Adds the session token to the given site.

### method createEmptySession

```perl6
method createEmptySession(
    :$site!,
    :$session
) returns Mu
```

Creates an empty session for the given site. Optionally with the given name.

### method removeDefaultSessionToken

```perl6
method removeDefaultSessionToken(
    :$sessionToken!
) returns Mu
```

Removes the default session token with the given name.

### method removeSession

```perl6
method removeSession(
    :$site!,
    :$session!
) returns Mu
```

Removes the session from the given site.

### method removeSessionToken

```perl6
method removeSessionToken(
    :$site!,
    :$sessionToken!
) returns Mu
```

Removes the session token from the given site.

### method renameSession

```perl6
method renameSession(
    :$site!,
    :$oldSessionName!,
    :$newSessionName!
) returns Mu
```

Renames the session of the given site.

### method setActiveSession

```perl6
method setActiveSession(
    :$site!,
    :$session!
) returns Mu
```

Sets the given session as active for the given site.

### method setDefaultSessionTokenEnabled

```perl6
method setDefaultSessionTokenEnabled(
    :$sessionToken!,
    :$tokenEnabled!
) returns Mu
```

Sets whether or not the default session token with the given name is enabled.

### method setSessionTokenValue

```perl6
method setSessionTokenValue(
    :$site!,
    :$session!,
    :$sessionToken!,
    :$tokenValue!
) returns Mu
```

Sets the value of the session token of the given session for the given site.

### method unsetActiveSession

```perl6
method unsetActiveSession(
    :$site!
) returns Mu
```

Unsets the active session of the given site.

### method sessionTokens

```perl6
method sessionTokens(
    :$site!
) returns Mu
```

Gets the names of the session tokens for the given site.

### method sessions

```perl6
method sessions(
    :$site!,
    :$session
) returns Mu
```

Gets the sessions for the given site. Optionally returning just the session with the given name.

### method sites

```perl6
method sites() returns Mu
```

Gets all of the sites that have sessions.

class Zap::Localproxies
-----------------------

class `Zap::Localproxies` Methods

### method removeAdditionalProxy

```perl6
method removeAdditionalProxy(
    :$address!,
    :$port!
) returns Mu
```

Removes the additional proxy with the specified address and port.

class Zap::Websocket
--------------------

class `Zap::Websocket` Methods

### method message

```perl6
method message(
    :$channelId!,
    :$messageId!
) returns Mu
```

Returns full details of the message specified by the channelId and messageId

### method messages

```perl6
method messages(
    :$channelId,
    :$start,
    :$count,
    :$payloadPreviewLength
) returns Mu
```

Returns a list of all of the messages that meet the given criteria (all optional), where channelId is a channel identifier, start is the offset to start returning messages from (starting from 0), count is the number of messages to return (default no limit) and payloadPreviewLength is the maximum number bytes to return for the payload contents

### method sendTextMessage

```perl6
method sendTextMessage(
    :$channelId!,
    :$outgoing!,
    :$message!
) returns Mu
```

Sends the specified message on the channel specified by channelId, if outgoing is 'True' then the message will be sent to the server and if it is 'False' then it will be sent to the client

### method setBreakTextMessage

```perl6
method setBreakTextMessage(
    :$message!,
    :$outgoing!
) returns Mu
```

Sets the text message for an intercepted websockets message

class Zap::Authentication
-------------------------

class `Zap::Authentication` Methods

### method setAuthenticationMethod

```perl6
method setAuthenticationMethod(
    :$contextId!,
    :$authMethodName!,
    :$authMethodConfigParams
) returns Mu
```

Sets the authentication method for the context with the given ID.

### method setLoggedInIndicator

```perl6
method setLoggedInIndicator(
    :$contextId!,
    :$loggedInIndicatorRegex!
) returns Mu
```

Sets the logged in indicator for the context with the given ID.

### method setLoggedOutIndicator

```perl6
method setLoggedOutIndicator(
    :$contextId!,
    :$loggedOutIndicatorRegex!
) returns Mu
```

Sets the logged out indicator for the context with the given ID.

### method getLoggedInIndicator

```perl6
method getLoggedInIndicator(
    :$contextId!
) returns Mu
```

Gets the logged in indicator for the context with the given ID.

### method getLoggedOutIndicator

```perl6
method getLoggedOutIndicator(
    :$contextId!
) returns Mu
```

Gets the logged out indicator for the context with the given ID.

### method getSupportedAuthenticationMethods

```perl6
method getSupportedAuthenticationMethods() returns Mu
```

Gets the name of the authentication methods.

class Zap::Pscan
----------------

class `Zap::Pscan` Methods

### method disableAllScanners

```perl6
method disableAllScanners() returns Mu
```

Disables all passive scanners

### method disableAllTags

```perl6
method disableAllTags() returns Mu
```

Disables all passive scan tags.

### method disableScanners

```perl6
method disableScanners(
    :$ids!
) returns Mu
```

Disables all passive scanners with the given IDs (comma separated list of IDs)

### method enableAllScanners

```perl6
method enableAllScanners() returns Mu
```

Enables all passive scanners

### method enableAllTags

```perl6
method enableAllTags() returns Mu
```

Enables all passive scan tags.

### method enableScanners

```perl6
method enableScanners(
    :$ids!
) returns Mu
```

Enables all passive scanners with the given IDs (comma separated list of IDs)

### method setEnabled

```perl6
method setEnabled(
    :$enabled!
) returns Mu
```

Sets whether or not the passive scanning is enabled (Note: the enabled state is not persisted).

### method setMaxAlertsPerRule

```perl6
method setMaxAlertsPerRule(
    :$maxAlerts!
) returns Mu
```

Sets the maximum number of alerts a passive scan rule should raise.

### method setScanOnlyInScope

```perl6
method setScanOnlyInScope(
    :$onlyInScope!
) returns Mu
```

Sets whether or not the passive scan should be performed only on messages that are in scope.

### method setScannerAlertThreshold

```perl6
method setScannerAlertThreshold(
    :$id!,
    :$alertThreshold!
) returns Mu
```

Sets the alert threshold of the passive scanner with the given ID, accepted values for alert threshold: OFF, DEFAULT, LOW, MEDIUM and HIGH

### method recordsToScan

```perl6
method recordsToScan() returns Mu
```

The number of records the passive scanner still has to scan

### method scanOnlyInScope

```perl6
method scanOnlyInScope() returns Mu
```

Tells whether or not the passive scan should be performed only on messages that are in scope.

### method scanners

```perl6
method scanners() returns Mu
```

Lists all passive scanners with its ID, name, enabled state and alert threshold.

class Zap::Sessionmanagement
----------------------------

class `Zap::Sessionmanagement` Methods

### method getSupportedSessionManagementMethods

```perl6
method getSupportedSessionManagementMethods() returns Mu
```

Gets the name of the session management methods.

### method setSessionManagementMethod

```perl6
method setSessionManagementMethod(
    :$contextId!,
    :$methodName!,
    :$methodConfigParams
) returns Mu
```

Sets the session management method for the context with the given ID.

class Zap::Script
-----------------

class `Zap::Script` Methods

### method globalVar

```perl6
method globalVar(
    :$varKey!
) returns Mu
```

Gets the value of the global variable with the given key. Returns an API error (DOES_NOT_EXIST) if no value was previously set.

### method globalVars

```perl6
method globalVars() returns Mu
```

Gets all the global variables (key/value pairs).

### method listEngines

```perl6
method listEngines() returns Mu
```

Lists the script engines available

### method listScripts

```perl6
method listScripts() returns Mu
```

Lists the scripts available, with its engine, name, description, type and error state.

### method listTypes

```perl6
method listTypes() returns Mu
```

Lists the script types available.

### method scriptCustomVar

```perl6
method scriptCustomVar(
    :$scriptName!,
    :$varKey!
) returns Mu
```

Gets the value (string representation) of a custom variable. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists or if no value was previously set.

### method scriptCustomVars

```perl6
method scriptCustomVars(
    :$scriptName!
) returns Mu
```

Gets all the custom variables (key/value pairs, the value is the string representation) of a script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.

### method scriptVar

```perl6
method scriptVar(
    :$scriptName!,
    :$varKey!
) returns Mu
```

Gets the value of the variable with the given key for the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists or if no value was previously set.

### method scriptVars

```perl6
method scriptVars(
    :$scriptName!
) returns Mu
```

Gets all the variables (key/value pairs) of the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.

### method clearGlobalCustomVar

```perl6
method clearGlobalCustomVar(
    :$varKey!
) returns Mu
```

Clears a global custom variable.

### method clearGlobalVar

```perl6
method clearGlobalVar(
    :$varKey!
) returns Mu
```

Clears the global variable with the given key.

### method clearGlobalVars

```perl6
method clearGlobalVars() returns Mu
```

Clears the global variables.

### method clearScriptCustomVar

```perl6
method clearScriptCustomVar(
    :$scriptName!,
    :$varKey!
) returns Mu
```

Clears a script custom variable.

### method clearScriptVar

```perl6
method clearScriptVar(
    :$scriptName!,
    :$varKey!
) returns Mu
```

Clears the variable with the given key of the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.

### method clearScriptVars

```perl6
method clearScriptVars(
    :$scriptName!
) returns Mu
```

Clears the variables of the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.

### method disable

```perl6
method disable(
    :$scriptName!
) returns Mu
```

Disables the script with the given name

### method enable

```perl6
method enable(
    :$scriptName!
) returns Mu
```

Enables the script with the given name

### method load

```perl6
method load(
    :$scriptName!,
    :$scriptType!,
    :$scriptEngine!,
    :$fileName!,
    :$scriptDescription,
    :$charset
) returns Mu
```

Loads a script into ZAP from the given local file, with the given name, type and engine, optionally with a description, and a charset name to read the script (the charset name is required if the script is not in UTF-8, for example, in ISO-8859-1).

### method remove

```perl6
method remove(
    :$scriptName!
) returns Mu
```

Removes the script with the given name

### method runStandAloneScript

```perl6
method runStandAloneScript(
    :$scriptName!
) returns Mu
```

Runs the stand alone script with the given name

### method setGlobalVar

```perl6
method setGlobalVar(
    :$varKey!,
    :$varValue
) returns Mu
```

Sets the value of the global variable with the given key.

### method setScriptVar

```perl6
method setScriptVar(
    :$scriptName!,
    :$varKey!,
    :$varValue
) returns Mu
```

Sets the value of the variable with the given key of the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.

class Zap::Ajaxspider
---------------------

class `Zap::Ajaxspider` Methods

### method optionBrowserId

```perl6
method optionBrowserId() returns Mu
```

No Doc

### method optionClickDefaultElems

```perl6
method optionClickDefaultElems() returns Mu
```

No Doc

### method optionClickElemsOnce

```perl6
method optionClickElemsOnce() returns Mu
```

No Doc

### method optionEventWait

```perl6
method optionEventWait() returns Mu
```

No Doc

### method optionMaxCrawlDepth

```perl6
method optionMaxCrawlDepth() returns Mu
```

No Doc

### method optionMaxCrawlStates

```perl6
method optionMaxCrawlStates() returns Mu
```

No Doc

### method optionMaxDuration

```perl6
method optionMaxDuration() returns Mu
```

No Doc

### method optionNumberOfBrowsers

```perl6
method optionNumberOfBrowsers() returns Mu
```

No Doc

### method optionRandomInputs

```perl6
method optionRandomInputs() returns Mu
```

No Doc

### method optionReloadWait

```perl6
method optionReloadWait() returns Mu
```

No Doc

### method results

```perl6
method results(
    :$start,
    :$count
) returns Mu
```

No Doc

### method status

```perl6
method status() returns Mu
```

No Doc

### method scan

```perl6
method scan(
    :$url,
    :$inScope,
    :$contextName,
    :$subtreeOnly
) returns Mu
```

Runs the spider against the given URL and/or context, optionally, spidering everything in scope. The parameter 'contextName' can be used to constrain the scan to a Context, the option 'in scope' is ignored if a context was also specified. The parameter 'subtreeOnly' allows to restrict the spider under a site's subtree (using the specified 'url').

### method scanAsUser

```perl6
method scanAsUser(
    :$contextName!,
    :$userName!,
    :$url,
    :$subtreeOnly
) returns Mu
```

Runs the spider from the perspective of a User, obtained using the given context name and user name. The parameter 'url' allows to specify the starting point for the spider, otherwise it's used an existing URL from the context (if any). The parameter 'subtreeOnly' allows to restrict the spider under a site's subtree (using the specified 'url').

### method setOptionBrowserId

```perl6
method setOptionBrowserId(
    :$String!
) returns Mu
```

No Doc

### method setOptionClickDefaultElems

```perl6
method setOptionClickDefaultElems(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionClickElemsOnce

```perl6
method setOptionClickElemsOnce(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionEventWait

```perl6
method setOptionEventWait(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionMaxCrawlDepth

```perl6
method setOptionMaxCrawlDepth(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionMaxCrawlStates

```perl6
method setOptionMaxCrawlStates(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionMaxDuration

```perl6
method setOptionMaxDuration(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionNumberOfBrowsers

```perl6
method setOptionNumberOfBrowsers(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionRandomInputs

```perl6
method setOptionRandomInputs(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionReloadWait

```perl6
method setOptionReloadWait(
    :$Integer!
) returns Mu
```

No Doc

### method stop

```perl6
method stop() returns Mu
```

No Doc

class Zap::Core
---------------

class `Zap::Core` Methods

### method alertsSummary

```perl6
method alertsSummary(
    :$baseurl
) returns Mu
```

Gets number of alerts grouped by each risk level, optionally filtering by URL

### method childNodes

```perl6
method childNodes(
    :$url
) returns Mu
```

Gets the child nodes underneath the specified URL in the Sites tree

### method excludedFromProxy

```perl6
method excludedFromProxy() returns Mu
```

Gets the regular expressions, applied to URLs, to exclude from the local proxies.

### method homeDirectory

```perl6
method homeDirectory() returns Mu
```

No Doc

### method hosts

```perl6
method hosts() returns Mu
```

Gets the name of the hosts accessed through/by ZAP

### method message

```perl6
method message(
    :$id!
) returns Mu
```

Gets the HTTP message with the given ID. Returns the ID, request/response headers and bodies, cookies, note, type, RTT, and timestamp.

### method messages

```perl6
method messages(
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Gets the HTTP messages sent by ZAP, request and response, optionally filtered by URL and paginated with 'start' position and 'count' of messages

### method messagesById

```perl6
method messagesById(
    :$ids!
) returns Mu
```

Gets the HTTP messages with the given IDs.

### method mode

```perl6
method mode() returns Mu
```

Gets the mode

### method numberOfAlerts

```perl6
method numberOfAlerts(
    :$baseurl,
    :$riskId
) returns Mu
```

Gets the number of alerts, optionally filtering by URL or riskId

### method numberOfMessages

```perl6
method numberOfMessages(
    :$baseurl
) returns Mu
```

Gets the number of messages, optionally filtering by URL

### method optionAlertOverridesFilePath

```perl6
method optionAlertOverridesFilePath() returns Mu
```

Gets the path to the file with alert overrides.

### method optionDefaultUserAgent

```perl6
method optionDefaultUserAgent() returns Mu
```

Gets the user agent that ZAP should use when creating HTTP messages (for example, spider messages or CONNECT requests to outgoing proxy).

### method optionDnsTtlSuccessfulQueries

```perl6
method optionDnsTtlSuccessfulQueries() returns Mu
```

Gets the TTL (in seconds) of successful DNS queries.

### method optionHttpState

```perl6
method optionHttpState() returns Mu
```

No Doc

### method optionHttpStateEnabled

```perl6
method optionHttpStateEnabled() returns Mu
```

No Doc

### method optionMaximumAlertInstances

```perl6
method optionMaximumAlertInstances() returns Mu
```

Gets the maximum number of alert instances to include in a report.

### method optionMergeRelatedAlerts

```perl6
method optionMergeRelatedAlerts() returns Mu
```

Gets whether or not related alerts will be merged in any reports generated.

### method optionProxyChainName

```perl6
method optionProxyChainName() returns Mu
```

No Doc

### method optionProxyChainPassword

```perl6
method optionProxyChainPassword() returns Mu
```

No Doc

### method optionProxyChainPort

```perl6
method optionProxyChainPort() returns Mu
```

No Doc

### method optionProxyChainPrompt

```perl6
method optionProxyChainPrompt() returns Mu
```

No Doc

### method optionProxyChainRealm

```perl6
method optionProxyChainRealm() returns Mu
```

No Doc

### method optionProxyChainSkipName

```perl6
method optionProxyChainSkipName() returns Mu
```

Use view proxyChainExcludedDomains instead.

### method optionProxyChainUserName

```perl6
method optionProxyChainUserName() returns Mu
```

No Doc

### method optionProxyExcludedDomains

```perl6
method optionProxyExcludedDomains() returns Mu
```

Use view proxyChainExcludedDomains instead.

### method optionProxyExcludedDomainsEnabled

```perl6
method optionProxyExcludedDomainsEnabled() returns Mu
```

Use view proxyChainExcludedDomains instead.

### method optionSingleCookieRequestHeader

```perl6
method optionSingleCookieRequestHeader() returns Mu
```

No Doc

### method optionTimeoutInSecs

```perl6
method optionTimeoutInSecs() returns Mu
```

Gets the connection time out, in seconds.

### method optionUseProxyChain

```perl6
method optionUseProxyChain() returns Mu
```

No Doc

### method optionUseProxyChainAuth

```perl6
method optionUseProxyChainAuth() returns Mu
```

No Doc

### method proxyChainExcludedDomains

```perl6
method proxyChainExcludedDomains() returns Mu
```

Gets all the domains that are excluded from the outgoing proxy. For each domain the following are shown: the index, the value (domain), if enabled, and if specified as a regex.

### method sessionLocation

```perl6
method sessionLocation() returns Mu
```

Gets the location of the current session file

### method sites

```perl6
method sites() returns Mu
```

Gets the sites accessed through/by ZAP (scheme and domain)

### method urls

```perl6
method urls(
    :$baseurl
) returns Mu
```

Gets the URLs accessed through/by ZAP, optionally filtering by (base) URL.

### method version

```perl6
method version() returns Mu
```

Gets ZAP version

### method zapHomePath

```perl6
method zapHomePath() returns Mu
```

Gets the path to ZAP's home directory.

### method htmlreport

```perl6
method htmlreport() returns Mu
```

Generates a report in HTML format

### method jsonreport

```perl6
method jsonreport() returns Mu
```

Generates a report in JSON format

### method mdreport

```perl6
method mdreport() returns Mu
```

Generates a report in Markdown format

### method messageHar

```perl6
method messageHar(
    :$id!
) returns Mu
```

Gets the message with the given ID in HAR format

### method messagesHar

```perl6
method messagesHar(
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Gets the HTTP messages sent through/by ZAP, in HAR format, optionally filtered by URL and paginated with 'start' position and 'count' of messages

### method messagesHarById

```perl6
method messagesHarById(
    :$ids!
) returns Mu
```

Gets the HTTP messages with the given IDs, in HAR format.

### method proxypac

```perl6
method proxypac() returns Mu
```

No Doc

### method rootcert

```perl6
method rootcert() returns Mu
```

Gets the Root CA certificate used by the local proxies.

### method sendHarRequest

```perl6
method sendHarRequest(
    :$request!,
    :$followRedirects
) returns Mu
```

Sends the first HAR request entry, optionally following redirections. Returns, in HAR format, the request sent and response received and followed redirections, if any. The Mode is enforced when sending the request (and following redirections), custom manual requests are not allowed in 'Safe' mode nor in 'Protected' mode if out of scope.

### method setproxy

```perl6
method setproxy(
    :$proxy!
) returns Mu
```

No Doc

### method xmlreport

```perl6
method xmlreport() returns Mu
```

Generates a report in XML format

### method accessUrl

```perl6
method accessUrl(
    :$url!,
    :$followRedirects
) returns Mu
```

Convenient and simple action to access a URL, optionally following redirections. Returns the request sent and response received and followed redirections, if any. Other actions are available which offer more control on what is sent, like, 'sendRequest' or 'sendHarRequest'.

### method addProxyChainExcludedDomain

```perl6
method addProxyChainExcludedDomain(
    :$value!,
    :$isRegex,
    :$isEnabled
) returns Mu
```

Adds a domain to be excluded from the outgoing proxy, using the specified value. Optionally sets if the new entry is enabled (default, true) and whether or not the new value is specified as a regex (default, false).

### method clearExcludedFromProxy

```perl6
method clearExcludedFromProxy() returns Mu
```

Clears the regexes of URLs excluded from the local proxies.

### method deleteAlert

```perl6
method deleteAlert(
    :$id!
) returns Mu
```

Deletes the alert with the given ID.

### method deleteAllAlerts

```perl6
method deleteAllAlerts() returns Mu
```

Deletes all alerts of the current session.

### method deleteSiteNode

```perl6
method deleteSiteNode(
    :$url!,
    :$method,
    :$postData
) returns Mu
```

Deletes the site node found in the Sites Tree on the basis of the URL, HTTP method, and post data (if applicable and specified).

### method disableAllProxyChainExcludedDomains

```perl6
method disableAllProxyChainExcludedDomains() returns Mu
```

Disables all domains excluded from the outgoing proxy.

### method disableClientCertificate

```perl6
method disableClientCertificate() returns Mu
```

Disables the option for use of client certificates.

### method enableAllProxyChainExcludedDomains

```perl6
method enableAllProxyChainExcludedDomains() returns Mu
```

Enables all domains excluded from the outgoing proxy.

### method enablePKCS12ClientCertificate

```perl6
method enablePKCS12ClientCertificate(
    :$filePath!,
    :$password!,
    :$index
) returns Mu
```

Enables use of a PKCS12 client certificate for the certificate with the given file system path, password, and optional index.

### method excludeFromProxy

```perl6
method excludeFromProxy(
    :$regex!
) returns Mu
```

Adds a regex of URLs that should be excluded from the local proxies.

### method generateRootCA

```perl6
method generateRootCA() returns Mu
```

Generates a new Root CA certificate for the local proxies.

### method loadSession

```perl6
method loadSession(
    :$name!
) returns Mu
```

Loads the session with the given name. If a relative path is specified it will be resolved against the "session" directory in ZAP "home" dir.

### method modifyProxyChainExcludedDomain

```perl6
method modifyProxyChainExcludedDomain(
    :$idx!,
    :$value,
    :$isRegex,
    :$isEnabled
) returns Mu
```

Modifies a domain excluded from the outgoing proxy. Allows to modify the value, if enabled or if a regex. The domain is selected with its index, which can be obtained with the view proxyChainExcludedDomains.

### method newSession

```perl6
method newSession(
    :$name,
    :$overwrite
) returns Mu
```

Creates a new session, optionally overwriting existing files. If a relative path is specified it will be resolved against the "session" directory in ZAP "home" dir.

### method removeProxyChainExcludedDomain

```perl6
method removeProxyChainExcludedDomain(
    :$idx!
) returns Mu
```

Removes a domain excluded from the outgoing proxy, with the given index. The index can be obtained with the view proxyChainExcludedDomains.

### method runGarbageCollection

```perl6
method runGarbageCollection() returns Mu
```

No Doc

### method saveSession

```perl6
method saveSession(
    :$name!,
    :$overwrite
) returns Mu
```

Saves the session.

### method sendRequest

```perl6
method sendRequest(
    :$request!,
    :$followRedirects
) returns Mu
```

Sends the HTTP request, optionally following redirections. Returns the request sent and response received and followed redirections, if any. The Mode is enforced when sending the request (and following redirections), custom manual requests are not allowed in 'Safe' mode nor in 'Protected' mode if out of scope.

### method setHomeDirectory

```perl6
method setHomeDirectory(
    :$dir!
) returns Mu
```

No Doc

### method setMode

```perl6
method setMode(
    :$mode!
) returns Mu
```

Sets the mode, which may be one of [safe, protect, standard, attack]

### method setOptionAlertOverridesFilePath

```perl6
method setOptionAlertOverridesFilePath(
    :$filePath
) returns Mu
```

Sets (or clears, if empty) the path to the file with alert overrides.

### method setOptionDefaultUserAgent

```perl6
method setOptionDefaultUserAgent(
    :$String!
) returns Mu
```

Sets the user agent that ZAP should use when creating HTTP messages (for example, spider messages or CONNECT requests to outgoing proxy).

### method setOptionDnsTtlSuccessfulQueries

```perl6
method setOptionDnsTtlSuccessfulQueries(
    :$Integer!
) returns Mu
```

Sets the TTL (in seconds) of successful DNS queries (applies after ZAP restart).

### method setOptionHttpStateEnabled

```perl6
method setOptionHttpStateEnabled(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionMaximumAlertInstances

```perl6
method setOptionMaximumAlertInstances(
    :$numberOfInstances!
) returns Mu
```

Sets the maximum number of alert instances to include in a report. A value of zero is treated as unlimited.

### method setOptionMergeRelatedAlerts

```perl6
method setOptionMergeRelatedAlerts(
    :$enabled!
) returns Mu
```

Sets whether or not related alerts will be merged in any reports generated.

### method setOptionProxyChainName

```perl6
method setOptionProxyChainName(
    :$String!
) returns Mu
```

No Doc

### method setOptionProxyChainPassword

```perl6
method setOptionProxyChainPassword(
    :$String!
) returns Mu
```

No Doc

### method setOptionProxyChainPort

```perl6
method setOptionProxyChainPort(
    :$Integer!
) returns Mu
```

No Doc

### method setOptionProxyChainPrompt

```perl6
method setOptionProxyChainPrompt(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionProxyChainRealm

```perl6
method setOptionProxyChainRealm(
    :$String!
) returns Mu
```

No Doc

### method setOptionProxyChainSkipName

```perl6
method setOptionProxyChainSkipName(
    :$String!
) returns Mu
```

Use actions [add|modify|remove]ProxyChainExcludedDomain instead.

### method setOptionProxyChainUserName

```perl6
method setOptionProxyChainUserName(
    :$String!
) returns Mu
```

No Doc

### method setOptionSingleCookieRequestHeader

```perl6
method setOptionSingleCookieRequestHeader(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionTimeoutInSecs

```perl6
method setOptionTimeoutInSecs(
    :$Integer!
) returns Mu
```

Sets the connection time out, in seconds.

### method setOptionUseProxyChain

```perl6
method setOptionUseProxyChain(
    :$Boolean!
) returns Mu
```

Sets whether or not the outgoing proxy should be used. The address/hostname of the outgoing proxy must be set to enable this option.

### method setOptionUseProxyChainAuth

```perl6
method setOptionUseProxyChainAuth(
    :$Boolean!
) returns Mu
```

No Doc

### method shutdown

```perl6
method shutdown() returns Mu
```

Shuts down ZAP

### method snapshotSession

```perl6
method snapshotSession(
    :$name,
    :$overwrite
) returns Mu
```

Snapshots the session, optionally with the given name, and overwriting existing files. If no name is specified the name of the current session with a timestamp appended is used. If a relative path is specified it will be resolved against the "session" directory in ZAP "home" dir.

class Zap::Users
----------------

class `Zap::Users` Methods

### method newUser

```perl6
method newUser(
    :$contextId!,
    :$name!
) returns Mu
```

Creates a new user with the given name for the context with the given ID.

### method removeUser

```perl6
method removeUser(
    :$contextId!,
    :$userId!
) returns Mu
```

Removes the user with the given ID that belongs to the context with the given ID.

### method setAuthenticationCredentials

```perl6
method setAuthenticationCredentials(
    :$contextId!,
    :$userId!,
    :$authCredentialsConfigParams
) returns Mu
```

Sets the authentication credentials for the user with the given ID that belongs to the context with the given ID.

### method setUserEnabled

```perl6
method setUserEnabled(
    :$contextId!,
    :$userId!,
    :$enabled!
) returns Mu
```

Sets whether or not the user, with the given ID that belongs to the context with the given ID, should be enabled.

### method setUserName

```perl6
method setUserName(
    :$contextId!,
    :$userId!,
    :$name!
) returns Mu
```

Renames the user with the given ID that belongs to the context with the given ID.

### method getUserById

```perl6
method getUserById(
    :$contextId!,
    :$userId!
) returns Mu
```

Gets the data of the user with the given ID that belongs to the context with the given ID.

### method usersList

```perl6
method usersList(
    :$contextId
) returns Mu
```

Gets a list of users that belong to the context with the given ID, or all users if none provided.

class Zap::Acsrf
----------------

class `Zap::Acsrf` Methods

### method removeOptionToken

```perl6
method removeOptionToken(
    :$String!
) returns Mu
```

Removes the anti-CSRF token with the given name

### method genForm

```perl6
method genForm(
    :$hrefId!
) returns Mu
```

Generate a form for testing lack of anti-CSRF tokens - typically invoked via ZAP

class Zap::Search
-----------------

class `Zap::Search` Methods

### method harByHeaderRegex

```perl6
method harByHeaderRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the HTTP messages, in HAR format, that match the given regular expression in the header(s) optionally filtered by URL and paginated with 'start' position and 'count' of messages.

### method harByRequestRegex

```perl6
method harByRequestRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the HTTP messages, in HAR format, that match the given regular expression in the request optionally filtered by URL and paginated with 'start' position and 'count' of messages.

### method harByResponseRegex

```perl6
method harByResponseRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the HTTP messages, in HAR format, that match the given regular expression in the response optionally filtered by URL and paginated with 'start' position and 'count' of messages.

### method harByUrlRegex

```perl6
method harByUrlRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the HTTP messages, in HAR format, that match the given regular expression in the URL optionally filtered by URL and paginated with 'start' position and 'count' of messages.

### method messagesByResponseRegex

```perl6
method messagesByResponseRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the HTTP messages that match the given regular expression in the response optionally filtered by URL and paginated with 'start' position and 'count' of messages.

### method messagesByUrlRegex

```perl6
method messagesByUrlRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the HTTP messages that match the given regular expression in the URL optionally filtered by URL and paginated with 'start' position and 'count' of messages.

### method urlsByHeaderRegex

```perl6
method urlsByHeaderRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the URLs of the HTTP messages that match the given regular expression in the header(s) optionally filtered by URL and paginated with 'start' position and 'count' of messages.

### method urlsByRequestRegex

```perl6
method urlsByRequestRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the URLs of the HTTP messages that match the given regular expression in the request optionally filtered by URL and paginated with 'start' position and 'count' of messages.

### method urlsByResponseRegex

```perl6
method urlsByResponseRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the URLs of the HTTP messages that match the given regular expression in the response optionally filtered by URL and paginated with 'start' position and 'count' of messages.

### method urlsByUrlRegex

```perl6
method urlsByUrlRegex(
    :$regex!,
    :$baseurl,
    :$start,
    :$count
) returns Mu
```

Returns the URLs of the HTTP messages that match the given regular expression in the URL optionally filtered by URL and paginated with 'start' position and 'count' of messages.

class Zap::Replacer
-------------------

class `Zap::Replacer` Methods

### method removeRule

```perl6
method removeRule(
    :$description!
) returns Mu
```

Removes the rule with the given description

### method setEnabled

```perl6
method setEnabled(
    :$description!,
    :$bool!
) returns Mu
```

Enables or disables the rule with the given description based on the bool parameter

class Zap::Context
------------------

class `Zap::Context` Methods

### method excludeAllContextTechnologies

```perl6
method excludeAllContextTechnologies(
    :$contextName!
) returns Mu
```

Excludes all built in technologies from a context

### method excludeContextTechnologies

```perl6
method excludeContextTechnologies(
    :$contextName!,
    :$technologyNames!
) returns Mu
```

Excludes technologies with the given names, separated by a comma, from a context

### method excludeFromContext

```perl6
method excludeFromContext(
    :$contextName!,
    :$regex!
) returns Mu
```

Add exclude regex to context

### method exportContext

```perl6
method exportContext(
    :$contextName!,
    :$contextFile!
) returns Mu
```

Exports the context with the given name to a file. If a relative file path is specified it will be resolved against the "contexts" directory in ZAP "home" dir.

### method importContext

```perl6
method importContext(
    :$contextFile!
) returns Mu
```

Imports a context from a file. If a relative file path is specified it will be resolved against the "contexts" directory in ZAP "home" dir.

### method includeAllContextTechnologies

```perl6
method includeAllContextTechnologies(
    :$contextName!
) returns Mu
```

Includes all built in technologies in to a context

### method includeContextTechnologies

```perl6
method includeContextTechnologies(
    :$contextName!,
    :$technologyNames!
) returns Mu
```

Includes technologies with the given names, separated by a comma, to a context

### method includeInContext

```perl6
method includeInContext(
    :$contextName!,
    :$regex!
) returns Mu
```

Add include regex to context

### method newContext

```perl6
method newContext(
    :$contextName!
) returns Mu
```

Creates a new context with the given name in the current session

### method removeContext

```perl6
method removeContext(
    :$contextName!
) returns Mu
```

Removes a context in the current session

### method setContextInScope

```perl6
method setContextInScope(
    :$contextName!,
    :$booleanInScope!
) returns Mu
```

Sets a context to in scope (contexts are in scope by default)

### method setContextRegexs

```perl6
method setContextRegexs(
    :$contextName!,
    :$incRegexs!,
    :$excRegexs!
) returns Mu
```

Set the regexs to include and exclude for a context, both supplied as JSON string arrays

### method excludeRegexs

```perl6
method excludeRegexs(
    :$contextName!
) returns Mu
```

List excluded regexs for context

### method excludedTechnologyList

```perl6
method excludedTechnologyList(
    :$contextName!
) returns Mu
```

Lists the names of all technologies excluded from a context

### method includeRegexs

```perl6
method includeRegexs(
    :$contextName!
) returns Mu
```

List included regexs for context

### method includedTechnologyList

```perl6
method includedTechnologyList(
    :$contextName!
) returns Mu
```

Lists the names of all technologies included in a context

### method technologyList

```perl6
method technologyList() returns Mu
```

Lists the names of all built in technologies

### method urls

```perl6
method urls(
    :$contextName!
) returns Mu
```

Lists the URLs accessed through/by ZAP, that belong to the context with the given name.

class Zap::Autoupdate
---------------------

class `Zap::Autoupdate` Methods

### method downloadLatestRelease

```perl6
method downloadLatestRelease() returns Mu
```

Downloads the latest release, if any

### method installAddon

```perl6
method installAddon(
    :$id!
) returns Mu
```

Installs or updates the specified add-on, returning when complete (i.e. not asynchronously)

### method setOptionCheckAddonUpdates

```perl6
method setOptionCheckAddonUpdates(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionCheckOnStart

```perl6
method setOptionCheckOnStart(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionDownloadNewRelease

```perl6
method setOptionDownloadNewRelease(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionInstallAddonUpdates

```perl6
method setOptionInstallAddonUpdates(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionInstallScannerRules

```perl6
method setOptionInstallScannerRules(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionReportAlphaAddons

```perl6
method setOptionReportAlphaAddons(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionReportBetaAddons

```perl6
method setOptionReportBetaAddons(
    :$Boolean!
) returns Mu
```

No Doc

### method setOptionReportReleaseAddons

```perl6
method setOptionReportReleaseAddons(
    :$Boolean!
) returns Mu
```

No Doc

### method uninstallAddon

```perl6
method uninstallAddon(
    :$id!
) returns Mu
```

Uninstalls the specified add-on

### method latestVersionNumber

```perl6
method latestVersionNumber() returns Mu
```

Returns the latest version number

### method localAddons

```perl6
method localAddons() returns Mu
```

Returns a list with all local add-ons, installed or not.

### method marketplaceAddons

```perl6
method marketplaceAddons() returns Mu
```

Return a list of all of the add-ons on the ZAP Marketplace (this information is read once and then cached)

### method newAddons

```perl6
method newAddons() returns Mu
```

Return a list of any add-ons that have been added to the Marketplace since the last check for updates

### method optionAddonDirectories

```perl6
method optionAddonDirectories() returns Mu
```

No Doc

### method optionCheckAddonUpdates

```perl6
method optionCheckAddonUpdates() returns Mu
```

No Doc

### method optionCheckOnStart

```perl6
method optionCheckOnStart() returns Mu
```

No Doc

### method optionDayLastChecked

```perl6
method optionDayLastChecked() returns Mu
```

No Doc

### method optionDayLastInstallWarned

```perl6
method optionDayLastInstallWarned() returns Mu
```

No Doc

### method optionDayLastUpdateWarned

```perl6
method optionDayLastUpdateWarned() returns Mu
```

No Doc

### method optionDownloadDirectory

```perl6
method optionDownloadDirectory() returns Mu
```

No Doc

### method optionDownloadNewRelease

```perl6
method optionDownloadNewRelease() returns Mu
```

No Doc

### method optionInstallAddonUpdates

```perl6
method optionInstallAddonUpdates() returns Mu
```

No Doc

### method optionInstallScannerRules

```perl6
method optionInstallScannerRules() returns Mu
```

No Doc

### method optionReportAlphaAddons

```perl6
method optionReportAlphaAddons() returns Mu
```

No Doc

### method optionReportBetaAddons

```perl6
method optionReportBetaAddons() returns Mu
```

No Doc

### method optionReportReleaseAddons

```perl6
method optionReportReleaseAddons() returns Mu
```

No Doc

### method updatedAddons

```perl6
method updatedAddons() returns Mu
```

Return a list of any add-ons that have been changed in the Marketplace since the last check for updates

class Zap::Alert
----------------

class `Zap::Alert` Methods

### method addAlert

```perl6
method addAlert(
    :$messageId!,
    :$name!,
    :$riskId!,
    :$confidenceId!,
    :$description!,
    :$param,
    :$attack,
    :$otherInfo,
    :$solution,
    :$references,
    :$evidence,
    :$cweId,
    :$wascId
) returns Mu
```

Add an alert associated with the given message ID, with the provided details. (The ID of the created alert is returned.)

### method deleteAlert

```perl6
method deleteAlert(
    :$id!
) returns Mu
```

Deletes the alert with the given ID.

### method deleteAllAlerts

```perl6
method deleteAllAlerts() returns Mu
```

Deletes all alerts of the current session.

### method updateAlert

```perl6
method updateAlert(
    :$id!,
    :$name!,
    :$riskId!,
    :$confidenceId!,
    :$description!,
    :$param,
    :$attack,
    :$otherInfo,
    :$solution,
    :$references,
    :$evidence,
    :$cweId,
    :$wascId
) returns Mu
```

Update the alert with the given ID, with the provided details.

### method alerts

```perl6
method alerts(
    :$baseurl,
    :$start,
    :$count,
    :$riskId
) returns Mu
```

Gets the alerts raised by ZAP, optionally filtering by URL or riskId, and paginating with 'start' position and 'count' of alerts

### method alertsByRisk

```perl6
method alertsByRisk(
    :$url,
    :$recurse
) returns Mu
```

Gets a summary of the alerts, optionally filtered by a 'url'. If 'recurse' is true then all alerts that apply to urls that start with the specified 'url' will be returned, otherwise only those on exactly the same 'url' (ignoring url parameters)

### method alertsSummary

```perl6
method alertsSummary(
    :$baseurl
) returns Mu
```

Gets number of alerts grouped by each risk level, optionally filtering by URL

### method numberOfAlerts

```perl6
method numberOfAlerts(
    :$baseurl,
    :$riskId
) returns Mu
```

Gets the number of alerts, optionally filtering by URL or riskId

