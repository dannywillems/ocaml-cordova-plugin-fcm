# ocaml-cordova-plugin-fcm

Binding to
[cordova-plugin-fcm](https://github.com/fechanique/cordova-plugin-fcm)

## What does cordova-plugin-fcm do?

```
Extremely easy plug&play push notification plugin for Cordova applications with Google Firebase FCM.
```

Source: [cordova-plugin-fcm](https://github.com/fechanique/cordova-plugin-fcm)

## How to install and compile your project by using this plugin?

Don't forget to switch to a compiler **>= 4.03.0**.
```Shell
opam switch 4.03.0
```

If you want to install the latest released version:
```
opam install cordova-plugin-fcm
```

For the dev version, you can use OPAM by pinning the repository with
```Shell
opam pin add cordova-plugin-fcm https://github.com/dannywillems/ocaml-cordova-plugin-fcm.git
```

To compile your project, use
```Shell
ocamlfind ocamlc -c -o [output_file] -package gen_js_api -package cordova-plugin-fcm [...] -linkpkg [other arguments]
```

Don't forget to install cordova-plugin-fcm with
```Shell
cordova plugin add cordova-plugin-fcm
```

## How to use?

See the `doc` directory. The documentation is generated thanks to `ocamldoc`
with the command
```Shell
make doc-html
```
which is
```
mkdir -p doc
ocamlfind ocamldoc -html -package gen_js_api -d doc cordova_push.mli
```

You have also the plugin documentation and source code
[here](https://github.com/fechanique/cordova-plugin-fcm)
