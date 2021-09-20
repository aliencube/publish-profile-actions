# Azure Web/Functions App Publish Profile Actions #

This is a GitHub Actions that retrieves or resets the publish profile of Azure Web App or Functions App in XML format.


## Inputs ##

* `AZURE_CREDENTIALS` (**Required**): Environment variable. Azure credentials for a service principal.
* `resourceGroupName` (**Required**): Resource group name.
* `appName` (**Required**): App instance name.
* `reset`: Value indicating whether to reset the publish profile or not. If omitted, it's defaulted to `false`.
* `subscriptionId`: Azure Subscription Id for the App instance. If omitted, it's defaulted to `''`.


## Outputs ##

* `profile`: Publish profile in XML. **NOTE**: If the `reset` parameter is set to `true`, the output value will be empty.


## Example Usages ##

**STRONGLY RECOMMENDED**: If you echo the publish profile in your GitHub Actions workflow, the `userPWD` value cannot be masked. Therefore, it's STRONGLY RECOMMENDED to reset the publish profile to minimise the chance being compromised.

### Retrieve Azure Web/Function App Publish Profile ###

```yaml
steps:
- name: Get WebApp/FunctionApp publish profile
  id: webapp
  uses: aliencube/publish-profile-actions@v1
  env:
    AZURE_CREDENTIALS: ${{ secrets.AZURE_CREDENTIALS }}
  with:
    resourceGroupName: '<RESOURCE_GROUP_NAME>'
    appName: '<WEBAPP_NAME>'

- name: Show Profile
  shell: bash
  run: |
    echo "WebApp: ${{ steps.webapp.outputs.profile }}"
```


### Reset Azure Web/Function App Publish Profile ###

```yaml
steps:
- name: Reset WebApp/FunctionApp publish profile
  id: reset
  uses: aliencube/publish-profile-actions@v1
  env:
    AZURE_CREDENTIALS: ${{ secrets.AZURE_CREDENTIALS }}
  with:
    resourceGroupName: '<RESOURCE_GROUP_NAME>'
    appName: '<FUNCTIONAPP_NAME>'
    reset: true

- name: Show Profile - this should show empty
  shell: bash
  run: |
    echo "FunctionApp: ${{ steps.reset.outputs.profile }}"
```


## How to Get `AZURE_CREDENTIALS`? ##

Please refer to the [`Azure Login`](https://github.com/marketplace/actions/azure-login#configure-deployment-credentials) action.


## Contribution ##

Your contributions are always welcome! All your work should be done in your forked repository. Once you finish your work with corresponding tests, please send us a pull request onto our `main` branch for review.


## License ##

**Azure Web/Functions App Publish Profile Actions** is released under [MIT License](http://opensource.org/licenses/MIT)

> The MIT License (MIT)
>
> Copyright (c) 2020 [aliencube.org](https://aliencube.org)
> 
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
