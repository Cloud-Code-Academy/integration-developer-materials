//System.debug(SFAuthenticationService.authenticate('password'));

SFExternalCalloutService.grantType = 'client_credentials';
System.debug(SFExternalCalloutService.getLimits());
System.debug(SFExternalCalloutService.createAccount('SFExternalCalloutService'));
