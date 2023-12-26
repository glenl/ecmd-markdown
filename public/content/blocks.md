# Blocks

This section is all about code and quoted blocks.

A code block:

```bash
#!/bin/bash
#
for file in `ls *.rst`
do
    sed -i -f fix.sed $file
done
```

## Block Quotes

A single-line block quote:

```
> Now is the time.
```

> Now is the time.


For multiple paragraphs, use the right-angle character on the space
between.


```
> Be yourself; everyone else is taken.
>
> The world was my oyster but I used the wrong fork.
>
> -- Oscar Wilde
```
> Be yourself; everyone else is taken.
>
> The world was my oyster but I used the wrong fork.
>
> -- Oscar Wilde

Block quotes can also nest.

```
> And then he said,
>> Something else.
```

> And then he said,
>> Something else.
