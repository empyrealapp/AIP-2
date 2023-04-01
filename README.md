# AIP-2

This demonstrates how users would be able to recover funds sent directly to the Arbitrum address on launch day.

The owner address would need to provide a list of addresses and amounts using the `initializeRecovery` method, and then users would be able to invoke `recover` once this is complete.

The contract uses unstructured storage to prevent the Arbitrum contract storage from collisions.  We could imagine this update being removed in a later update to clean up the interface, after a period of 1-3 months.


# Note

This needs to be tested further, but demonstrates the general concept that could be used.
