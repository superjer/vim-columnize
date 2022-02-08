vim-columnize
=============
Very precisely organize text into columns

Once started, you will be able to interactively choose each delimiter.

Columnize does not remove any whitespace. It can only shift things to the right,
or leave them in place.

To use, start by visually selecting some lines with `V`
Then press `Ctrl+S` to start Columnizing

Example input text:

<pre>
    some,text,which;has WEIRD different(separators)
    more fun,text,that     ;still has WEIRD sep tokens (things)
    even,more really fun,nonsense;text WEIRD maybe emptier ()
    ,,;WEIRD(hi)
</pre>

After selecting these lines and pressing `Ctrl+S`, the following:
`,` `,` `;` `WEIRD` `(` `)`

...has this effect:

<pre>
    some    ,text           ,which    ;has       WEIRD different     (separators)
    more fun,text           ,that     ;still has WEIRD sep tokens    (things    )
    even    ,more really fun,nonsense ;text      WEIRD maybe emptier (          )
            ,               ,         ;          WEIRD               (hi        )
</pre>
