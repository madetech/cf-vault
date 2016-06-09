# Cloud Foundry Vault

`cf-vault` is the tool you use to syncronise your application secrets stored in [Hashicorp's Vault][Vault] to [Cloud Foundry][CloudFoundry] providers like [Pivotal][Pivotal].

## Set environment variables for all Vault secrets under the key `foo`:

```
rake cf:vault:set_environment key=foo
```


## Credits

[![made](https://s3-eu-west-1.amazonaws.com/made-assets/googleapps/google-apps.png)][made]

Developed and maintained by [Made Tech][made]. Key contributions:

 * [Emile Swarts](https://github.com/emileswarts)
 * [Chris Blackburn](https://github.com/chrisblackburn)
 * [Seb Ashton](https://github.com/sebashton)
 * [Andrew Scott](https://github.com/askl56)

## License

Copyright © 2016 Made Tech Ltd. It is free software, and may be
redistributed under the terms specified in the [MIT-LICENSE][license] file.

[CloudFoundry]: http://www.cloudfoundry.org/
[Pivotal]: https://run.pivotal.io/
[Vault]: https://www.vaultproject.io/
[cli]: https://github.com/cloudfoundry/cli/releases
[made]: http://www.madetech.co.uk?ref=github&repo=cf-vault
[license]: https://github.com/madetech/cf-vault/blob/master/LICENSE
