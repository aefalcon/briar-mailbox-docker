You most likely want to create a volume for briar-mailbox.

```
docker volume create briar-mailbox
```

Once you have a volume, you can run a container.

```
docker run --rm --volume briar-mailbox:/mailbox/data --name briar-mailbox aefalcon/briar-mailbox
```

*briar-mailbox* will log information needed for paring the briar app to the mailbox.