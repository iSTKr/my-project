const AWS = require('aws-sdk');
AWS.config.update({
    region: 'eu-west-1',
});

const cognito = new AWS.CognitoIdentityServiceProvider();

function loginUser() {
    var authenticationData = {
        Username : 'email',
        Password : 'password',
    };
    var authenticationDetails = new cognito.AuthenticationDetails(authenticationData);

    var userData = {
        Username : 'email',
        Pool : userPool
    };
    var cognitoUser = new cognito.CognitoUser(userData);

    cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: function (result) {
            var accessToken = result.getAccessToken().getJwtToken();
            // Тут можна виконати дії після успішного входу
        },

        onFailure: function(err) {
            alert(err.message || JSON.stringify(err));
        },
    });
}
