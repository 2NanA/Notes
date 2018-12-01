# Basic Class Defination
## Files
Path: `core\sys\libs\webservice_base\`

+ <b>autoloader.php</b>
+ TKESoapClient.php
+ TKESoapServer.php
+ WebServiceResourceDeclaration.php
+ ServiceConsumer.php
+ ServiceProvider.php
+ AuthenticationHelper.php
+ DefaultMessageHandlerAdapter.php
+ MessageHandler.php
+ ExternalAccessLogger.php
+ ExternalAccessLoggerDao.php
+ exceptions
    + AuthenticationFailedException.php
    + IllegalException.php


```mind
-Webservice
    -autoloader[color=red]
    -WebServiceResourceDeclaration[color=#111]
        -ServiceConsumer
        -ServiceProvider
    -AuthenticationHelper
        -ini config file
    -exceptions
        -AuthenticationFailedException
        -IllegalException
    -Log
        -DefaultMessageHandlerAdapter
            -MessageHandler
        -ExternalAccessLogger
        -ExternalAccessLoggerDao
```

```mind
-ServiceConsumer
    -TKESoapClient(__call)
        -SoapClient
            -AuthenticationHelper
        -Log
```

```mind
-ServiceProvider
    -TKESoapServer(__call)
        -SoapServer
            -SoapServiceSecurity(__call)
                -AuthenticationHelper
                -Log
```

###  autoloader
File: autoloader.php
Autoloader of this library. Require this file, it will automatically load all classes of this library.
```
require_once("/path/to/sys/libs/webservice_base/autoloader.php");
``` 

###  WebServiceResourceDeclaration
+ DB (global, write and read) abstraction.
+ Get WSDL file.
+ Account Authentication config.
+ Get function dir.
+ Get function name.

####  ServiceConsumer
With a TKESoapClient instance to send request.

####  ServiceProvider
With a TKESoapServer instance to receive request.

###  TKESoapClient
Set wsdl file.
Set options.
Connection Authentication.
With a SoapClient instance.

###  TKESoapServer & SoapServiceSecurity
#### TKESoapServer
Set wsdl file.
Set options.
Set function name, conduct-class name, methods list, need-responce.
Receive request: With a `SoapServer-instance`.
Format request infomation and keep a log: With a MessageHandler instance.

#### SoapServiceSecurity
Validate the request received: Connection Authentication. SoapServiceSecurity is the directly class of the `SoapServer-instance`, and the `SoapServiceSecurity` is the proxy class of the `TKESoapServer`.

###  Authentication
File: AuthenticationHelper.php
Load account config file from `BASE_DIR . '/.webservice.authentication.ini'`.

###  Log
File: 
+ DefaultMessageHandlerAdapter.php & MessageHandler.php
+ ExternalAccessLogger.php & ExternalAccessLoggerDao.php
Handle request message.
Log model. Save log to database.

###  Exceptions
#### AuthenticationFailedException
Authentication-Failed exception defination.

####  IllegalException
Illegal exception defination.
For example: fields illegal;

# Usage
## File Path
Path: `core\web\webservicedelegator\`.
Create a folder, use the functionality name as the file name. For example `func_a`.
In this folder, create folder `provider`  as the soap-server module, `consumer` as the soap-client module.

## Consumer
1. Require init.lib.
1. Require webservice_base autoloader.
1. Create a class extends `ServiceConsumer`.
```php
class FuncAContractConsumer extends ServiceConsumer {}
```

1. todo DefaultMessageHandlerAdapter.

```php
class FuncAContractConsumer extends ServiceConsumer {

    protected function getRelativeWsdlFileName() {
        return 'FuncA_V1.0';
    }
    
    protected function getFunctionName() {
        return 'FuncA';
    }

    protected function getCustomizedOptions() {
    }

    public function methodOne() {
        return 0;
    }
    
    public function oaSalesDocumentCreateRequest() {
        global $sapinfo;
        $this->getClient()->oaSalesDocumentCreateRequest($sapinfo, 
            new class($this) extends DefaultMessageHandlerAdapter {
                private $consumer;
                public function __construct($consumer) {
                    $this->consumer = $consumer;
                }
            
                public function getIsSynced() {return $this->consumer->getTest();}

                public function getIdentifier() {return '123';}

                public function getCustomizedRequestFields($request) {
                    return 'request123';
                }
                
                public function getCustomizedResponseFields($response) {
                    return 'response123';
                }
            });
        $this->getClient()->printTrace();
    }
}
```

1. When send the request, require this comsumer file and call the responding method.

```php
require 'path/to/core/web/webservicedelegator/paidcontract/consumer/FuncAConsumer.php';

$test = new FuncAConsumer();
$test->method();
```

## Provider

1. Require init.lib.
1. Require webservice_base autoloader.
1. Create a class extends `ServiceProvider`.
e.g.
```php
class FuncAProvider extends ServiceProvider {}
```

1. Set the wsdl file setting and the function name, and other defination of this interface.
e.g.
```php
class FuncAProvider extends ServiceProvider {

    protected function getRelativeWsdlFileName() {
        return 'FuncAService_V1.0';
    }

    protected function getFunctionName() {
        return 'FuncA';
    }

    protected function getCustomizedOptions() {
    }

    protected function isOneWay() {
        return false;
    }

    protected function skipAuth() {
        return true;
    }
}
```

1. Add methods according to the wsdl file.
e.g.
```php
class FuncAProvider extends ServiceProvider {

    protected function getRelativeWsdlFileName() {
        return 'FuncAService_V1.0';
    }

    protected function getFunctionName() {
        return 'FuncA';
    }

    protected function getCustomizedOptions() {
    }

    protected function isOneWay() {
        return false;
    }

    protected function skipAuth() {
        return true;
    }

    public function methodOne($params)
    {
        $ret = getRet($params);
        return $ret;
    }
}
```

# ShortCut