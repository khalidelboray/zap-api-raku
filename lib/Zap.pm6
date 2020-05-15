use Zap::Client;

sub EXPORT() {
    %(
        'ZapClient' => Zap::Client,
    )
}

unit module Zap;

our $ZapClient is export(:client) = Zap::Client.new:
        :apikey(%*ENV<ZAP_API_KEY>),
        :port(%*ENV<ZAP_PORT> // 8080),
        :addr(%*ENV<ZAP_ADDR> // '127.0.0.1');

sub ZapConfig(:$port = 8080,:$addr = '127.0.0.1',:$apikey!) is export(:MANDATORY) {
    $ZapClient = Zap::Client.new: :$apikey, :$port, :$addr;
}
#| class `Zap::Ruleconfig` Methods 
our class Ruleconfig {

	#| Reset all of the rule configurations
	method resetAllRuleConfigValues () {
		my $query = %();
		$ZapClient.request('ruleConfig/action/resetAllRuleConfigValues',$query);
	}
	#| Reset the specified rule configuration, which must already exist
	method resetRuleConfigValue (:$key!) {
		my $query = %(:$key);
		$ZapClient.request('ruleConfig/action/resetRuleConfigValue',$query);
	}
	#| Set the specified rule configuration, which must already exist
	method setRuleConfigValue (:$key!, :$value) {
		my $query = %(:$key);
		$query<value> = $value if defined $value ;
		$ZapClient.request('ruleConfig/action/setRuleConfigValue',$query);
	}

}#| class `Zap::Break` Methods 
our class Break {

	#| Returns True if ZAP will break on requests
	method isBreakRequest () {
		my $query = %();
		$ZapClient.request('break/view/isBreakRequest',$query);
	}
	#| Returns True if ZAP will break on responses
	method isBreakResponse () {
		my $query = %();
		$ZapClient.request('break/view/isBreakResponse',$query);
	}
	#| Waits until an HTTP breakpoint has been hit, at which point it returns the message. Poll is the number of milliseconds ZAP will pause between checking for breakpoints being hit (default 500). If keepalive is zero or less then the response will be returned as a Server Sent Event, otherwise it is used as the frequency in seconds at which 'keepalive' events should be returned and the response is sent as a standard response.
	method waitForHttpBreak (:$poll, :$keepalive) {
		my $query = %();
		$query<poll> = $poll if defined $poll ;
		$query<keepalive> = $keepalive if defined $keepalive ;
		$ZapClient.request('break/pconn/waitForHttpBreak',$query);
	}
	#| Adds a custom HTTP breakpoint. The string is the string to match. Location may be one of: url, request_header, request_body, response_header or response_body. Match may be: contains or regex. Inverse (match) may be true or false. Lastly, ignorecase (when matching the string) may be true or false.
	method addHttpBreakpoint (:$string!, :$location!, :$match!, :$inverse!, :$ignorecase!) {
		my $query = %(:$string, :$location, :$match, :$inverse, :$ignorecase);
		$ZapClient.request('break/action/addHttpBreakpoint',$query);
	}
	#| Controls the global break functionality. The type may be one of: http-all, http-request or http-response. The state may be true (for turning break on for the specified type) or false (for turning break off). Scope is not currently used.
	method break (:$type!, :$state!, :$scope) {
		my $query = %(:$type, :$state);
		$query<scope> = $scope if defined $scope ;
		$ZapClient.request('break/action/break',$query);
	}
	#| Submits the currently intercepted message and unsets the global request/response breakpoints
	method continue () {
		my $query = %();
		$ZapClient.request('break/action/continue',$query);
	}
	#| Drops the currently intercepted message
	method drop () {
		my $query = %();
		$ZapClient.request('break/action/drop',$query);
	}
	#| Removes the specified breakpoint
	method removeHttpBreakpoint (:$string!, :$location!, :$match!, :$inverse!, :$ignorecase!) {
		my $query = %(:$string, :$location, :$match, :$inverse, :$ignorecase);
		$ZapClient.request('break/action/removeHttpBreakpoint',$query);
	}
	#| Overwrites the currently intercepted message with the data provided
	method setHttpMessage (:$httpHeader!, :$httpBody) {
		my $query = %(:$httpHeader);
		$query<httpBody> = $httpBody if defined $httpBody ;
		$ZapClient.request('break/action/setHttpMessage',$query);
	}
	#| Submits the currently intercepted message, the next request or response will automatically be intercepted
	method step () {
		my $query = %();
		$ZapClient.request('break/action/step',$query);
	}

}#| class `Zap::Hud` Methods 
our class Hud {

	#| Returns the alert summary needed by the HUD for the specified URL
	method hudAlertData (:$url!) {
		my $query = %(:$url);
		$ZapClient.request('hud/view/hudAlertData',$query);
	}
	#| Returns true if the 'Allow unsafe-eval' option is set
	method optionAllowUnsafeEval () {
		my $query = %();
		$ZapClient.request('hud/view/optionAllowUnsafeEval',$query);
	}
	#| Returns the base directory from which the HUD files are loaded
	method optionBaseDirectory () {
		my $query = %();
		$ZapClient.request('hud/view/optionBaseDirectory',$query);
	}
	#| Returns true if the 'Development mode' option is set
	method optionDevelopmentMode () {
		my $query = %();
		$ZapClient.request('hud/view/optionDevelopmentMode',$query);
	}
	#| No Doc
	method optionEnableOnDomainMsgs () {
		my $query = %();
		$ZapClient.request('hud/view/optionEnableOnDomainMsgs',$query);
	}
	#| No Doc
	method optionEnabledForDaemon () {
		my $query = %();
		$ZapClient.request('hud/view/optionEnabledForDaemon',$query);
	}
	#| No Doc
	method optionEnabledForDesktop () {
		my $query = %();
		$ZapClient.request('hud/view/optionEnabledForDesktop',$query);
	}
	#| Returns true if the 'In scope only' option is set
	method optionInScopeOnly () {
		my $query = %();
		$ZapClient.request('hud/view/optionInScopeOnly',$query);
	}
	#| Returns true if the 'Remove CSP' option is set
	method optionRemoveCSP () {
		my $query = %();
		$ZapClient.request('hud/view/optionRemoveCSP',$query);
	}
	#| No Doc
	method optionShowWelcomeScreen () {
		my $query = %();
		$ZapClient.request('hud/view/optionShowWelcomeScreen',$query);
	}
	#| No Doc
	method optionSkipTutorialTasks () {
		my $query = %();
		$ZapClient.request('hud/view/optionSkipTutorialTasks',$query);
	}
	#| No Doc
	method optionTutorialHost () {
		my $query = %();
		$ZapClient.request('hud/view/optionTutorialHost',$query);
	}
	#| No Doc
	method optionTutorialPort () {
		my $query = %();
		$ZapClient.request('hud/view/optionTutorialPort',$query);
	}
	#| No Doc
	method optionTutorialTasksDone () {
		my $query = %();
		$ZapClient.request('hud/view/optionTutorialTasksDone',$query);
	}
	#| No Doc
	method optionTutorialTestMode () {
		my $query = %();
		$ZapClient.request('hud/view/optionTutorialTestMode',$query);
	}
	#| No Doc
	method optionTutorialUpdates () {
		my $query = %();
		$ZapClient.request('hud/view/optionTutorialUpdates',$query);
	}
	#| No Doc
	method tutorialUpdates () {
		my $query = %();
		$ZapClient.request('hud/view/tutorialUpdates',$query);
	}
	#| No Doc
	method upgradedDomains () {
		my $query = %();
		$ZapClient.request('hud/view/upgradedDomains',$query);
	}
	#| Returns the changelog in HTML format
	method changesInHtml () {
		my $query = %();
		$ZapClient.request('hud/other/changesInHtml',$query, :format<OTHER>);
	}
	#| Used by the HUD to log messages from the browser
	method log (:$record!) {
		my $query = %(:$record);
		$ZapClient.request('hud/action/log',$query);
	}
	#| Used by the HUD to cache a request the user wants to send in the browser
	method recordRequest (:$header!, :$body!) {
		my $query = %(:$header, :$body);
		$ZapClient.request('hud/action/recordRequest',$query);
	}
	#| Reset the tutorial tasks so that they must be completed again
	method resetTutorialTasks () {
		my $query = %();
		$ZapClient.request('hud/action/resetTutorialTasks',$query);
	}
	#| Set the base directory from which the HUD files are loaded
	method setOptionBaseDirectory (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('hud/action/setOptionBaseDirectory',$query);
	}
	#| Sets the boolean option 'Development mode'
	method setOptionDevelopmentMode (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('hud/action/setOptionDevelopmentMode',$query);
	}
	#| No Doc
	method setOptionEnableOnDomainMsgs (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('hud/action/setOptionEnableOnDomainMsgs',$query);
	}
	#| No Doc
	method setOptionEnabledForDaemon (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('hud/action/setOptionEnabledForDaemon',$query);
	}
	#| No Doc
	method setOptionEnabledForDesktop (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('hud/action/setOptionEnabledForDesktop',$query);
	}
	#| Sets the boolean option 'In scope only'
	method setOptionInScopeOnly (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('hud/action/setOptionInScopeOnly',$query);
	}
	#| Sets the boolean option 'Remove CSP'
	method setOptionRemoveCSP (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('hud/action/setOptionRemoveCSP',$query);
	}
	#| No Doc
	method setOptionShowWelcomeScreen (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('hud/action/setOptionShowWelcomeScreen',$query);
	}
	#| No Doc
	method setOptionSkipTutorialTasks (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('hud/action/setOptionSkipTutorialTasks',$query);
	}
	#| No Doc
	method setOptionTutorialTaskDone (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('hud/action/setOptionTutorialTaskDone',$query);
	}
	#| No Doc
	method setOptionTutorialTestMode (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('hud/action/setOptionTutorialTestMode',$query);
	}
	#| Sets a UI option with the given key and value. The key must be 50 or fewer alphanumeric characters
	method setUiOption (:$key!, :$value) {
		my $query = %(:$key);
		$query<value> = $value if defined $value ;
		$ZapClient.request('hud/action/setUiOption',$query);
	}

}#| class `Zap::Forceduser` Methods 
our class Forceduser {

	#| Sets the user (ID) that should be used in 'forced user' mode for the given context (ID)
	method setForcedUser (:$contextId!, :$userId!) {
		my $query = %(:$contextId, :$userId);
		$ZapClient.request('forcedUser/action/setForcedUser',$query);
	}
	#| Sets if 'forced user' mode should be enabled or not
	method setForcedUserModeEnabled (:$boolean!) {
		my $query = %(:$boolean);
		$ZapClient.request('forcedUser/action/setForcedUserModeEnabled',$query);
	}

}#| class `Zap::Stats` Methods 
our class Stats {

	#| Clears all of the statistics
	method clearStats (:$keyPrefix) {
		my $query = %();
		$query<keyPrefix> = $keyPrefix if defined $keyPrefix ;
		$ZapClient.request('stats/action/clearStats',$query);
	}
	#| Sets whether in memory statistics are enabled
	method setOptionInMemoryEnabled (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('stats/action/setOptionInMemoryEnabled',$query);
	}
	#| Sets the Statsd service hostname, supply an empty string to stop using a Statsd service
	method setOptionStatsdHost (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('stats/action/setOptionStatsdHost',$query);
	}
	#| Sets the Statsd service port
	method setOptionStatsdPort (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('stats/action/setOptionStatsdPort',$query);
	}
	#| Sets the prefix to be applied to all stats sent to the configured Statsd service
	method setOptionStatsdPrefix (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('stats/action/setOptionStatsdPrefix',$query);
	}
	#| Returns 'true' if a Statsd server has been correctly configured, otherwise returns 'false'
	method optionStatsdEnabled () {
		my $query = %();
		$ZapClient.request('stats/view/optionStatsdEnabled',$query);
	}
	#| Gets the Statsd service hostname
	method optionStatsdHost () {
		my $query = %();
		$ZapClient.request('stats/view/optionStatsdHost',$query);
	}
	#| Gets the Statsd service port
	method optionStatsdPort () {
		my $query = %();
		$ZapClient.request('stats/view/optionStatsdPort',$query);
	}
	#| Gets the prefix to be applied to all stats sent to the configured Statsd service
	method optionStatsdPrefix () {
		my $query = %();
		$ZapClient.request('stats/view/optionStatsdPrefix',$query);
	}
	#| Gets all of the global statistics, optionally filtered by a key prefix
	method siteStats (:$site!, :$keyPrefix) {
		my $query = %(:$site);
		$query<keyPrefix> = $keyPrefix if defined $keyPrefix ;
		$ZapClient.request('stats/view/siteStats',$query);
	}
	#| Statistics
	method stats (:$keyPrefix) {
		my $query = %();
		$query<keyPrefix> = $keyPrefix if defined $keyPrefix ;
		$ZapClient.request('stats/view/stats',$query);
	}

}#| class `Zap::Alertfilter` Methods 
our class Alertfilter {

	#| Adds a new alert filter for the context with the given ID.
	method addAlertFilter (:$contextId!, :$ruleId!, :$newLevel!, :$url, :$urlIsRegex, :$parameter, :$enabled, :$parameterIsRegex, :$attack, :$attackIsRegex, :$evidence, :$evidenceIsRegex) {
		my $query = %(:$contextId, :$ruleId, :$newLevel);
		$query<url> = $url if defined $url ;
		$query<urlIsRegex> = $urlIsRegex if defined $urlIsRegex ;
		$query<parameter> = $parameter if defined $parameter ;
		$query<enabled> = $enabled if defined $enabled ;
		$query<parameterIsRegex> = $parameterIsRegex if defined $parameterIsRegex ;
		$query<attack> = $attack if defined $attack ;
		$query<attackIsRegex> = $attackIsRegex if defined $attackIsRegex ;
		$query<evidence> = $evidence if defined $evidence ;
		$query<evidenceIsRegex> = $evidenceIsRegex if defined $evidenceIsRegex ;
		$ZapClient.request('alertFilter/action/addAlertFilter',$query);
	}
	#| Adds a new global alert filter.
	method addGlobalAlertFilter (:$ruleId!, :$newLevel!, :$url, :$urlIsRegex, :$parameter, :$enabled, :$parameterIsRegex, :$attack, :$attackIsRegex, :$evidence, :$evidenceIsRegex) {
		my $query = %(:$ruleId, :$newLevel);
		$query<url> = $url if defined $url ;
		$query<urlIsRegex> = $urlIsRegex if defined $urlIsRegex ;
		$query<parameter> = $parameter if defined $parameter ;
		$query<enabled> = $enabled if defined $enabled ;
		$query<parameterIsRegex> = $parameterIsRegex if defined $parameterIsRegex ;
		$query<attack> = $attack if defined $attack ;
		$query<attackIsRegex> = $attackIsRegex if defined $attackIsRegex ;
		$query<evidence> = $evidence if defined $evidence ;
		$query<evidenceIsRegex> = $evidenceIsRegex if defined $evidenceIsRegex ;
		$ZapClient.request('alertFilter/action/addGlobalAlertFilter',$query);
	}
	#| Removes an alert filter from the context with the given ID.
	method removeAlertFilter (:$contextId!, :$ruleId!, :$newLevel!, :$url, :$urlIsRegex, :$parameter, :$enabled, :$parameterIsRegex, :$attack, :$attackIsRegex, :$evidence, :$evidenceIsRegex) {
		my $query = %(:$contextId, :$ruleId, :$newLevel);
		$query<url> = $url if defined $url ;
		$query<urlIsRegex> = $urlIsRegex if defined $urlIsRegex ;
		$query<parameter> = $parameter if defined $parameter ;
		$query<enabled> = $enabled if defined $enabled ;
		$query<parameterIsRegex> = $parameterIsRegex if defined $parameterIsRegex ;
		$query<attack> = $attack if defined $attack ;
		$query<attackIsRegex> = $attackIsRegex if defined $attackIsRegex ;
		$query<evidence> = $evidence if defined $evidence ;
		$query<evidenceIsRegex> = $evidenceIsRegex if defined $evidenceIsRegex ;
		$ZapClient.request('alertFilter/action/removeAlertFilter',$query);
	}
	#| Removes a global alert filter.
	method removeGlobalAlertFilter (:$ruleId!, :$newLevel!, :$url, :$urlIsRegex, :$parameter, :$enabled, :$parameterIsRegex, :$attack, :$attackIsRegex, :$evidence, :$evidenceIsRegex) {
		my $query = %(:$ruleId, :$newLevel);
		$query<url> = $url if defined $url ;
		$query<urlIsRegex> = $urlIsRegex if defined $urlIsRegex ;
		$query<parameter> = $parameter if defined $parameter ;
		$query<enabled> = $enabled if defined $enabled ;
		$query<parameterIsRegex> = $parameterIsRegex if defined $parameterIsRegex ;
		$query<attack> = $attack if defined $attack ;
		$query<attackIsRegex> = $attackIsRegex if defined $attackIsRegex ;
		$query<evidence> = $evidence if defined $evidence ;
		$query<evidenceIsRegex> = $evidenceIsRegex if defined $evidenceIsRegex ;
		$ZapClient.request('alertFilter/action/removeGlobalAlertFilter',$query);
	}

}#| class `Zap::Ascan` Methods 
our class Ascan {

	#| Adds a new parameter excluded from the scan, using the specified name. Optionally sets if the new entry applies to a specific URL (default, all URLs) and sets the ID of the type of the parameter (default, ID of any type). The type IDs can be obtained with the view excludedParamTypes.
	method addExcludedParam (:$name!, :$type, :$url) {
		my $query = %(:$name);
		$query<type> = $type if defined $type ;
		$query<url> = $url if defined $url ;
		$ZapClient.request('ascan/action/addExcludedParam',$query);
	}
	#| No Doc
	method addScanPolicy (:$scanPolicyName!, :$alertThreshold, :$attackStrength) {
		my $query = %(:$scanPolicyName);
		$query<alertThreshold> = $alertThreshold if defined $alertThreshold ;
		$query<attackStrength> = $attackStrength if defined $attackStrength ;
		$ZapClient.request('ascan/action/addScanPolicy',$query);
	}
	#| Clears the regexes of URLs excluded from the active scans.
	method clearExcludedFromScan () {
		my $query = %();
		$ZapClient.request('ascan/action/clearExcludedFromScan',$query);
	}
	#| Disables all scanners of the scan policy with the given name, or the default if none given.
	method disableAllScanners (:$scanPolicyName) {
		my $query = %();
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$ZapClient.request('ascan/action/disableAllScanners',$query);
	}
	#| Disables the scanners with the given IDs (comma separated list of IDs) of the scan policy with the given name, or the default if none given.
	method disableScanners (:$ids!, :$scanPolicyName) {
		my $query = %(:$ids);
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$ZapClient.request('ascan/action/disableScanners',$query);
	}
	#| Enables all scanners of the scan policy with the given name, or the default if none given.
	method enableAllScanners (:$scanPolicyName) {
		my $query = %();
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$ZapClient.request('ascan/action/enableAllScanners',$query);
	}
	#| Enables the scanners with the given IDs (comma separated list of IDs) of the scan policy with the given name, or the default if none given.
	method enableScanners (:$ids!, :$scanPolicyName) {
		my $query = %(:$ids);
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$ZapClient.request('ascan/action/enableScanners',$query);
	}
	#| Adds a regex of URLs that should be excluded from the active scans.
	method excludeFromScan (:$regex!) {
		my $query = %(:$regex);
		$ZapClient.request('ascan/action/excludeFromScan',$query);
	}
	#| Imports a Scan Policy using the given file system path.
	method importScanPolicy (:$path!) {
		my $query = %(:$path);
		$ZapClient.request('ascan/action/importScanPolicy',$query);
	}
	#| Modifies a parameter excluded from the scan. Allows to modify the name, the URL and the type of parameter. The parameter is selected with its index, which can be obtained with the view excludedParams.
	method modifyExcludedParam (:$idx!, :$name, :$type, :$url) {
		my $query = %(:$idx);
		$query<name> = $name if defined $name ;
		$query<type> = $type if defined $type ;
		$query<url> = $url if defined $url ;
		$ZapClient.request('ascan/action/modifyExcludedParam',$query);
	}
	#| No Doc
	method pause (:$scanId!) {
		my $query = %(:$scanId);
		$ZapClient.request('ascan/action/pause',$query);
	}
	#| No Doc
	method pauseAllScans () {
		my $query = %();
		$ZapClient.request('ascan/action/pauseAllScans',$query);
	}
	#| No Doc
	method removeAllScans () {
		my $query = %();
		$ZapClient.request('ascan/action/removeAllScans',$query);
	}
	#| Removes a parameter excluded from the scan, with the given index. The index can be obtained with the view excludedParams.
	method removeExcludedParam (:$idx!) {
		my $query = %(:$idx);
		$ZapClient.request('ascan/action/removeExcludedParam',$query);
	}
	#| No Doc
	method removeScan (:$scanId!) {
		my $query = %(:$scanId);
		$ZapClient.request('ascan/action/removeScan',$query);
	}
	#| No Doc
	method removeScanPolicy (:$scanPolicyName!) {
		my $query = %(:$scanPolicyName);
		$ZapClient.request('ascan/action/removeScanPolicy',$query);
	}
	#| No Doc
	method resume (:$scanId!) {
		my $query = %(:$scanId);
		$ZapClient.request('ascan/action/resume',$query);
	}
	#| No Doc
	method resumeAllScans () {
		my $query = %();
		$ZapClient.request('ascan/action/resumeAllScans',$query);
	}
	#| Runs the active scanner against the given URL and/or Context. Optionally, the 'recurse' parameter can be used to scan URLs under the given URL, the parameter 'inScopeOnly' can be used to constrain the scan to URLs that are in scope (ignored if a Context is specified), the parameter 'scanPolicyName' allows to specify the scan policy (if none is given it uses the default scan policy), the parameters 'method' and 'postData' allow to select a given request in conjunction with the given URL.
	method scan (:$url, :$recurse, :$inScopeOnly, :$scanPolicyName, :$method, :$postData, :$contextId) {
		my $query = %();
		$query<url> = $url if defined $url ;
		$query<recurse> = $recurse if defined $recurse ;
		$query<inScopeOnly> = $inScopeOnly if defined $inScopeOnly ;
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$query<method> = $method if defined $method ;
		$query<postData> = $postData if defined $postData ;
		$query<contextId> = $contextId if defined $contextId ;
		$ZapClient.request('ascan/action/scan',$query);
	}
	#| Active Scans from the perspective of a User, obtained using the given Context ID and User ID. See 'scan' action for more details.
	method scanAsUser (:$url, :$contextId, :$userId, :$recurse, :$scanPolicyName, :$method, :$postData) {
		my $query = %();
		$query<url> = $url if defined $url ;
		$query<contextId> = $contextId if defined $contextId ;
		$query<userId> = $userId if defined $userId ;
		$query<recurse> = $recurse if defined $recurse ;
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$query<method> = $method if defined $method ;
		$query<postData> = $postData if defined $postData ;
		$ZapClient.request('ascan/action/scanAsUser',$query);
	}
	#| No Doc
	method setEnabledPolicies (:$ids!, :$scanPolicyName) {
		my $query = %(:$ids);
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$ZapClient.request('ascan/action/setEnabledPolicies',$query);
	}
	#| Sets whether or not the active scanner should add a query param to GET requests which do not have parameters to start with.
	method setOptionAddQueryParam (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ascan/action/setOptionAddQueryParam',$query);
	}
	#| No Doc
	method setOptionAllowAttackOnStart (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ascan/action/setOptionAllowAttackOnStart',$query);
	}
	#| No Doc
	method setOptionAttackPolicy (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('ascan/action/setOptionAttackPolicy',$query);
	}
	#| No Doc
	method setOptionDefaultPolicy (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('ascan/action/setOptionDefaultPolicy',$query);
	}
	#| No Doc
	method setOptionDelayInMs (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionDelayInMs',$query);
	}
	#| No Doc
	method setOptionHandleAntiCSRFTokens (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ascan/action/setOptionHandleAntiCSRFTokens',$query);
	}
	#| No Doc
	method setOptionHostPerScan (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionHostPerScan',$query);
	}
	#| Sets whether or not the active scanner should inject the HTTP request header X-ZAP-Scan-ID, with the ID of the scanner that's sending the requests.
	method setOptionInjectPluginIdInHeader (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ascan/action/setOptionInjectPluginIdInHeader',$query);
	}
	#| No Doc
	method setOptionMaxChartTimeInMins (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionMaxChartTimeInMins',$query);
	}
	#| No Doc
	method setOptionMaxResultsToList (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionMaxResultsToList',$query);
	}
	#| No Doc
	method setOptionMaxRuleDurationInMins (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionMaxRuleDurationInMins',$query);
	}
	#| No Doc
	method setOptionMaxScanDurationInMins (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionMaxScanDurationInMins',$query);
	}
	#| No Doc
	method setOptionMaxScansInUI (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionMaxScansInUI',$query);
	}
	#| No Doc
	method setOptionPromptInAttackMode (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ascan/action/setOptionPromptInAttackMode',$query);
	}
	#| No Doc
	method setOptionPromptToClearFinishedScans (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ascan/action/setOptionPromptToClearFinishedScans',$query);
	}
	#| No Doc
	method setOptionRescanInAttackMode (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ascan/action/setOptionRescanInAttackMode',$query);
	}
	#| Sets whether or not the HTTP Headers of all requests should be scanned. Not just requests that send parameters, through the query or request body.
	method setOptionScanHeadersAllRequests (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ascan/action/setOptionScanHeadersAllRequests',$query);
	}
	#| No Doc
	method setOptionShowAdvancedDialog (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ascan/action/setOptionShowAdvancedDialog',$query);
	}
	#| No Doc
	method setOptionTargetParamsEnabledRPC (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionTargetParamsEnabledRPC',$query);
	}
	#| No Doc
	method setOptionTargetParamsInjectable (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionTargetParamsInjectable',$query);
	}
	#| No Doc
	method setOptionThreadPerHost (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ascan/action/setOptionThreadPerHost',$query);
	}
	#| No Doc
	method setPolicyAlertThreshold (:$id!, :$alertThreshold!, :$scanPolicyName) {
		my $query = %(:$id, :$alertThreshold);
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$ZapClient.request('ascan/action/setPolicyAlertThreshold',$query);
	}
	#| No Doc
	method setPolicyAttackStrength (:$id!, :$attackStrength!, :$scanPolicyName) {
		my $query = %(:$id, :$attackStrength);
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$ZapClient.request('ascan/action/setPolicyAttackStrength',$query);
	}
	#| No Doc
	method setScannerAlertThreshold (:$id!, :$alertThreshold!, :$scanPolicyName) {
		my $query = %(:$id, :$alertThreshold);
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$ZapClient.request('ascan/action/setScannerAlertThreshold',$query);
	}
	#| No Doc
	method setScannerAttackStrength (:$id!, :$attackStrength!, :$scanPolicyName) {
		my $query = %(:$id, :$attackStrength);
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$ZapClient.request('ascan/action/setScannerAttackStrength',$query);
	}
	#| Skips the scanner using the given IDs of the scan and the scanner.
	method skipScanner (:$scanId!, :$scannerId!) {
		my $query = %(:$scanId, :$scannerId);
		$ZapClient.request('ascan/action/skipScanner',$query);
	}
	#| No Doc
	method stop (:$scanId!) {
		my $query = %(:$scanId);
		$ZapClient.request('ascan/action/stop',$query);
	}
	#| No Doc
	method stopAllScans () {
		my $query = %();
		$ZapClient.request('ascan/action/stopAllScans',$query);
	}
	#| No Doc
	method updateScanPolicy (:$scanPolicyName!, :$alertThreshold, :$attackStrength) {
		my $query = %(:$scanPolicyName);
		$query<alertThreshold> = $alertThreshold if defined $alertThreshold ;
		$query<attackStrength> = $attackStrength if defined $attackStrength ;
		$ZapClient.request('ascan/action/updateScanPolicy',$query);
	}
	#| Gets the regexes of URLs excluded from the active scans.
	method excludedFromScan () {
		my $query = %();
		$ZapClient.request('ascan/view/excludedFromScan',$query);
	}
	#| Gets all the types of excluded parameters. For each type the following are shown: the ID and the name.
	method excludedParamTypes () {
		my $query = %();
		$ZapClient.request('ascan/view/excludedParamTypes',$query);
	}
	#| Gets all the parameters that are excluded. For each parameter the following are shown: the name, the URL, and the parameter type.
	method excludedParams () {
		my $query = %();
		$ZapClient.request('ascan/view/excludedParams',$query);
	}
	#| Gets the IDs of the messages sent during the scan with the given ID. A message can be obtained with 'message' core view.
	method messagesIds (:$scanId!) {
		my $query = %(:$scanId);
		$ZapClient.request('ascan/view/messagesIds',$query);
	}
	#| Tells whether or not the active scanner should add a query parameter to GET request that don't have parameters to start with.
	method optionAddQueryParam () {
		my $query = %();
		$ZapClient.request('ascan/view/optionAddQueryParam',$query);
	}
	#| No Doc
	method optionAllowAttackOnStart () {
		my $query = %();
		$ZapClient.request('ascan/view/optionAllowAttackOnStart',$query);
	}
	#| No Doc
	method optionAttackPolicy () {
		my $query = %();
		$ZapClient.request('ascan/view/optionAttackPolicy',$query);
	}
	#| No Doc
	method optionDefaultPolicy () {
		my $query = %();
		$ZapClient.request('ascan/view/optionDefaultPolicy',$query);
	}
	#| No Doc
	method optionDelayInMs () {
		my $query = %();
		$ZapClient.request('ascan/view/optionDelayInMs',$query);
	}
	#| Use view excludedParams instead.
	method optionExcludedParamList () {
		my $query = %();
		$ZapClient.request('ascan/view/optionExcludedParamList',$query);
	}
	#| No Doc
	method optionHandleAntiCSRFTokens () {
		my $query = %();
		$ZapClient.request('ascan/view/optionHandleAntiCSRFTokens',$query);
	}
	#| No Doc
	method optionHostPerScan () {
		my $query = %();
		$ZapClient.request('ascan/view/optionHostPerScan',$query);
	}
	#| Tells whether or not the active scanner should inject the HTTP request header X-ZAP-Scan-ID, with the ID of the scanner that's sending the requests.
	method optionInjectPluginIdInHeader () {
		my $query = %();
		$ZapClient.request('ascan/view/optionInjectPluginIdInHeader',$query);
	}
	#| No Doc
	method optionMaxChartTimeInMins () {
		my $query = %();
		$ZapClient.request('ascan/view/optionMaxChartTimeInMins',$query);
	}
	#| No Doc
	method optionMaxResultsToList () {
		my $query = %();
		$ZapClient.request('ascan/view/optionMaxResultsToList',$query);
	}
	#| No Doc
	method optionMaxRuleDurationInMins () {
		my $query = %();
		$ZapClient.request('ascan/view/optionMaxRuleDurationInMins',$query);
	}
	#| No Doc
	method optionMaxScanDurationInMins () {
		my $query = %();
		$ZapClient.request('ascan/view/optionMaxScanDurationInMins',$query);
	}
	#| No Doc
	method optionMaxScansInUI () {
		my $query = %();
		$ZapClient.request('ascan/view/optionMaxScansInUI',$query);
	}
	#| No Doc
	method optionPromptInAttackMode () {
		my $query = %();
		$ZapClient.request('ascan/view/optionPromptInAttackMode',$query);
	}
	#| No Doc
	method optionPromptToClearFinishedScans () {
		my $query = %();
		$ZapClient.request('ascan/view/optionPromptToClearFinishedScans',$query);
	}
	#| No Doc
	method optionRescanInAttackMode () {
		my $query = %();
		$ZapClient.request('ascan/view/optionRescanInAttackMode',$query);
	}
	#| Tells whether or not the HTTP Headers of all requests should be scanned. Not just requests that send parameters, through the query or request body.
	method optionScanHeadersAllRequests () {
		my $query = %();
		$ZapClient.request('ascan/view/optionScanHeadersAllRequests',$query);
	}
	#| No Doc
	method optionShowAdvancedDialog () {
		my $query = %();
		$ZapClient.request('ascan/view/optionShowAdvancedDialog',$query);
	}
	#| No Doc
	method optionTargetParamsEnabledRPC () {
		my $query = %();
		$ZapClient.request('ascan/view/optionTargetParamsEnabledRPC',$query);
	}
	#| No Doc
	method optionTargetParamsInjectable () {
		my $query = %();
		$ZapClient.request('ascan/view/optionTargetParamsInjectable',$query);
	}
	#| No Doc
	method optionThreadPerHost () {
		my $query = %();
		$ZapClient.request('ascan/view/optionThreadPerHost',$query);
	}
	#| No Doc
	method policies (:$scanPolicyName, :$policyId) {
		my $query = %();
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$query<policyId> = $policyId if defined $policyId ;
		$ZapClient.request('ascan/view/policies',$query);
	}
	#| No Doc
	method scanPolicyNames () {
		my $query = %();
		$ZapClient.request('ascan/view/scanPolicyNames',$query);
	}
	#| No Doc
	method scanProgress (:$scanId) {
		my $query = %();
		$query<scanId> = $scanId if defined $scanId ;
		$ZapClient.request('ascan/view/scanProgress',$query);
	}
	#| Gets the scanners, optionally, of the given scan policy and/or scanner policy/category ID.
	method scanners (:$scanPolicyName, :$policyId) {
		my $query = %();
		$query<scanPolicyName> = $scanPolicyName if defined $scanPolicyName ;
		$query<policyId> = $policyId if defined $policyId ;
		$ZapClient.request('ascan/view/scanners',$query);
	}
	#| No Doc
	method scans () {
		my $query = %();
		$ZapClient.request('ascan/view/scans',$query);
	}
	#| No Doc
	method status (:$scanId) {
		my $query = %();
		$query<scanId> = $scanId if defined $scanId ;
		$ZapClient.request('ascan/view/status',$query);
	}

}#| class `Zap::Spider` Methods 
our class Spider {

	#| Gets all the domains that are always in scope. For each domain the following are shown: the index, the value (domain), if enabled, and if specified as a regex.
	method domainsAlwaysInScope () {
		my $query = %();
		$ZapClient.request('spider/view/domainsAlwaysInScope',$query);
	}
	#| Gets the regexes of URLs excluded from the spider scans.
	method excludedFromScan () {
		my $query = %();
		$ZapClient.request('spider/view/excludedFromScan',$query);
	}
	#| No Doc
	method fullResults (:$scanId!) {
		my $query = %(:$scanId);
		$ZapClient.request('spider/view/fullResults',$query);
	}
	#| Gets whether or not a spider process should accept cookies while spidering.
	method optionAcceptCookies () {
		my $query = %();
		$ZapClient.request('spider/view/optionAcceptCookies',$query);
	}
	#| Use view domainsAlwaysInScope instead.
	method optionDomainsAlwaysInScope () {
		my $query = %();
		$ZapClient.request('spider/view/optionDomainsAlwaysInScope',$query);
	}
	#| Use view domainsAlwaysInScope instead.
	method optionDomainsAlwaysInScopeEnabled () {
		my $query = %();
		$ZapClient.request('spider/view/optionDomainsAlwaysInScopeEnabled',$query);
	}
	#| No Doc
	method optionHandleODataParametersVisited () {
		my $query = %();
		$ZapClient.request('spider/view/optionHandleODataParametersVisited',$query);
	}
	#| No Doc
	method optionHandleParameters () {
		my $query = %();
		$ZapClient.request('spider/view/optionHandleParameters',$query);
	}
	#| Gets the maximum number of child nodes (per node) that can be crawled, 0 means no limit.
	method optionMaxChildren () {
		my $query = %();
		$ZapClient.request('spider/view/optionMaxChildren',$query);
	}
	#| Gets the maximum depth the spider can crawl, 0 if unlimited.
	method optionMaxDepth () {
		my $query = %();
		$ZapClient.request('spider/view/optionMaxDepth',$query);
	}
	#| No Doc
	method optionMaxDuration () {
		my $query = %();
		$ZapClient.request('spider/view/optionMaxDuration',$query);
	}
	#| Gets the maximum size, in bytes, that a response might have to be parsed.
	method optionMaxParseSizeBytes () {
		my $query = %();
		$ZapClient.request('spider/view/optionMaxParseSizeBytes',$query);
	}
	#| No Doc
	method optionMaxScansInUI () {
		my $query = %();
		$ZapClient.request('spider/view/optionMaxScansInUI',$query);
	}
	#| No Doc
	method optionParseComments () {
		my $query = %();
		$ZapClient.request('spider/view/optionParseComments',$query);
	}
	#| No Doc
	method optionParseGit () {
		my $query = %();
		$ZapClient.request('spider/view/optionParseGit',$query);
	}
	#| No Doc
	method optionParseRobotsTxt () {
		my $query = %();
		$ZapClient.request('spider/view/optionParseRobotsTxt',$query);
	}
	#| No Doc
	method optionParseSVNEntries () {
		my $query = %();
		$ZapClient.request('spider/view/optionParseSVNEntries',$query);
	}
	#| No Doc
	method optionParseSitemapXml () {
		my $query = %();
		$ZapClient.request('spider/view/optionParseSitemapXml',$query);
	}
	#| No Doc
	method optionPostForm () {
		my $query = %();
		$ZapClient.request('spider/view/optionPostForm',$query);
	}
	#| No Doc
	method optionProcessForm () {
		my $query = %();
		$ZapClient.request('spider/view/optionProcessForm',$query);
	}
	#| No Doc
	method optionRequestWaitTime () {
		my $query = %();
		$ZapClient.request('spider/view/optionRequestWaitTime',$query);
	}
	#| No Doc
	method optionScope () {
		my $query = %();
		$ZapClient.request('spider/view/optionScope',$query);
	}
	#| No Doc
	method optionScopeText () {
		my $query = %();
		$ZapClient.request('spider/view/optionScopeText',$query);
	}
	#| Gets whether or not the 'Referer' header should be sent while spidering.
	method optionSendRefererHeader () {
		my $query = %();
		$ZapClient.request('spider/view/optionSendRefererHeader',$query);
	}
	#| No Doc
	method optionShowAdvancedDialog () {
		my $query = %();
		$ZapClient.request('spider/view/optionShowAdvancedDialog',$query);
	}
	#| No Doc
	method optionSkipURLString () {
		my $query = %();
		$ZapClient.request('spider/view/optionSkipURLString',$query);
	}
	#| No Doc
	method optionThreadCount () {
		my $query = %();
		$ZapClient.request('spider/view/optionThreadCount',$query);
	}
	#| No Doc
	method optionUserAgent () {
		my $query = %();
		$ZapClient.request('spider/view/optionUserAgent',$query);
	}
	#| No Doc
	method results (:$scanId) {
		my $query = %();
		$query<scanId> = $scanId if defined $scanId ;
		$ZapClient.request('spider/view/results',$query);
	}
	#| No Doc
	method scans () {
		my $query = %();
		$ZapClient.request('spider/view/scans',$query);
	}
	#| No Doc
	method status (:$scanId) {
		my $query = %();
		$query<scanId> = $scanId if defined $scanId ;
		$ZapClient.request('spider/view/status',$query);
	}
	#| Adds a new domain that's always in scope, using the specified value. Optionally sets if the new entry is enabled (default, true) and whether or not the new value is specified as a regex (default, false).
	method addDomainAlwaysInScope (:$value!, :$isRegex, :$isEnabled) {
		my $query = %(:$value);
		$query<isRegex> = $isRegex if defined $isRegex ;
		$query<isEnabled> = $isEnabled if defined $isEnabled ;
		$ZapClient.request('spider/action/addDomainAlwaysInScope',$query);
	}
	#| Clears the regexes of URLs excluded from the spider scans.
	method clearExcludedFromScan () {
		my $query = %();
		$ZapClient.request('spider/action/clearExcludedFromScan',$query);
	}
	#| Disables all domains that are always in scope.
	method disableAllDomainsAlwaysInScope () {
		my $query = %();
		$ZapClient.request('spider/action/disableAllDomainsAlwaysInScope',$query);
	}
	#| Enables all domains that are always in scope.
	method enableAllDomainsAlwaysInScope () {
		my $query = %();
		$ZapClient.request('spider/action/enableAllDomainsAlwaysInScope',$query);
	}
	#| Adds a regex of URLs that should be excluded from the spider scans.
	method excludeFromScan (:$regex!) {
		my $query = %(:$regex);
		$ZapClient.request('spider/action/excludeFromScan',$query);
	}
	#| Modifies a domain that's always in scope. Allows to modify the value, if enabled or if a regex. The domain is selected with its index, which can be obtained with the view domainsAlwaysInScope.
	method modifyDomainAlwaysInScope (:$idx!, :$value, :$isRegex, :$isEnabled) {
		my $query = %(:$idx);
		$query<value> = $value if defined $value ;
		$query<isRegex> = $isRegex if defined $isRegex ;
		$query<isEnabled> = $isEnabled if defined $isEnabled ;
		$ZapClient.request('spider/action/modifyDomainAlwaysInScope',$query);
	}
	#| No Doc
	method pause (:$scanId!) {
		my $query = %(:$scanId);
		$ZapClient.request('spider/action/pause',$query);
	}
	#| No Doc
	method pauseAllScans () {
		my $query = %();
		$ZapClient.request('spider/action/pauseAllScans',$query);
	}
	#| No Doc
	method removeAllScans () {
		my $query = %();
		$ZapClient.request('spider/action/removeAllScans',$query);
	}
	#| Removes a domain that's always in scope, with the given index. The index can be obtained with the view domainsAlwaysInScope.
	method removeDomainAlwaysInScope (:$idx!) {
		my $query = %(:$idx);
		$ZapClient.request('spider/action/removeDomainAlwaysInScope',$query);
	}
	#| No Doc
	method removeScan (:$scanId!) {
		my $query = %(:$scanId);
		$ZapClient.request('spider/action/removeScan',$query);
	}
	#| No Doc
	method resume (:$scanId!) {
		my $query = %(:$scanId);
		$ZapClient.request('spider/action/resume',$query);
	}
	#| No Doc
	method resumeAllScans () {
		my $query = %();
		$ZapClient.request('spider/action/resumeAllScans',$query);
	}
	#| Runs the spider against the given URL (or context). Optionally, the 'maxChildren' parameter can be set to limit the number of children scanned, the 'recurse' parameter can be used to prevent the spider from seeding recursively, the parameter 'contextName' can be used to constrain the scan to a Context and the parameter 'subtreeOnly' allows to restrict the spider under a site's subtree (using the specified 'url').
	method scan (:$url, :$maxChildren, :$recurse, :$contextName, :$subtreeOnly) {
		my $query = %();
		$query<url> = $url if defined $url ;
		$query<maxChildren> = $maxChildren if defined $maxChildren ;
		$query<recurse> = $recurse if defined $recurse ;
		$query<contextName> = $contextName if defined $contextName ;
		$query<subtreeOnly> = $subtreeOnly if defined $subtreeOnly ;
		$ZapClient.request('spider/action/scan',$query);
	}
	#| Runs the spider from the perspective of a User, obtained using the given Context ID and User ID. See 'scan' action for more details.
	method scanAsUser (:$contextId!, :$userId!, :$url, :$maxChildren, :$recurse, :$subtreeOnly) {
		my $query = %(:$contextId, :$userId);
		$query<url> = $url if defined $url ;
		$query<maxChildren> = $maxChildren if defined $maxChildren ;
		$query<recurse> = $recurse if defined $recurse ;
		$query<subtreeOnly> = $subtreeOnly if defined $subtreeOnly ;
		$ZapClient.request('spider/action/scanAsUser',$query);
	}
	#| Sets whether or not a spider process should accept cookies while spidering.
	method setOptionAcceptCookies (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionAcceptCookies',$query);
	}
	#| No Doc
	method setOptionHandleODataParametersVisited (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionHandleODataParametersVisited',$query);
	}
	#| No Doc
	method setOptionHandleParameters (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('spider/action/setOptionHandleParameters',$query);
	}
	#| Sets the maximum number of child nodes (per node) that can be crawled, 0 means no limit.
	method setOptionMaxChildren (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('spider/action/setOptionMaxChildren',$query);
	}
	#| Sets the maximum depth the spider can crawl, 0 for unlimited depth.
	method setOptionMaxDepth (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('spider/action/setOptionMaxDepth',$query);
	}
	#| No Doc
	method setOptionMaxDuration (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('spider/action/setOptionMaxDuration',$query);
	}
	#| Sets the maximum size, in bytes, that a response might have to be parsed. This allows the spider to skip big responses/files.
	method setOptionMaxParseSizeBytes (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('spider/action/setOptionMaxParseSizeBytes',$query);
	}
	#| No Doc
	method setOptionMaxScansInUI (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('spider/action/setOptionMaxScansInUI',$query);
	}
	#| No Doc
	method setOptionParseComments (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionParseComments',$query);
	}
	#| No Doc
	method setOptionParseGit (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionParseGit',$query);
	}
	#| No Doc
	method setOptionParseRobotsTxt (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionParseRobotsTxt',$query);
	}
	#| No Doc
	method setOptionParseSVNEntries (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionParseSVNEntries',$query);
	}
	#| No Doc
	method setOptionParseSitemapXml (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionParseSitemapXml',$query);
	}
	#| No Doc
	method setOptionPostForm (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionPostForm',$query);
	}
	#| No Doc
	method setOptionProcessForm (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionProcessForm',$query);
	}
	#| No Doc
	method setOptionRequestWaitTime (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('spider/action/setOptionRequestWaitTime',$query);
	}
	#| Use actions [add|modify|remove]DomainAlwaysInScope instead.
	method setOptionScopeString (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('spider/action/setOptionScopeString',$query);
	}
	#| Sets whether or not the 'Referer' header should be sent while spidering.
	method setOptionSendRefererHeader (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionSendRefererHeader',$query);
	}
	#| No Doc
	method setOptionShowAdvancedDialog (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('spider/action/setOptionShowAdvancedDialog',$query);
	}
	#| No Doc
	method setOptionSkipURLString (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('spider/action/setOptionSkipURLString',$query);
	}
	#| No Doc
	method setOptionThreadCount (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('spider/action/setOptionThreadCount',$query);
	}
	#| No Doc
	method setOptionUserAgent (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('spider/action/setOptionUserAgent',$query);
	}
	#| No Doc
	method stop (:$scanId) {
		my $query = %();
		$query<scanId> = $scanId if defined $scanId ;
		$ZapClient.request('spider/action/stop',$query);
	}
	#| No Doc
	method stopAllScans () {
		my $query = %();
		$ZapClient.request('spider/action/stopAllScans',$query);
	}

}#| class `Zap::Selenium` Methods 
our class Selenium {

	#| Sets the current path to ChromeDriver
	method setOptionChromeDriverPath (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('selenium/action/setOptionChromeDriverPath',$query);
	}
	#| Sets the current path to Firefox binary
	method setOptionFirefoxBinaryPath (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('selenium/action/setOptionFirefoxBinaryPath',$query);
	}
	#| Sets the current path to Firefox driver (geckodriver)
	method setOptionFirefoxDriverPath (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('selenium/action/setOptionFirefoxDriverPath',$query);
	}
	#| No Doc
	method setOptionIeDriverPath (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('selenium/action/setOptionIeDriverPath',$query);
	}
	#| Sets the current path to PhantomJS binary
	method setOptionPhantomJsBinaryPath (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('selenium/action/setOptionPhantomJsBinaryPath',$query);
	}
	#| Returns the current path to Firefox driver (geckodriver)
	method optionFirefoxDriverPath () {
		my $query = %();
		$ZapClient.request('selenium/view/optionFirefoxDriverPath',$query);
	}
	#| No Doc
	method optionIeDriverPath () {
		my $query = %();
		$ZapClient.request('selenium/view/optionIeDriverPath',$query);
	}
	#| Returns the current path to PhantomJS binary
	method optionPhantomJsBinaryPath () {
		my $query = %();
		$ZapClient.request('selenium/view/optionPhantomJsBinaryPath',$query);
	}

}#| class `Zap::Httpsessions` Methods 
our class Httpsessions {

	#| Adds a default session token with the given name and enabled state.
	method addDefaultSessionToken (:$sessionToken!, :$tokenEnabled) {
		my $query = %(:$sessionToken);
		$query<tokenEnabled> = $tokenEnabled if defined $tokenEnabled ;
		$ZapClient.request('httpSessions/action/addDefaultSessionToken',$query);
	}
	#| Adds the session token to the given site.
	method addSessionToken (:$site!, :$sessionToken!) {
		my $query = %(:$site, :$sessionToken);
		$ZapClient.request('httpSessions/action/addSessionToken',$query);
	}
	#| Creates an empty session for the given site. Optionally with the given name.
	method createEmptySession (:$site!, :$session) {
		my $query = %(:$site);
		$query<session> = $session if defined $session ;
		$ZapClient.request('httpSessions/action/createEmptySession',$query);
	}
	#| Removes the default session token with the given name.
	method removeDefaultSessionToken (:$sessionToken!) {
		my $query = %(:$sessionToken);
		$ZapClient.request('httpSessions/action/removeDefaultSessionToken',$query);
	}
	#| Removes the session from the given site.
	method removeSession (:$site!, :$session!) {
		my $query = %(:$site, :$session);
		$ZapClient.request('httpSessions/action/removeSession',$query);
	}
	#| Removes the session token from the given site.
	method removeSessionToken (:$site!, :$sessionToken!) {
		my $query = %(:$site, :$sessionToken);
		$ZapClient.request('httpSessions/action/removeSessionToken',$query);
	}
	#| Renames the session of the given site.
	method renameSession (:$site!, :$oldSessionName!, :$newSessionName!) {
		my $query = %(:$site, :$oldSessionName, :$newSessionName);
		$ZapClient.request('httpSessions/action/renameSession',$query);
	}
	#| Sets the given session as active for the given site.
	method setActiveSession (:$site!, :$session!) {
		my $query = %(:$site, :$session);
		$ZapClient.request('httpSessions/action/setActiveSession',$query);
	}
	#| Sets whether or not the default session token with the given name is enabled.
	method setDefaultSessionTokenEnabled (:$sessionToken!, :$tokenEnabled!) {
		my $query = %(:$sessionToken, :$tokenEnabled);
		$ZapClient.request('httpSessions/action/setDefaultSessionTokenEnabled',$query);
	}
	#| Sets the value of the session token of the given session for the given site.
	method setSessionTokenValue (:$site!, :$session!, :$sessionToken!, :$tokenValue!) {
		my $query = %(:$site, :$session, :$sessionToken, :$tokenValue);
		$ZapClient.request('httpSessions/action/setSessionTokenValue',$query);
	}
	#| Unsets the active session of the given site.
	method unsetActiveSession (:$site!) {
		my $query = %(:$site);
		$ZapClient.request('httpSessions/action/unsetActiveSession',$query);
	}
	#| Gets the names of the session tokens for the given site.
	method sessionTokens (:$site!) {
		my $query = %(:$site);
		$ZapClient.request('httpSessions/view/sessionTokens',$query);
	}
	#| Gets the sessions for the given site. Optionally returning just the session with the given name.
	method sessions (:$site!, :$session) {
		my $query = %(:$site);
		$query<session> = $session if defined $session ;
		$ZapClient.request('httpSessions/view/sessions',$query);
	}
	#| Gets all of the sites that have sessions.
	method sites () {
		my $query = %();
		$ZapClient.request('httpSessions/view/sites',$query);
	}

}#| class `Zap::Localproxies` Methods 
our class Localproxies {

	#| Removes the additional proxy with the specified address and port.
	method removeAdditionalProxy (:$address!, :$port!) {
		my $query = %(:$address, :$port);
		$ZapClient.request('localProxies/action/removeAdditionalProxy',$query);
	}

}#| class `Zap::Websocket` Methods 
our class Websocket {

	#| Returns full details of the message specified by the channelId and messageId
	method message (:$channelId!, :$messageId!) {
		my $query = %(:$channelId, :$messageId);
		$ZapClient.request('websocket/view/message',$query);
	}
	#| Returns a list of all of the messages that meet the given criteria (all optional), where channelId is a channel identifier, start is the offset to start returning messages from (starting from 0), count is the number of messages to return (default no limit) and payloadPreviewLength is the maximum number bytes to return for the payload contents
	method messages (:$channelId, :$start, :$count, :$payloadPreviewLength) {
		my $query = %();
		$query<channelId> = $channelId if defined $channelId ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$query<payloadPreviewLength> = $payloadPreviewLength if defined $payloadPreviewLength ;
		$ZapClient.request('websocket/view/messages',$query);
	}
	#| Sends the specified message on the channel specified by channelId, if outgoing is 'True' then the message will be sent to the server and if it is 'False' then it will be sent to the client
	method sendTextMessage (:$channelId!, :$outgoing!, :$message!) {
		my $query = %(:$channelId, :$outgoing, :$message);
		$ZapClient.request('websocket/action/sendTextMessage',$query);
	}
	#| Sets the text message for an intercepted websockets message
	method setBreakTextMessage (:$message!, :$outgoing!) {
		my $query = %(:$message, :$outgoing);
		$ZapClient.request('websocket/action/setBreakTextMessage',$query);
	}

}#| class `Zap::Authentication` Methods 
our class Authentication {

	#| Sets the authentication method for the context with the given ID.
	method setAuthenticationMethod (:$contextId!, :$authMethodName!, :$authMethodConfigParams) {
		my $query = %(:$contextId, :$authMethodName);
		$query<authMethodConfigParams> = $authMethodConfigParams if defined $authMethodConfigParams ;
		$ZapClient.request('authentication/action/setAuthenticationMethod',$query);
	}
	#| Sets the logged in indicator for the context with the given ID.
	method setLoggedInIndicator (:$contextId!, :$loggedInIndicatorRegex!) {
		my $query = %(:$contextId, :$loggedInIndicatorRegex);
		$ZapClient.request('authentication/action/setLoggedInIndicator',$query);
	}
	#| Sets the logged out indicator for the context with the given ID.
	method setLoggedOutIndicator (:$contextId!, :$loggedOutIndicatorRegex!) {
		my $query = %(:$contextId, :$loggedOutIndicatorRegex);
		$ZapClient.request('authentication/action/setLoggedOutIndicator',$query);
	}
	#| Gets the logged in indicator for the context with the given ID.
	method getLoggedInIndicator (:$contextId!) {
		my $query = %(:$contextId);
		$ZapClient.request('authentication/view/getLoggedInIndicator',$query);
	}
	#| Gets the logged out indicator for the context with the given ID.
	method getLoggedOutIndicator (:$contextId!) {
		my $query = %(:$contextId);
		$ZapClient.request('authentication/view/getLoggedOutIndicator',$query);
	}
	#| Gets the name of the authentication methods.
	method getSupportedAuthenticationMethods () {
		my $query = %();
		$ZapClient.request('authentication/view/getSupportedAuthenticationMethods',$query);
	}

}#| class `Zap::Pscan` Methods 
our class Pscan {

	#| Disables all passive scanners
	method disableAllScanners () {
		my $query = %();
		$ZapClient.request('pscan/action/disableAllScanners',$query);
	}
	#| Disables all passive scan tags.
	method disableAllTags () {
		my $query = %();
		$ZapClient.request('pscan/action/disableAllTags',$query);
	}
	#| Disables all passive scanners with the given IDs (comma separated list of IDs)
	method disableScanners (:$ids!) {
		my $query = %(:$ids);
		$ZapClient.request('pscan/action/disableScanners',$query);
	}
	#| Enables all passive scanners
	method enableAllScanners () {
		my $query = %();
		$ZapClient.request('pscan/action/enableAllScanners',$query);
	}
	#| Enables all passive scan tags.
	method enableAllTags () {
		my $query = %();
		$ZapClient.request('pscan/action/enableAllTags',$query);
	}
	#| Enables all passive scanners with the given IDs (comma separated list of IDs)
	method enableScanners (:$ids!) {
		my $query = %(:$ids);
		$ZapClient.request('pscan/action/enableScanners',$query);
	}
	#| Sets whether or not the passive scanning is enabled (Note: the enabled state is not persisted).
	method setEnabled (:$enabled!) {
		my $query = %(:$enabled);
		$ZapClient.request('pscan/action/setEnabled',$query);
	}
	#| Sets the maximum number of alerts a passive scan rule should raise.
	method setMaxAlertsPerRule (:$maxAlerts!) {
		my $query = %(:$maxAlerts);
		$ZapClient.request('pscan/action/setMaxAlertsPerRule',$query);
	}
	#| Sets whether or not the passive scan should be performed only on messages that are in scope.
	method setScanOnlyInScope (:$onlyInScope!) {
		my $query = %(:$onlyInScope);
		$ZapClient.request('pscan/action/setScanOnlyInScope',$query);
	}
	#| Sets the alert threshold of the passive scanner with the given ID, accepted values for alert threshold: OFF, DEFAULT, LOW, MEDIUM and HIGH
	method setScannerAlertThreshold (:$id!, :$alertThreshold!) {
		my $query = %(:$id, :$alertThreshold);
		$ZapClient.request('pscan/action/setScannerAlertThreshold',$query);
	}
	#| The number of records the passive scanner still has to scan
	method recordsToScan () {
		my $query = %();
		$ZapClient.request('pscan/view/recordsToScan',$query);
	}
	#| Tells whether or not the passive scan should be performed only on messages that are in scope.
	method scanOnlyInScope () {
		my $query = %();
		$ZapClient.request('pscan/view/scanOnlyInScope',$query);
	}
	#| Lists all passive scanners with its ID, name, enabled state and alert threshold.
	method scanners () {
		my $query = %();
		$ZapClient.request('pscan/view/scanners',$query);
	}

}#| class `Zap::Sessionmanagement` Methods 
our class Sessionmanagement {

	#| Gets the name of the session management methods.
	method getSupportedSessionManagementMethods () {
		my $query = %();
		$ZapClient.request('sessionManagement/view/getSupportedSessionManagementMethods',$query);
	}
	#| Sets the session management method for the context with the given ID.
	method setSessionManagementMethod (:$contextId!, :$methodName!, :$methodConfigParams) {
		my $query = %(:$contextId, :$methodName);
		$query<methodConfigParams> = $methodConfigParams if defined $methodConfigParams ;
		$ZapClient.request('sessionManagement/action/setSessionManagementMethod',$query);
	}

}#| class `Zap::Script` Methods 
our class Script {

	#| Gets the value of the global variable with the given key. Returns an API error (DOES_NOT_EXIST) if no value was previously set.
	method globalVar (:$varKey!) {
		my $query = %(:$varKey);
		$ZapClient.request('script/view/globalVar',$query);
	}
	#| Gets all the global variables (key/value pairs).
	method globalVars () {
		my $query = %();
		$ZapClient.request('script/view/globalVars',$query);
	}
	#| Lists the script engines available
	method listEngines () {
		my $query = %();
		$ZapClient.request('script/view/listEngines',$query);
	}
	#| Lists the scripts available, with its engine, name, description, type and error state.
	method listScripts () {
		my $query = %();
		$ZapClient.request('script/view/listScripts',$query);
	}
	#| Lists the script types available.
	method listTypes () {
		my $query = %();
		$ZapClient.request('script/view/listTypes',$query);
	}
	#| Gets the value (string representation) of a custom variable. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists or if no value was previously set.
	method scriptCustomVar (:$scriptName!, :$varKey!) {
		my $query = %(:$scriptName, :$varKey);
		$ZapClient.request('script/view/scriptCustomVar',$query);
	}
	#| Gets all the custom variables (key/value pairs, the value is the string representation) of a script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.
	method scriptCustomVars (:$scriptName!) {
		my $query = %(:$scriptName);
		$ZapClient.request('script/view/scriptCustomVars',$query);
	}
	#| Gets the value of the variable with the given key for the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists or if no value was previously set.
	method scriptVar (:$scriptName!, :$varKey!) {
		my $query = %(:$scriptName, :$varKey);
		$ZapClient.request('script/view/scriptVar',$query);
	}
	#| Gets all the variables (key/value pairs) of the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.
	method scriptVars (:$scriptName!) {
		my $query = %(:$scriptName);
		$ZapClient.request('script/view/scriptVars',$query);
	}
	#| Clears a global custom variable.
	method clearGlobalCustomVar (:$varKey!) {
		my $query = %(:$varKey);
		$ZapClient.request('script/action/clearGlobalCustomVar',$query);
	}
	#| Clears the global variable with the given key.
	method clearGlobalVar (:$varKey!) {
		my $query = %(:$varKey);
		$ZapClient.request('script/action/clearGlobalVar',$query);
	}
	#| Clears the global variables.
	method clearGlobalVars () {
		my $query = %();
		$ZapClient.request('script/action/clearGlobalVars',$query);
	}
	#| Clears a script custom variable.
	method clearScriptCustomVar (:$scriptName!, :$varKey!) {
		my $query = %(:$scriptName, :$varKey);
		$ZapClient.request('script/action/clearScriptCustomVar',$query);
	}
	#| Clears the variable with the given key of the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.
	method clearScriptVar (:$scriptName!, :$varKey!) {
		my $query = %(:$scriptName, :$varKey);
		$ZapClient.request('script/action/clearScriptVar',$query);
	}
	#| Clears the variables of the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.
	method clearScriptVars (:$scriptName!) {
		my $query = %(:$scriptName);
		$ZapClient.request('script/action/clearScriptVars',$query);
	}
	#| Disables the script with the given name
	method disable (:$scriptName!) {
		my $query = %(:$scriptName);
		$ZapClient.request('script/action/disable',$query);
	}
	#| Enables the script with the given name
	method enable (:$scriptName!) {
		my $query = %(:$scriptName);
		$ZapClient.request('script/action/enable',$query);
	}
	#| Loads a script into ZAP from the given local file, with the given name, type and engine, optionally with a description, and a charset name to read the script (the charset name is required if the script is not in UTF-8, for example, in ISO-8859-1).
	method load (:$scriptName!, :$scriptType!, :$scriptEngine!, :$fileName!, :$scriptDescription, :$charset) {
		my $query = %(:$scriptName, :$scriptType, :$scriptEngine, :$fileName);
		$query<scriptDescription> = $scriptDescription if defined $scriptDescription ;
		$query<charset> = $charset if defined $charset ;
		$ZapClient.request('script/action/load',$query);
	}
	#| Removes the script with the given name
	method remove (:$scriptName!) {
		my $query = %(:$scriptName);
		$ZapClient.request('script/action/remove',$query);
	}
	#| Runs the stand alone script with the given name
	method runStandAloneScript (:$scriptName!) {
		my $query = %(:$scriptName);
		$ZapClient.request('script/action/runStandAloneScript',$query);
	}
	#| Sets the value of the global variable with the given key.
	method setGlobalVar (:$varKey!, :$varValue) {
		my $query = %(:$varKey);
		$query<varValue> = $varValue if defined $varValue ;
		$ZapClient.request('script/action/setGlobalVar',$query);
	}
	#| Sets the value of the variable with the given key of the given script. Returns an API error (DOES_NOT_EXIST) if no script with the given name exists.
	method setScriptVar (:$scriptName!, :$varKey!, :$varValue) {
		my $query = %(:$scriptName, :$varKey);
		$query<varValue> = $varValue if defined $varValue ;
		$ZapClient.request('script/action/setScriptVar',$query);
	}

}#| class `Zap::Ajaxspider` Methods 
our class Ajaxspider {

	#| No Doc
	method optionBrowserId () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionBrowserId',$query);
	}
	#| No Doc
	method optionClickDefaultElems () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionClickDefaultElems',$query);
	}
	#| No Doc
	method optionClickElemsOnce () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionClickElemsOnce',$query);
	}
	#| No Doc
	method optionEventWait () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionEventWait',$query);
	}
	#| No Doc
	method optionMaxCrawlDepth () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionMaxCrawlDepth',$query);
	}
	#| No Doc
	method optionMaxCrawlStates () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionMaxCrawlStates',$query);
	}
	#| No Doc
	method optionMaxDuration () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionMaxDuration',$query);
	}
	#| No Doc
	method optionNumberOfBrowsers () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionNumberOfBrowsers',$query);
	}
	#| No Doc
	method optionRandomInputs () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionRandomInputs',$query);
	}
	#| No Doc
	method optionReloadWait () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/optionReloadWait',$query);
	}
	#| No Doc
	method results (:$start, :$count) {
		my $query = %();
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('ajaxSpider/view/results',$query);
	}
	#| No Doc
	method status () {
		my $query = %();
		$ZapClient.request('ajaxSpider/view/status',$query);
	}
	#| Runs the spider against the given URL and/or context, optionally, spidering everything in scope. The parameter 'contextName' can be used to constrain the scan to a Context, the option 'in scope' is ignored if a context was also specified. The parameter 'subtreeOnly' allows to restrict the spider under a site's subtree (using the specified 'url').
	method scan (:$url, :$inScope, :$contextName, :$subtreeOnly) {
		my $query = %();
		$query<url> = $url if defined $url ;
		$query<inScope> = $inScope if defined $inScope ;
		$query<contextName> = $contextName if defined $contextName ;
		$query<subtreeOnly> = $subtreeOnly if defined $subtreeOnly ;
		$ZapClient.request('ajaxSpider/action/scan',$query);
	}
	#| Runs the spider from the perspective of a User, obtained using the given context name and user name. The parameter 'url' allows to specify the starting point for the spider, otherwise it's used an existing URL from the context (if any). The parameter 'subtreeOnly' allows to restrict the spider under a site's subtree (using the specified 'url').
	method scanAsUser (:$contextName!, :$userName!, :$url, :$subtreeOnly) {
		my $query = %(:$contextName, :$userName);
		$query<url> = $url if defined $url ;
		$query<subtreeOnly> = $subtreeOnly if defined $subtreeOnly ;
		$ZapClient.request('ajaxSpider/action/scanAsUser',$query);
	}
	#| No Doc
	method setOptionBrowserId (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('ajaxSpider/action/setOptionBrowserId',$query);
	}
	#| No Doc
	method setOptionClickDefaultElems (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ajaxSpider/action/setOptionClickDefaultElems',$query);
	}
	#| No Doc
	method setOptionClickElemsOnce (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ajaxSpider/action/setOptionClickElemsOnce',$query);
	}
	#| No Doc
	method setOptionEventWait (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ajaxSpider/action/setOptionEventWait',$query);
	}
	#| No Doc
	method setOptionMaxCrawlDepth (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ajaxSpider/action/setOptionMaxCrawlDepth',$query);
	}
	#| No Doc
	method setOptionMaxCrawlStates (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ajaxSpider/action/setOptionMaxCrawlStates',$query);
	}
	#| No Doc
	method setOptionMaxDuration (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ajaxSpider/action/setOptionMaxDuration',$query);
	}
	#| No Doc
	method setOptionNumberOfBrowsers (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ajaxSpider/action/setOptionNumberOfBrowsers',$query);
	}
	#| No Doc
	method setOptionRandomInputs (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('ajaxSpider/action/setOptionRandomInputs',$query);
	}
	#| No Doc
	method setOptionReloadWait (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('ajaxSpider/action/setOptionReloadWait',$query);
	}
	#| No Doc
	method stop () {
		my $query = %();
		$ZapClient.request('ajaxSpider/action/stop',$query);
	}

}#| class `Zap::Core` Methods 
our class Core {

	#| Gets number of alerts grouped by each risk level, optionally filtering by URL
	method alertsSummary (:$baseurl) {
		my $query = %();
		$query<baseurl> = $baseurl if defined $baseurl ;
		$ZapClient.request('core/view/alertsSummary',$query);
	}
	#| Gets the child nodes underneath the specified URL in the Sites tree
	method childNodes (:$url) {
		my $query = %();
		$query<url> = $url if defined $url ;
		$ZapClient.request('core/view/childNodes',$query);
	}
	#| Gets the regular expressions, applied to URLs, to exclude from the local proxies.
	method excludedFromProxy () {
		my $query = %();
		$ZapClient.request('core/view/excludedFromProxy',$query);
	}
	#| No Doc
	method homeDirectory () {
		my $query = %();
		$ZapClient.request('core/view/homeDirectory',$query);
	}
	#| Gets the name of the hosts accessed through/by ZAP
	method hosts () {
		my $query = %();
		$ZapClient.request('core/view/hosts',$query);
	}
	#| Gets the HTTP message with the given ID. Returns the ID, request/response headers and bodies, cookies, note, type, RTT, and timestamp.
	method message (:$id!) {
		my $query = %(:$id);
		$ZapClient.request('core/view/message',$query);
	}
	#| Gets the HTTP messages sent by ZAP, request and response, optionally filtered by URL and paginated with 'start' position and 'count' of messages
	method messages (:$baseurl, :$start, :$count) {
		my $query = %();
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('core/view/messages',$query);
	}
	#| Gets the HTTP messages with the given IDs.
	method messagesById (:$ids!) {
		my $query = %(:$ids);
		$ZapClient.request('core/view/messagesById',$query);
	}
	#| Gets the mode
	method mode () {
		my $query = %();
		$ZapClient.request('core/view/mode',$query);
	}
	#| Gets the number of alerts, optionally filtering by URL or riskId
	method numberOfAlerts (:$baseurl, :$riskId) {
		my $query = %();
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<riskId> = $riskId if defined $riskId ;
		$ZapClient.request('core/view/numberOfAlerts',$query);
	}
	#| Gets the number of messages, optionally filtering by URL
	method numberOfMessages (:$baseurl) {
		my $query = %();
		$query<baseurl> = $baseurl if defined $baseurl ;
		$ZapClient.request('core/view/numberOfMessages',$query);
	}
	#| Gets the path to the file with alert overrides.
	method optionAlertOverridesFilePath () {
		my $query = %();
		$ZapClient.request('core/view/optionAlertOverridesFilePath',$query);
	}
	#| Gets the user agent that ZAP should use when creating HTTP messages (for example, spider messages or CONNECT requests to outgoing proxy).
	method optionDefaultUserAgent () {
		my $query = %();
		$ZapClient.request('core/view/optionDefaultUserAgent',$query);
	}
	#| Gets the TTL (in seconds) of successful DNS queries.
	method optionDnsTtlSuccessfulQueries () {
		my $query = %();
		$ZapClient.request('core/view/optionDnsTtlSuccessfulQueries',$query);
	}
	#| No Doc
	method optionHttpState () {
		my $query = %();
		$ZapClient.request('core/view/optionHttpState',$query);
	}
	#| No Doc
	method optionHttpStateEnabled () {
		my $query = %();
		$ZapClient.request('core/view/optionHttpStateEnabled',$query);
	}
	#| Gets the maximum number of alert instances to include in a report.
	method optionMaximumAlertInstances () {
		my $query = %();
		$ZapClient.request('core/view/optionMaximumAlertInstances',$query);
	}
	#| Gets whether or not related alerts will be merged in any reports generated.
	method optionMergeRelatedAlerts () {
		my $query = %();
		$ZapClient.request('core/view/optionMergeRelatedAlerts',$query);
	}
	#| No Doc
	method optionProxyChainName () {
		my $query = %();
		$ZapClient.request('core/view/optionProxyChainName',$query);
	}
	#| No Doc
	method optionProxyChainPassword () {
		my $query = %();
		$ZapClient.request('core/view/optionProxyChainPassword',$query);
	}
	#| No Doc
	method optionProxyChainPort () {
		my $query = %();
		$ZapClient.request('core/view/optionProxyChainPort',$query);
	}
	#| No Doc
	method optionProxyChainPrompt () {
		my $query = %();
		$ZapClient.request('core/view/optionProxyChainPrompt',$query);
	}
	#| No Doc
	method optionProxyChainRealm () {
		my $query = %();
		$ZapClient.request('core/view/optionProxyChainRealm',$query);
	}
	#| Use view proxyChainExcludedDomains instead.
	method optionProxyChainSkipName () {
		my $query = %();
		$ZapClient.request('core/view/optionProxyChainSkipName',$query);
	}
	#| No Doc
	method optionProxyChainUserName () {
		my $query = %();
		$ZapClient.request('core/view/optionProxyChainUserName',$query);
	}
	#| Use view proxyChainExcludedDomains instead.
	method optionProxyExcludedDomains () {
		my $query = %();
		$ZapClient.request('core/view/optionProxyExcludedDomains',$query);
	}
	#| Use view proxyChainExcludedDomains instead.
	method optionProxyExcludedDomainsEnabled () {
		my $query = %();
		$ZapClient.request('core/view/optionProxyExcludedDomainsEnabled',$query);
	}
	#| No Doc
	method optionSingleCookieRequestHeader () {
		my $query = %();
		$ZapClient.request('core/view/optionSingleCookieRequestHeader',$query);
	}
	#| Gets the connection time out, in seconds.
	method optionTimeoutInSecs () {
		my $query = %();
		$ZapClient.request('core/view/optionTimeoutInSecs',$query);
	}
	#| No Doc
	method optionUseProxyChain () {
		my $query = %();
		$ZapClient.request('core/view/optionUseProxyChain',$query);
	}
	#| No Doc
	method optionUseProxyChainAuth () {
		my $query = %();
		$ZapClient.request('core/view/optionUseProxyChainAuth',$query);
	}
	#| Gets all the domains that are excluded from the outgoing proxy. For each domain the following are shown: the index, the value (domain), if enabled, and if specified as a regex.
	method proxyChainExcludedDomains () {
		my $query = %();
		$ZapClient.request('core/view/proxyChainExcludedDomains',$query);
	}
	#| Gets the location of the current session file
	method sessionLocation () {
		my $query = %();
		$ZapClient.request('core/view/sessionLocation',$query);
	}
	#| Gets the sites accessed through/by ZAP (scheme and domain)
	method sites () {
		my $query = %();
		$ZapClient.request('core/view/sites',$query);
	}
	#| Gets the URLs accessed through/by ZAP, optionally filtering by (base) URL.
	method urls (:$baseurl) {
		my $query = %();
		$query<baseurl> = $baseurl if defined $baseurl ;
		$ZapClient.request('core/view/urls',$query);
	}
	#| Gets ZAP version
	method version () {
		my $query = %();
		$ZapClient.request('core/view/version',$query);
	}
	#| Gets the path to ZAP's home directory.
	method zapHomePath () {
		my $query = %();
		$ZapClient.request('core/view/zapHomePath',$query);
	}
	#| Generates a report in HTML format
	method htmlreport () {
		my $query = %();
		$ZapClient.request('core/other/htmlreport',$query, :format<OTHER>);
	}
	#| Generates a report in JSON format
	method jsonreport () {
		my $query = %();
		$ZapClient.request('core/other/jsonreport',$query, :format<OTHER>);
	}
	#| Generates a report in Markdown format
	method mdreport () {
		my $query = %();
		$ZapClient.request('core/other/mdreport',$query, :format<OTHER>);
	}
	#| Gets the message with the given ID in HAR format
	method messageHar (:$id!) {
		my $query = %(:$id);
		$ZapClient.request('core/other/messageHar',$query, :format<OTHER>);
	}
	#| Gets the HTTP messages sent through/by ZAP, in HAR format, optionally filtered by URL and paginated with 'start' position and 'count' of messages
	method messagesHar (:$baseurl, :$start, :$count) {
		my $query = %();
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('core/other/messagesHar',$query, :format<OTHER>);
	}
	#| Gets the HTTP messages with the given IDs, in HAR format.
	method messagesHarById (:$ids!) {
		my $query = %(:$ids);
		$ZapClient.request('core/other/messagesHarById',$query, :format<OTHER>);
	}
	#| No Doc
	method proxypac () {
		my $query = %();
		$ZapClient.request('core/other/proxy.pac',$query, :format<OTHER>);
	}
	#| Gets the Root CA certificate used by the local proxies.
	method rootcert () {
		my $query = %();
		$ZapClient.request('core/other/rootcert',$query, :format<OTHER>);
	}
	#| Sends the first HAR request entry, optionally following redirections. Returns, in HAR format, the request sent and response received and followed redirections, if any. The Mode is enforced when sending the request (and following redirections), custom manual requests are not allowed in 'Safe' mode nor in 'Protected' mode if out of scope.
	method sendHarRequest (:$request!, :$followRedirects) {
		my $query = %(:$request);
		$query<followRedirects> = $followRedirects if defined $followRedirects ;
		$ZapClient.request('core/other/sendHarRequest',$query, :format<OTHER>);
	}
	#| No Doc
	method setproxy (:$proxy!) {
		my $query = %(:$proxy);
		$ZapClient.request('core/other/setproxy',$query, :format<OTHER>);
	}
	#| Generates a report in XML format
	method xmlreport () {
		my $query = %();
		$ZapClient.request('core/other/xmlreport',$query, :format<OTHER>);
	}
	#| Convenient and simple action to access a URL, optionally following redirections. Returns the request sent and response received and followed redirections, if any. Other actions are available which offer more control on what is sent, like, 'sendRequest' or 'sendHarRequest'.
	method accessUrl (:$url!, :$followRedirects) {
		my $query = %(:$url);
		$query<followRedirects> = $followRedirects if defined $followRedirects ;
		$ZapClient.request('core/action/accessUrl',$query);
	}
	#| Adds a domain to be excluded from the outgoing proxy, using the specified value. Optionally sets if the new entry is enabled (default, true) and whether or not the new value is specified as a regex (default, false).
	method addProxyChainExcludedDomain (:$value!, :$isRegex, :$isEnabled) {
		my $query = %(:$value);
		$query<isRegex> = $isRegex if defined $isRegex ;
		$query<isEnabled> = $isEnabled if defined $isEnabled ;
		$ZapClient.request('core/action/addProxyChainExcludedDomain',$query);
	}
	#| Clears the regexes of URLs excluded from the local proxies.
	method clearExcludedFromProxy () {
		my $query = %();
		$ZapClient.request('core/action/clearExcludedFromProxy',$query);
	}
	#| Deletes the alert with the given ID.
	method deleteAlert (:$id!) {
		my $query = %(:$id);
		$ZapClient.request('core/action/deleteAlert',$query);
	}
	#| Deletes all alerts of the current session.
	method deleteAllAlerts () {
		my $query = %();
		$ZapClient.request('core/action/deleteAllAlerts',$query);
	}
	#| Deletes the site node found in the Sites Tree on the basis of the URL, HTTP method, and post data (if applicable and specified).
	method deleteSiteNode (:$url!, :$method, :$postData) {
		my $query = %(:$url);
		$query<method> = $method if defined $method ;
		$query<postData> = $postData if defined $postData ;
		$ZapClient.request('core/action/deleteSiteNode',$query);
	}
	#| Disables all domains excluded from the outgoing proxy.
	method disableAllProxyChainExcludedDomains () {
		my $query = %();
		$ZapClient.request('core/action/disableAllProxyChainExcludedDomains',$query);
	}
	#| Disables the option for use of client certificates.
	method disableClientCertificate () {
		my $query = %();
		$ZapClient.request('core/action/disableClientCertificate',$query);
	}
	#| Enables all domains excluded from the outgoing proxy.
	method enableAllProxyChainExcludedDomains () {
		my $query = %();
		$ZapClient.request('core/action/enableAllProxyChainExcludedDomains',$query);
	}
	#| Enables use of a PKCS12 client certificate for the certificate with the given file system path, password, and optional index.
	method enablePKCS12ClientCertificate (:$filePath!, :$password!, :$index) {
		my $query = %(:$filePath, :$password);
		$query<index> = $index if defined $index ;
		$ZapClient.request('core/action/enablePKCS12ClientCertificate',$query);
	}
	#| Adds a regex of URLs that should be excluded from the local proxies.
	method excludeFromProxy (:$regex!) {
		my $query = %(:$regex);
		$ZapClient.request('core/action/excludeFromProxy',$query);
	}
	#| Generates a new Root CA certificate for the local proxies.
	method generateRootCA () {
		my $query = %();
		$ZapClient.request('core/action/generateRootCA',$query);
	}
	#| Loads the session with the given name. If a relative path is specified it will be resolved against the "session" directory in ZAP "home" dir.
	method loadSession (:$name!) {
		my $query = %(:$name);
		$ZapClient.request('core/action/loadSession',$query);
	}
	#| Modifies a domain excluded from the outgoing proxy. Allows to modify the value, if enabled or if a regex. The domain is selected with its index, which can be obtained with the view proxyChainExcludedDomains.
	method modifyProxyChainExcludedDomain (:$idx!, :$value, :$isRegex, :$isEnabled) {
		my $query = %(:$idx);
		$query<value> = $value if defined $value ;
		$query<isRegex> = $isRegex if defined $isRegex ;
		$query<isEnabled> = $isEnabled if defined $isEnabled ;
		$ZapClient.request('core/action/modifyProxyChainExcludedDomain',$query);
	}
	#| Creates a new session, optionally overwriting existing files. If a relative path is specified it will be resolved against the "session" directory in ZAP "home" dir.
	method newSession (:$name, :$overwrite) {
		my $query = %();
		$query<name> = $name if defined $name ;
		$query<overwrite> = $overwrite if defined $overwrite ;
		$ZapClient.request('core/action/newSession',$query);
	}
	#| Removes a domain excluded from the outgoing proxy, with the given index. The index can be obtained with the view proxyChainExcludedDomains.
	method removeProxyChainExcludedDomain (:$idx!) {
		my $query = %(:$idx);
		$ZapClient.request('core/action/removeProxyChainExcludedDomain',$query);
	}
	#| No Doc
	method runGarbageCollection () {
		my $query = %();
		$ZapClient.request('core/action/runGarbageCollection',$query);
	}
	#| Saves the session.
	method saveSession (:$name!, :$overwrite) {
		my $query = %(:$name);
		$query<overwrite> = $overwrite if defined $overwrite ;
		$ZapClient.request('core/action/saveSession',$query);
	}
	#| Sends the HTTP request, optionally following redirections. Returns the request sent and response received and followed redirections, if any. The Mode is enforced when sending the request (and following redirections), custom manual requests are not allowed in 'Safe' mode nor in 'Protected' mode if out of scope.
	method sendRequest (:$request!, :$followRedirects) {
		my $query = %(:$request);
		$query<followRedirects> = $followRedirects if defined $followRedirects ;
		$ZapClient.request('core/action/sendRequest',$query);
	}
	#| No Doc
	method setHomeDirectory (:$dir!) {
		my $query = %(:$dir);
		$ZapClient.request('core/action/setHomeDirectory',$query);
	}
	#| Sets the mode, which may be one of [safe, protect, standard, attack]
	method setMode (:$mode!) {
		my $query = %(:$mode);
		$ZapClient.request('core/action/setMode',$query);
	}
	#| Sets (or clears, if empty) the path to the file with alert overrides.
	method setOptionAlertOverridesFilePath (:$filePath) {
		my $query = %();
		$query<filePath> = $filePath if defined $filePath ;
		$ZapClient.request('core/action/setOptionAlertOverridesFilePath',$query);
	}
	#| Sets the user agent that ZAP should use when creating HTTP messages (for example, spider messages or CONNECT requests to outgoing proxy).
	method setOptionDefaultUserAgent (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('core/action/setOptionDefaultUserAgent',$query);
	}
	#| Sets the TTL (in seconds) of successful DNS queries (applies after ZAP restart).
	method setOptionDnsTtlSuccessfulQueries (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('core/action/setOptionDnsTtlSuccessfulQueries',$query);
	}
	#| No Doc
	method setOptionHttpStateEnabled (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('core/action/setOptionHttpStateEnabled',$query);
	}
	#| Sets the maximum number of alert instances to include in a report. A value of zero is treated as unlimited.
	method setOptionMaximumAlertInstances (:$numberOfInstances!) {
		my $query = %(:$numberOfInstances);
		$ZapClient.request('core/action/setOptionMaximumAlertInstances',$query);
	}
	#| Sets whether or not related alerts will be merged in any reports generated.
	method setOptionMergeRelatedAlerts (:$enabled!) {
		my $query = %(:$enabled);
		$ZapClient.request('core/action/setOptionMergeRelatedAlerts',$query);
	}
	#| No Doc
	method setOptionProxyChainName (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('core/action/setOptionProxyChainName',$query);
	}
	#| No Doc
	method setOptionProxyChainPassword (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('core/action/setOptionProxyChainPassword',$query);
	}
	#| No Doc
	method setOptionProxyChainPort (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('core/action/setOptionProxyChainPort',$query);
	}
	#| No Doc
	method setOptionProxyChainPrompt (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('core/action/setOptionProxyChainPrompt',$query);
	}
	#| No Doc
	method setOptionProxyChainRealm (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('core/action/setOptionProxyChainRealm',$query);
	}
	#| Use actions [add|modify|remove]ProxyChainExcludedDomain instead.
	method setOptionProxyChainSkipName (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('core/action/setOptionProxyChainSkipName',$query);
	}
	#| No Doc
	method setOptionProxyChainUserName (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('core/action/setOptionProxyChainUserName',$query);
	}
	#| No Doc
	method setOptionSingleCookieRequestHeader (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('core/action/setOptionSingleCookieRequestHeader',$query);
	}
	#| Sets the connection time out, in seconds.
	method setOptionTimeoutInSecs (:$Integer!) {
		my $query = %(:$Integer);
		$ZapClient.request('core/action/setOptionTimeoutInSecs',$query);
	}
	#| Sets whether or not the outgoing proxy should be used. The address/hostname of the outgoing proxy must be set to enable this option.
	method setOptionUseProxyChain (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('core/action/setOptionUseProxyChain',$query);
	}
	#| No Doc
	method setOptionUseProxyChainAuth (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('core/action/setOptionUseProxyChainAuth',$query);
	}
	#| Shuts down ZAP
	method shutdown () {
		my $query = %();
		$ZapClient.request('core/action/shutdown',$query);
	}
	#| Snapshots the session, optionally with the given name, and overwriting existing files. If no name is specified the name of the current session with a timestamp appended is used. If a relative path is specified it will be resolved against the "session" directory in ZAP "home" dir.
	method snapshotSession (:$name, :$overwrite) {
		my $query = %();
		$query<name> = $name if defined $name ;
		$query<overwrite> = $overwrite if defined $overwrite ;
		$ZapClient.request('core/action/snapshotSession',$query);
	}

}#| class `Zap::Users` Methods 
our class Users {

	#| Creates a new user with the given name for the context with the given ID.
	method newUser (:$contextId!, :$name!) {
		my $query = %(:$contextId, :$name);
		$ZapClient.request('users/action/newUser',$query);
	}
	#| Removes the user with the given ID that belongs to the context with the given ID.
	method removeUser (:$contextId!, :$userId!) {
		my $query = %(:$contextId, :$userId);
		$ZapClient.request('users/action/removeUser',$query);
	}
	#| Sets the authentication credentials for the user with the given ID that belongs to the context with the given ID.
	method setAuthenticationCredentials (:$contextId!, :$userId!, :$authCredentialsConfigParams) {
		my $query = %(:$contextId, :$userId);
		$query<authCredentialsConfigParams> = $authCredentialsConfigParams if defined $authCredentialsConfigParams ;
		$ZapClient.request('users/action/setAuthenticationCredentials',$query);
	}
	#| Sets whether or not the user, with the given ID that belongs to the context with the given ID, should be enabled.
	method setUserEnabled (:$contextId!, :$userId!, :$enabled!) {
		my $query = %(:$contextId, :$userId, :$enabled);
		$ZapClient.request('users/action/setUserEnabled',$query);
	}
	#| Renames the user with the given ID that belongs to the context with the given ID.
	method setUserName (:$contextId!, :$userId!, :$name!) {
		my $query = %(:$contextId, :$userId, :$name);
		$ZapClient.request('users/action/setUserName',$query);
	}
	#| Gets the data of the user with the given ID that belongs to the context with the given ID.
	method getUserById (:$contextId!, :$userId!) {
		my $query = %(:$contextId, :$userId);
		$ZapClient.request('users/view/getUserById',$query);
	}
	#| Gets a list of users that belong to the context with the given ID, or all users if none provided.
	method usersList (:$contextId) {
		my $query = %();
		$query<contextId> = $contextId if defined $contextId ;
		$ZapClient.request('users/view/usersList',$query);
	}

}#| class `Zap::Acsrf` Methods 
our class Acsrf {

	#| Removes the anti-CSRF token with the given name
	method removeOptionToken (:$String!) {
		my $query = %(:$String);
		$ZapClient.request('acsrf/action/removeOptionToken',$query);
	}
	#| Generate a form for testing lack of anti-CSRF tokens - typically invoked via ZAP
	method genForm (:$hrefId!) {
		my $query = %(:$hrefId);
		$ZapClient.request('acsrf/other/genForm',$query, :format<OTHER>);
	}

}#| class `Zap::Search` Methods 
our class Search {

	#| Returns the HTTP messages, in HAR format, that match the given regular expression in the header(s) optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method harByHeaderRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/other/harByHeaderRegex',$query, :format<OTHER>);
	}
	#| Returns the HTTP messages, in HAR format, that match the given regular expression in the request optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method harByRequestRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/other/harByRequestRegex',$query, :format<OTHER>);
	}
	#| Returns the HTTP messages, in HAR format, that match the given regular expression in the response optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method harByResponseRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/other/harByResponseRegex',$query, :format<OTHER>);
	}
	#| Returns the HTTP messages, in HAR format, that match the given regular expression in the URL optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method harByUrlRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/other/harByUrlRegex',$query, :format<OTHER>);
	}
	#| Returns the HTTP messages that match the given regular expression in the response optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method messagesByResponseRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/view/messagesByResponseRegex',$query);
	}
	#| Returns the HTTP messages that match the given regular expression in the URL optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method messagesByUrlRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/view/messagesByUrlRegex',$query);
	}
	#| Returns the URLs of the HTTP messages that match the given regular expression in the header(s) optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method urlsByHeaderRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/view/urlsByHeaderRegex',$query);
	}
	#| Returns the URLs of the HTTP messages that match the given regular expression in the request optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method urlsByRequestRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/view/urlsByRequestRegex',$query);
	}
	#| Returns the URLs of the HTTP messages that match the given regular expression in the response optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method urlsByResponseRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/view/urlsByResponseRegex',$query);
	}
	#| Returns the URLs of the HTTP messages that match the given regular expression in the URL optionally filtered by URL and paginated with 'start' position and 'count' of messages.
	method urlsByUrlRegex (:$regex!, :$baseurl, :$start, :$count) {
		my $query = %(:$regex);
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$ZapClient.request('search/view/urlsByUrlRegex',$query);
	}

}#| class `Zap::Replacer` Methods 
our class Replacer {

	#| Removes the rule with the given description
	method removeRule (:$description!) {
		my $query = %(:$description);
		$ZapClient.request('replacer/action/removeRule',$query);
	}
	#| Enables or disables the rule with the given description based on the bool parameter
	method setEnabled (:$description!, :$bool!) {
		my $query = %(:$description, :$bool);
		$ZapClient.request('replacer/action/setEnabled',$query);
	}

}#| class `Zap::Context` Methods 
our class Context {

	#| Excludes all built in technologies from a context
	method excludeAllContextTechnologies (:$contextName!) {
		my $query = %(:$contextName);
		$ZapClient.request('context/action/excludeAllContextTechnologies',$query);
	}
	#| Excludes technologies with the given names, separated by a comma, from a context
	method excludeContextTechnologies (:$contextName!, :$technologyNames!) {
		my $query = %(:$contextName, :$technologyNames);
		$ZapClient.request('context/action/excludeContextTechnologies',$query);
	}
	#| Add exclude regex to context
	method excludeFromContext (:$contextName!, :$regex!) {
		my $query = %(:$contextName, :$regex);
		$ZapClient.request('context/action/excludeFromContext',$query);
	}
	#| Exports the context with the given name to a file. If a relative file path is specified it will be resolved against the "contexts" directory in ZAP "home" dir.
	method exportContext (:$contextName!, :$contextFile!) {
		my $query = %(:$contextName, :$contextFile);
		$ZapClient.request('context/action/exportContext',$query);
	}
	#| Imports a context from a file. If a relative file path is specified it will be resolved against the "contexts" directory in ZAP "home" dir.
	method importContext (:$contextFile!) {
		my $query = %(:$contextFile);
		$ZapClient.request('context/action/importContext',$query);
	}
	#| Includes all built in technologies in to a context
	method includeAllContextTechnologies (:$contextName!) {
		my $query = %(:$contextName);
		$ZapClient.request('context/action/includeAllContextTechnologies',$query);
	}
	#| Includes technologies with the given names, separated by a comma, to a context
	method includeContextTechnologies (:$contextName!, :$technologyNames!) {
		my $query = %(:$contextName, :$technologyNames);
		$ZapClient.request('context/action/includeContextTechnologies',$query);
	}
	#| Add include regex to context
	method includeInContext (:$contextName!, :$regex!) {
		my $query = %(:$contextName, :$regex);
		$ZapClient.request('context/action/includeInContext',$query);
	}
	#| Creates a new context with the given name in the current session
	method newContext (:$contextName!) {
		my $query = %(:$contextName);
		$ZapClient.request('context/action/newContext',$query);
	}
	#| Removes a context in the current session
	method removeContext (:$contextName!) {
		my $query = %(:$contextName);
		$ZapClient.request('context/action/removeContext',$query);
	}
	#| Sets a context to in scope (contexts are in scope by default)
	method setContextInScope (:$contextName!, :$booleanInScope!) {
		my $query = %(:$contextName, :$booleanInScope);
		$ZapClient.request('context/action/setContextInScope',$query);
	}
	#| Set the regexs to include and exclude for a context, both supplied as JSON string arrays
	method setContextRegexs (:$contextName!, :$incRegexs!, :$excRegexs!) {
		my $query = %(:$contextName, :$incRegexs, :$excRegexs);
		$ZapClient.request('context/action/setContextRegexs',$query);
	}
	#| List excluded regexs for context
	method excludeRegexs (:$contextName!) {
		my $query = %(:$contextName);
		$ZapClient.request('context/view/excludeRegexs',$query);
	}
	#| Lists the names of all technologies excluded from a context
	method excludedTechnologyList (:$contextName!) {
		my $query = %(:$contextName);
		$ZapClient.request('context/view/excludedTechnologyList',$query);
	}
	#| List included regexs for context
	method includeRegexs (:$contextName!) {
		my $query = %(:$contextName);
		$ZapClient.request('context/view/includeRegexs',$query);
	}
	#| Lists the names of all technologies included in a context
	method includedTechnologyList (:$contextName!) {
		my $query = %(:$contextName);
		$ZapClient.request('context/view/includedTechnologyList',$query);
	}
	#| Lists the names of all built in technologies
	method technologyList () {
		my $query = %();
		$ZapClient.request('context/view/technologyList',$query);
	}
	#| Lists the URLs accessed through/by ZAP, that belong to the context with the given name.
	method urls (:$contextName!) {
		my $query = %(:$contextName);
		$ZapClient.request('context/view/urls',$query);
	}

}#| class `Zap::Autoupdate` Methods 
our class Autoupdate {

	#| Downloads the latest release, if any
	method downloadLatestRelease () {
		my $query = %();
		$ZapClient.request('autoupdate/action/downloadLatestRelease',$query);
	}
	#| Installs or updates the specified add-on, returning when complete (i.e. not asynchronously)
	method installAddon (:$id!) {
		my $query = %(:$id);
		$ZapClient.request('autoupdate/action/installAddon',$query);
	}
	#| No Doc
	method setOptionCheckAddonUpdates (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('autoupdate/action/setOptionCheckAddonUpdates',$query);
	}
	#| No Doc
	method setOptionCheckOnStart (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('autoupdate/action/setOptionCheckOnStart',$query);
	}
	#| No Doc
	method setOptionDownloadNewRelease (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('autoupdate/action/setOptionDownloadNewRelease',$query);
	}
	#| No Doc
	method setOptionInstallAddonUpdates (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('autoupdate/action/setOptionInstallAddonUpdates',$query);
	}
	#| No Doc
	method setOptionInstallScannerRules (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('autoupdate/action/setOptionInstallScannerRules',$query);
	}
	#| No Doc
	method setOptionReportAlphaAddons (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('autoupdate/action/setOptionReportAlphaAddons',$query);
	}
	#| No Doc
	method setOptionReportBetaAddons (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('autoupdate/action/setOptionReportBetaAddons',$query);
	}
	#| No Doc
	method setOptionReportReleaseAddons (:$Boolean!) {
		my $query = %(:$Boolean);
		$ZapClient.request('autoupdate/action/setOptionReportReleaseAddons',$query);
	}
	#| Uninstalls the specified add-on
	method uninstallAddon (:$id!) {
		my $query = %(:$id);
		$ZapClient.request('autoupdate/action/uninstallAddon',$query);
	}
	#| Returns the latest version number
	method latestVersionNumber () {
		my $query = %();
		$ZapClient.request('autoupdate/view/latestVersionNumber',$query);
	}
	#| Returns a list with all local add-ons, installed or not.
	method localAddons () {
		my $query = %();
		$ZapClient.request('autoupdate/view/localAddons',$query);
	}
	#| Return a list of all of the add-ons on the ZAP Marketplace (this information is read once and then cached)
	method marketplaceAddons () {
		my $query = %();
		$ZapClient.request('autoupdate/view/marketplaceAddons',$query);
	}
	#| Return a list of any add-ons that have been added to the Marketplace since the last check for updates
	method newAddons () {
		my $query = %();
		$ZapClient.request('autoupdate/view/newAddons',$query);
	}
	#| No Doc
	method optionAddonDirectories () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionAddonDirectories',$query);
	}
	#| No Doc
	method optionCheckAddonUpdates () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionCheckAddonUpdates',$query);
	}
	#| No Doc
	method optionCheckOnStart () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionCheckOnStart',$query);
	}
	#| No Doc
	method optionDayLastChecked () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionDayLastChecked',$query);
	}
	#| No Doc
	method optionDayLastInstallWarned () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionDayLastInstallWarned',$query);
	}
	#| No Doc
	method optionDayLastUpdateWarned () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionDayLastUpdateWarned',$query);
	}
	#| No Doc
	method optionDownloadDirectory () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionDownloadDirectory',$query);
	}
	#| No Doc
	method optionDownloadNewRelease () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionDownloadNewRelease',$query);
	}
	#| No Doc
	method optionInstallAddonUpdates () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionInstallAddonUpdates',$query);
	}
	#| No Doc
	method optionInstallScannerRules () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionInstallScannerRules',$query);
	}
	#| No Doc
	method optionReportAlphaAddons () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionReportAlphaAddons',$query);
	}
	#| No Doc
	method optionReportBetaAddons () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionReportBetaAddons',$query);
	}
	#| No Doc
	method optionReportReleaseAddons () {
		my $query = %();
		$ZapClient.request('autoupdate/view/optionReportReleaseAddons',$query);
	}
	#| Return a list of any add-ons that have been changed in the Marketplace since the last check for updates
	method updatedAddons () {
		my $query = %();
		$ZapClient.request('autoupdate/view/updatedAddons',$query);
	}

}#| class `Zap::Alert` Methods 
our class Alert {

	#| Add an alert associated with the given message ID, with the provided details. (The ID of the created alert is returned.)
	method addAlert (:$messageId!, :$name!, :$riskId!, :$confidenceId!, :$description!, :$param, :$attack, :$otherInfo, :$solution, :$references, :$evidence, :$cweId, :$wascId) {
		my $query = %(:$messageId, :$name, :$riskId, :$confidenceId, :$description);
		$query<param> = $param if defined $param ;
		$query<attack> = $attack if defined $attack ;
		$query<otherInfo> = $otherInfo if defined $otherInfo ;
		$query<solution> = $solution if defined $solution ;
		$query<references> = $references if defined $references ;
		$query<evidence> = $evidence if defined $evidence ;
		$query<cweId> = $cweId if defined $cweId ;
		$query<wascId> = $wascId if defined $wascId ;
		$ZapClient.request('alert/action/addAlert',$query);
	}
	#| Deletes the alert with the given ID.
	method deleteAlert (:$id!) {
		my $query = %(:$id);
		$ZapClient.request('alert/action/deleteAlert',$query);
	}
	#| Deletes all alerts of the current session.
	method deleteAllAlerts () {
		my $query = %();
		$ZapClient.request('alert/action/deleteAllAlerts',$query);
	}
	#| Update the alert with the given ID, with the provided details.
	method updateAlert (:$id!, :$name!, :$riskId!, :$confidenceId!, :$description!, :$param, :$attack, :$otherInfo, :$solution, :$references, :$evidence, :$cweId, :$wascId) {
		my $query = %(:$id, :$name, :$riskId, :$confidenceId, :$description);
		$query<param> = $param if defined $param ;
		$query<attack> = $attack if defined $attack ;
		$query<otherInfo> = $otherInfo if defined $otherInfo ;
		$query<solution> = $solution if defined $solution ;
		$query<references> = $references if defined $references ;
		$query<evidence> = $evidence if defined $evidence ;
		$query<cweId> = $cweId if defined $cweId ;
		$query<wascId> = $wascId if defined $wascId ;
		$ZapClient.request('alert/action/updateAlert',$query);
	}
	#| Gets the alerts raised by ZAP, optionally filtering by URL or riskId, and paginating with 'start' position and 'count' of alerts
	method alerts (:$baseurl, :$start, :$count, :$riskId) {
		my $query = %();
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<start> = $start if defined $start ;
		$query<count> = $count if defined $count ;
		$query<riskId> = $riskId if defined $riskId ;
		$ZapClient.request('alert/view/alerts',$query);
	}
	#| Gets a summary of the alerts, optionally filtered by a 'url'. If 'recurse' is true then all alerts that apply to urls that start with the specified 'url' will be returned, otherwise only those on exactly the same 'url' (ignoring url parameters)
	method alertsByRisk (:$url, :$recurse) {
		my $query = %();
		$query<url> = $url if defined $url ;
		$query<recurse> = $recurse if defined $recurse ;
		$ZapClient.request('alert/view/alertsByRisk',$query);
	}
	#| Gets number of alerts grouped by each risk level, optionally filtering by URL
	method alertsSummary (:$baseurl) {
		my $query = %();
		$query<baseurl> = $baseurl if defined $baseurl ;
		$ZapClient.request('alert/view/alertsSummary',$query);
	}
	#| Gets the number of alerts, optionally filtering by URL or riskId
	method numberOfAlerts (:$baseurl, :$riskId) {
		my $query = %();
		$query<baseurl> = $baseurl if defined $baseurl ;
		$query<riskId> = $riskId if defined $riskId ;
		$ZapClient.request('alert/view/numberOfAlerts',$query);
	}

}
