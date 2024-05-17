<div align="center">
    <img src="assets/nvf-logo-work.svg" alt="nvf Logo"  width="200">
    <br/>
    <h1>nvf</h1>
</div>

<div align="center">
  <p>
    <a href="https://github.com/NotAShelf/nvf/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/NotAShelf/nvf?style=for-the-badge&logo=nixos&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/NotAShelf/nvf/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/NotAShelf/nvf?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/NotAShelf/nvf/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/NotAShelf/nvf?style=for-the-badge&logo=nixos&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/NotAShelf/nvf/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/NotAShelf/nvf?style=for-the-badge&logo=nixos&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/NotAShelf/nvf/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/NotAShelf/nvf?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/NotAShelf/nvf">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/NotAShelf/nvf?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
  </p>
</div>

<p align="center">
    <img src="https://stars.medv.io/NotAShelf/nvf.svg", title="stars"/>
</p>

<div align="center">
  <a>
    A highly modular, configurable, extensible and easy to use Neovim configuration 
    framework in Nix. Designed for flexibility and ease of use, this flake 
    allows you to easily configure your Neovim instance with a few lines of 
    Nix code.
  </a>
</div>

---

<div align="center"><p>

[Get Started]: #get-started
[Documentation]: #documentation
[Help]: #help
[Contribute]: #contributing
[FAQ]: #faq
[Credits]: #credits

**[<kbd> <br> Get Started <br> </kbd>][Get Started]**
**[<kbd> <br> Documentation <br> </kbd>][Documentation]**
**[<kbd> <br> Help <br> </kbd>][Help]**
**[<kbd> <br> Contribute <br> </kbd>][Contribute]**
**[<kbd> <br> FAQ <br> </kbd>][Faq]**
**[<kbd> <br> Credits <br> </kbd>][Credits]**

</p></div>

---

## Get Started

### Using `nix` CLI

If you would like to try out the configuration before even thinking about
installing it, you can run the following command

```console
nix run github:notashelf/nvf
```

This will get you a feel for the base configuration and UI design.
The flake exposes `#nix` as the default package, providing minimal
language support and various utilities.You may also use `#nix`,
`#tidal` or `#maximal` to get try out different configurations.

It is as simple as changing the target output to get a different
configuration. For example, to get a configuration with `tidal` support, run:

```console
nix run github:notashelf/nvf#tidal
```

Similar instructions will apply for `nix profile install`. However, you are
recommended to instead use the module system as described in the manual.

> [!NOTE]  
> The `maximal` configuration is _massive_ and will take a while to build.
> To get a feel for the configuration, use the default `nix` or `tidal`
> configurations. Should you choose to try out the `maximal` configuration,
> using the binary cache as described in the manual is _strongly_ recommended.

## Documentation

See the [**nvf** Manual](https://notashelf.github.io/nvf/) for
detailed installation guides, configurations, available options, release notes
and more. Tips for installing userspace plugins is also contained in the
documentation.

If you want to dive right into trying **nvf** you can get a fully
featured configuration with `nix` language support by running:

```console
nix run github:notashelf/nvf#nix
```

[Issues]: https://github.com/NotAShelf/nvf/issues

Please create an issue on the [issue tracker](issues) if you find
the documentation lacking or confusing. I also appreciate any contributions
to the documentation.

## Help

You can create an issue on the [issue tracker](issues) to ask questions
or report bugs. I am not yet on spaces like matrix or IRC, so please use the issue
tracker for now.

## Contributing

I am always looking for new ways to help improve this flake. If you would like
to contribute, please read the [contributing guide](CONTRIBUTING.md) before
submitting a pull request. You can also create an issue on the
[issue tracker](issues) before submitting a pull request if you would
like to discuss a feature or bug fix.

## FAQ

**Q**: Can you add _X_?
<br/>
**A**: Maybe! It is not one of our goals to support each and every Neovim
plugin, however, I am always open to new modules and plugin setup additions
to **nvf**. Use the [appropritate issue template](issues/new/choose) and I will
consider a module addition.

**Q**: A plugin I need is not available in **nvf**. What to do?
<br/>
**A**: **nvf** exposes several APIs for you to be able to add your own
plugin configurations! Please see the documentation on how you may do
this.

**Q**: Main branch is awfully silent, is the project dead?
<br/>
**A**: No! Sometimes we branch out (e.g. v0.6) to avoid breaking userspace
and work in a separate branch until we make sure the new additions are
implemented in the most comfortable way available to the end user. If you have
not noticed any activity on the main branch, consider taking a look at the [list
of branches](https://github.com/NotAShelf/nvf/branches=) or the [list of open
pull requests](https://github.com/NotAShelf/nvf)

## Credits

### Contributors

Special thanks to

- [@fufexan](https://github.com/fufexan) - For the transition to flake-parts
- [@FlafyDev](https://github.com/FlafyDev) - For getting the home-manager to work
- [@n3oney](https://github.com/n3oney) - For making custom keybinds finally possible
- [@horriblename](https://github.com/horriblename) - For actively implementing planned features and quality of life updates
- [@Yavko](https://github.com/Yavko) - For the amazing **nvf** logo
- [@FrothyMarrow](https://github.com/FrothyMarrow) - For seeing mistakes that I could not

and everyone who has submitted issues or pull requests!

### Inspiration

This configuration borrows from and is based on a few other configurations,
including:

- [@jordanisaacs's](https://github.com/jordanisaacs) [neovim-flake](https://github.com/jordanisaacs/neovim-flake) that this flake is originally based on.
- [@sioodmy's](https://github.com/sioodmy) [dotfiles](https://github.com/sioodmy/dotfiles) that inspired the design choices.
- [@wiltaylor's](https://github.com/wiltaylor) [neovim-flake](https://github.com/wiltaylor/neovim-flake) for plugin and design ideas.
- [@gvolpe's](https://github.com/gvolpe) [neovim-flake](https://github.com/gvolpe/neovim-flake) for plugin, design and nix concepts.

I am grateful for their previous work and inspiration, and I wholeheartedly
recommend checking their work out.
<br/>

## License

Following the license of the [original neovim-flake](https://github.com/jordanisaacs/neovim-flake),
**nvf** has been made available under the [**MIT License**](LICENSE). However, all assets
and documentation are published under the 
[**CC BY License**](https://github.com/NotAShelf/nvf/blob/main/.github/assets/LICENSE).

---

<div align="right">
  <a href="#readme">Back to the Top</a>
</div>
