// *************************************************************************
// Copyright (c) 2014-2017, SUSE LLC
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
//
// 3. Neither the name of SUSE LLC nor the names of its contributors may be
// used to endorse or promote products derived from this software without
// specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
// *************************************************************************
//
// root.js
//
// entry point of application, whether for actual use or functional testing
//
// displays the application frame in the browser window or QUnit fixture,
// determines user and privlevel, initializes targets, and loads the main menu
//

"use strict";

define ([
    'jquery',
    'cf',
    'current-user',
    'html', 
    'login-dialog',
    'stack',
    'app/target-init',
], function (
    $,
    cf,
    currentUser,
    html, 
    loginDialog,
    stack,
    targetInit,
) {

    return function () {

        var cu,
            priv;

        // In functional testing, test cases run in sequence. Since tests can
        // fail, the initial state of the target stack is unknown.
        stack.resetStack();

        if ( cf('testing') ) {
            $('#qunit-fixture').append(html.body());
        } else {
            $(document.body).html(html.body());
        }

        cu = currentUser('obj');
        console.log("root: current user object:", cu);
        priv = currentUser('priv');
        console.log("root: current user priv:", priv);
        if ( cu.eid && priv ) {
            console.log("Initializing targets");
            targetInit();
        } else {
            console.log("Initiating login dialog");
            loginDialog();
        }
    
        return null;

    }

});

