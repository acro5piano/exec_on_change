# Exec_on_change

Watcher in shell

# Usage

`exec_on_change directory/file command`

```sh
# Start watching the current directory recursively.
# When a file is changed, execute `ruby -v`.
% exec_on_change ./ 'ruby -v'
```

Watching like this:

```
exec      : ruby -v
at        : Sun Sep 18 15:58:43 JST 2016
on_change : .
exclude   : .git
------------------------------------------------------------------------------------
ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-linux]
```

# Install

```sh
antigen bundle acro5piano/exec_on_change
```

