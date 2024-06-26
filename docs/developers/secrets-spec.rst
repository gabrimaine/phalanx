####################################
Specification for secrets.yaml files
####################################

The top level of :file:`secrets.yaml` and :file:`secrets-{environment}.yaml` files is an object mapping the key of a secret to its specification.
The key corresponds to the key under which this secret is stored in the secret entry in Vault for this application.

The specification of the secret has the following keys:

``description`` (string, required unless ``copy`` is set)
    Human-readable description of the secret.
    This should include a summary of what the secret is used for, any useful information about the consequences if it should be leaked, and any details on how to rotate it if needed.
    The description must be formatted with reStructuredText_.

    .. _reStructuredText: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html

    The ``>`` and ``|`` features of YAML may be helpful in keeping this description readable inside the YAML file.

    If a non-conditional ``copy`` setting is also present (see below), this field may be omitted.
    In this case, the description will be copied from the source of the secret.

``if`` (string, optional)
    If present, specifies the conditions under which this secret is required.
    The value should be a Helm values key that, if set to a true value (including a non-empty list or object), indicates that this secret is required.
    The Phalanx tools will look first in :file:`values-{environment}.yaml` and then in :file:`values.yaml` to see if this value is set.
    If this condition evaluates to false, the secret is not used in that environment.

    True and false are evaluated similar to the rules in Python: boolean false values, empty strings, empty dictionaries, and empty lists are considered false, and all other values are considered true.

``copy`` (object, optional)
    If present, specifies that this secret is a copy of another secret.
    It has the following nested settings.

    ``application`` (string, required)
        Application from which to copy this secret value.

    ``key`` (string, required)
        Secret key in that application from which to copy this secret value.

    ``if`` (string, optional)
        If present, specifies a Helm values key that, if set to a true value, indicates this secret should be copied.
        It is interpreted the same as ``if`` at the top level.
        If the condition is false, the whole ``copy`` stanza will be ignored.
        If true, or if this ``if`` key is not present, either ``generate`` must be unset or must have an ``if`` condition that is false.
        True and false are determined in the same as the top-level ``if`` directive.

``generate`` (object, optional)
    Specifies that this is a generated secret rather than a static secret.
    The nested settings specify how to generate the secret.

    ``type`` (string, required)
        One of the values ``password``, ``gafaelfawr-token``, ``fernet-key``, ``rsa-private-key``, ``bcrypt-password-hash``, or ``mtime``.
        Specifies the type of generated secret.

    ``source`` (string, required for ``bcrypt-password-hash`` and ``mtime``)
        This setting is present if and only if the ``type`` is ``bcrypt-password-hash``.
        The value is the name of the key, within this application, of the secret that should be hashed to create this secret.

    ``if`` (string, optional)
        If present, specifies a Helm values key that, if set to a true value, indicates this secret should be generated.
        It is interpreted the same as ``if`` at the top level.
        If the condition is false, the whole ``generate`` stanza will be ignored (making this a static secret in that environment instead).
        If true, or if this ``if`` key is not present, either ``copy`` must be unset or must have an ``if`` condition that is false.
        True and false are determined in the same as the top-level ``if`` directive.

``value`` (string, optional)
    In some cases, applications may need a value exposed as a secret that is not actually a secret.
    The preferred way to do this is to add such values directly in the ``VaultSecret`` object, but in some cases it's clearer to store them in :file:`secrets.yaml` alongside other secrets.

    In those cases, ``value`` contains the literal value of the secret (without any encoding such as base64).
    Obviously, do not use this for any secrets that are actually secret, only for public configuration settings that have to be put into a secret due to application requirements.

    ``value`` must not be set if either ``copy`` or ``generate`` are set and either do not have an ``if`` condition or have a true ``if`` condition.

``onepassword`` (object, optional)
    Configuration describing how the secret is stored in 1Password in the cases where it is a static secret and 1Password is used as the static secrets store.

    ``encoded`` (bool, optional, default: false)
        If set to true, the secret stored in 1Password has an extra layer of base64-encoding that must be removed when retrieving the secret.
        This is used for secrets that contain embedded newlines that must be preserved, since 1Password doesn't support newlines in field values.

These files will be syntax-checked against a YAML schema in CI tests for the Phalanx repository.
