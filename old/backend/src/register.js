import {
  CognitoIdentityProviderClient
} from "@aws-sdk/client-cognito-identity-provider";
//const AWS = require('aws-sdk');
AWS.config.update({
    region: 'eu-west-1',
});

const cognito = new CognitoIdentityProviderClient();

function registerUser() {
    const email = document.getElementById('emailInput').value;
    const password = document.getElementById('passwordInput').value;

    const params = {
        ClientId: '7ln0ka4km14h9chmp17kdg7m5f', // Ваш Cognito App Client ID
        Username: email,
        Password: password,
        UserAttributes: [
            {
                Name: 'email',
                Value: email
            }
        ]
    };

    cognito.signUp(params, function(err, data) {
        if (err) {
            console.error(err);
            return;
        }
        console.log('User registration successful:', data);

    });
}
