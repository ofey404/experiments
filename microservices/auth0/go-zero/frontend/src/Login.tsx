import React from 'react';
import {useAuth0} from '@auth0/auth0-react';

function LoginButton() {
    const {
        isAuthenticated,
        loginWithRedirect,
    } = useAuth0();

    return (
        <button onClick={() => {
            loginWithRedirect({
                    authorizationParams: {
                        redirect_uri: 'http://localhost:3000/'
                    }
                }
            )
        }}>Log in</button>
    );
}

export default LoginButton;