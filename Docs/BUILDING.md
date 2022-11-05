# Building Arcadia

## Getting Started

The easiest way to get started is by connecting your Github account to Gitpod! ([What is Gitpod?](https://www.gitpod.io/)) <a href="https://gitpod.io/#eiymba/arcadia">
  <img
    src="https://img.shields.io/badge/Contribute%20with-Gitpod-908a85?logo=gitpod"
    alt="Contribute with Gitpod"
  />
</a>

### Prerequisites

- [ ] You have a [GitHub account](https://github.com).
- [ ] You have [Git](https://git-scm.com/) installed on your machine. _(Don't want to install Git? Try [Gitpod](https://gitpod.io/#eiymba/arcadia))_
- [ ] A text editor like [Visual Studio Code](https://code.visualstudio.com/) with [Lua](https://www.lua.org/) language support. _(Don't want to install anything? Try [Gitpod](https://gitpod.io/#eiymba/arcadia))_



### Build The Project

Arcadia comes with a build script that will build the project and package it into a `.zip` file. The script can also extract the `.zip` file into your WoW Addons directory, by passing the `-x` flag.

Arcadia has several build flags that can be passed to the build script. These flags can be found in the [build script](./build.ps1) itself too.

> ℹ️ **Note:** Shorthand flags work on both Windows and Unix systems! 🥳

| Flag | Windows | Unix | Description |
| --- | ---: | ---: | --- |
| `-h` | `-Help` | `--help` | Specify the project directory. |
| `-c` | `-Clean` | `--clean` | Clean the build directory. |
| `-r` | `-Release` | `--release` | Clean the build directory. |
| `-x` | `-CopyToWow` | `--copy-to-wow` | Extract the `.zip` file into your WoW Addons directory. |
| `-v` | `-Version` | `--version` | Specify the build directory. |
| `-d` | `-BuildDir` | `--build-dir` | Specify the build directory. |
| `-o` | `-OutputDir` | `--output-dir` | Specify the build directory. |
| `-w` | `-WowDir` | `--wow-dir` | Specify the build to the specified location. |
| `-f` | `-File` | `--file` | The `toc` file to use |
| `-i` | `-InterfaceVersion` | `--interface-version` | The interface version to use. Change this when updating or building for classic. |

#### Example

>ℹ️ **Note:** By default, the script will build a retail compatible `.zip` archive of the addon inside the `./build` directory _without_ performing a `clean`, and _without_ extracting the `.zip` file into your WoW Addons directory.

Here's an example of building for wrath classic:

Windows:

```powershell
./build.ps1 -c -r -x -v 1.0.0 -d ./build -o ./dist -w "C:\Program Files (x86)\World of Warcraft\_classic_era_" -f ./arcadia.toc -i 30400
```

Unix:

```bash
./build.sh --clean --release --copy-to-wow --version 1.0.0 --build-dir ./build --output-dir ./dist --wow-dir "/Applications/World of Warcraft/_classic_era_" --file ./arcadia.toc --interface-version 30400
```

Typically, you will want to build the project for retail with defaults, and then extract the `.zip` file into your WoW Addons directory. This can be done by passing the `-x` flag to the build script.

Windows:

```powershell
./build.ps1 -x -c
```

Unix:
```bash
./build.sh -x -c
```

## Developing In Visual Studio Code

Be sure to have the `LUA` and `WoW API` extensions installed. You can install it by searching for `@ext:sumneko.lua` and `@ext:ketho.wow-api` in the extensions tab. They provide convient linting and autocompletion for the project.

### Build Tasks

Instead of running the build script manually, you can use the build tasks to configure the build script to run automatically when you press `Ctrl+Shift+B` or `Cmd+Shift+B`.

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Build (Windows, Retail)",
            "type": "shell",
            "command": "./build.ps1",
            "args": [
                "-x",
                "-c"
            ],
            "problemMatcher": {
                "owner": "Powershell",
                "fileLocation": [
                    "relative",
                    "${workspaceFolder}"
                ],
                "pattern": [
                    {
                        "regexp": "^\\s*(.+):(\\d+):\\s*(.+)$",
                        "file": 1,
                        "line": 2,
                        "message": 3
                    }
                ]
            }
        },{
            "label": "Build (Unix, Retail)",
            "type": "shell",
            "command": "./build.sh",
            "args": [
                "-x",
                "-c"
            ],
            "problemMatcher": {
                "owner": "Bash",
                "fileLocation": [
                    "relative",
                    "${workspaceFolder}"
                ],
                "pattern": [
                    {
                        "regexp": "^\\s*(.+):(\\d+):\\s*(.+)$",
                        "file": 1,
                        "line": 2,
                        "message": 3
                    }
                ]
            }
            
        },{
            "label": "Build (Windows, Classic Era)",
            "type": "shell",
            "command": "./build.ps1",
            "args": [
                "-x",
                "-c",
                "-i",
                "30400"
            ],
            "problemMatcher": {
                "owner": "Powershell",
                "fileLocation": [
                    "relative",
                    "${workspaceFolder}"
                ],
                "pattern": [
                    {
                        "regexp": "^\\s*(.+):(\\d+):\\s*(.+)$",
                        "file": 1,
                        "line": 2,
                        "message": 3
                    }
                ]
            }
        },{
            "label": "Build (Unix, Classic Era)",
            "type": "shell",
            "command": "./build.sh",
            "args": [
                "-x",
                "-c",
                "-i",
                "30400"
            ],
            "problemMatcher": {
                "owner": "Bash",
                "fileLocation": [
                    "relative",
                    "${workspaceFolder}"
                ],
                "pattern": [
                    {
                        "regexp": "^\\s*(.+):(\\d+):\\s*(.+)$",
                        "file": 1,
                        "line": 2,
                        "message": 3
                    }
                ]
            }
        }

    ]
}
```

### Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for more information.