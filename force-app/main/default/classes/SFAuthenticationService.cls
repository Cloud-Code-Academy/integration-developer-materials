/**
 * Service class to handle authentication to external Salesforce org
 */
public class SFAuthenticationService {
	// Constants for authentication
	private static final String AUTH_ENDPOINT = '/services/oauth2/token';

	// Grant types
	private static final String GRANT_TYPE_PASSWORD = 'password';
	private static final String GRANT_TYPE_CLIENT_CREDENTIALS = 'client_credentials';

	// Authentication configuration
	private static final String CLIENT_ID = '3MVG9fJfMmi0N395KrSUGhA18iw6M3VCHm2yhrb6hgG4s_orxrx9xCUpG.bjJAEo72LIv5BwggyE0qo062gi3';
	private static final String CLIENT_SECRET = 'C8C88BC5B9EEC9446D22DFD55E863F29FBD490E558D57131934BF198A8672E7A';
	private static final String USERNAME = 'test-r8ytekdysqke@example.com';
	private static final String PASSWORD = 'o]fwt1dGiywev';
	private static final String SECURITY_TOKEN = 'C26VDSSLllZq3Ze02RTtL1rK';
	private static final String INSTANCE_URL = 'https://innovation-drive-5293-dev-ed.scratch.my.salesforce.com';

	/**
	 * Gets authentication token using the specified OAuth flow
	 * @param method Authentication method to use
	 * @return Authentication response containing access token and instance URL
	 */
	public static AuthResponse authenticate(String grantType) {
		// Select appropriate grant type and build request body based on method
		String requestBody;
		if (grantType == GRANT_TYPE_PASSWORD) {
			requestBody =
				'grant_type=' +
				GRANT_TYPE_PASSWORD +
				'&client_id=' +
				CLIENT_ID +
				'&client_secret=' +
				CLIENT_SECRET +
				'&username=' +
				USERNAME +
				'&password=' +
				PASSWORD +
				SECURITY_TOKEN;
		} else if (grantType == GRANT_TYPE_CLIENT_CREDENTIALS) {
			requestBody =
				'grant_type=' +
				GRANT_TYPE_CLIENT_CREDENTIALS +
				'&client_id=' +
				CLIENT_ID +
				'&client_secret=' +
				CLIENT_SECRET;
		}

		// Make the authentication request
		return makeAuthRequest(requestBody);
	}

	/**
	 * Makes the HTTP request for authentication
	 * @param requestBody The OAuth parameters as a URL-encoded string
	 * @return Authentication response containing access token and instance URL
	 */
	private static AuthResponse makeAuthRequest(String requestBody) {
		// Create HTTP request
		HttpRequest req = new HttpRequest();
		req.setEndpoint(INSTANCE_URL + AUTH_ENDPOINT);
		req.setMethod('POST');
		req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		req.setBody(requestBody);

		// Send request
		Http http = new Http();
		HttpResponse res;

		try {
			res = http.send(req);

			// Parse JSON response
			if (res.getStatusCode() == 200) {
				Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
					res.getBody()
				);

				AuthResponse authResponse = new AuthResponse();
				authResponse.accessToken = (String) responseMap.get('access_token');
				authResponse.instanceUrl = (String) responseMap.get('instance_url');
				authResponse.isSuccess = true;

				return authResponse;
			} else {
				System.debug(
					'Error authenticating: ' + res.getStatusCode() + ' ' + res.getStatus()
				);
				System.debug('Response body: ' + res.getBody());

				AuthResponse errorResponse = new AuthResponse();
				errorResponse.isSuccess = false;
				errorResponse.errorMessage =
					'Authentication failed: ' +
					res.getStatus() +
					' - ' +
					res.getBody();

				return errorResponse;
			}
		} catch (Exception e) {
			System.debug('Exception during authentication: ' + e.getMessage());

			AuthResponse errorResponse = new AuthResponse();
			errorResponse.isSuccess = false;
			errorResponse.errorMessage = 'Exception: ' + e.getMessage();

			return errorResponse;
		}
	}

	/**
	 * Class to encapsulate authentication response
	 */
	public class AuthResponse {
		public Boolean isSuccess;
		public String accessToken;
		public String instanceUrl;
		public String errorMessage;
	}
}
