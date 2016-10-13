type token = string
type topic = string
type error = string

module Data :
  sig
    (** The type representing the data object received with each notification *)
    type t = Ojs.t

    (** [was_tapped data] returns [true] if the application was in background
        and the user taps the notification. If the application was in
        foreground, the value is [false].
     *)
    val was_tapped          : t -> bool
    [@@js.get]

    (** The ID of the application. For FCM, it's the project number.
        NOTE: A value is set only if the application was in background.
     *)
    val from                : t -> string option
    [@@js.get]

    (** Seems to be always the application ID.
        NOTE: A value is set only if the application was in background.
     *)
    val collapse_key        : t -> string option
    [@@js.get "collapse_key"]

    (** The topic message ID when GCM has successfully received the request and
        will attempt to deliver to all subscribed devices.
        NOTE: A value is set only if the application was in background.
     *)
    val google_message_id   : t -> string option
    [@@js.get "google.message_id"]

    (** The following section defines functions to get data sent to FCM server in
        the payload 'data'.
     *)
    [@@@js.stop]
    (** [get data key] returns the value of [data.key] as an [Ojs.t] type *)
    val get                 : t -> string -> Ojs.t

    (** [get_string data key] returns the value of [data.key] as a string *)
    val get_string          : t -> string -> string

    (** [get_int data key] returns the value of [data.key] as an integer *)
    val get_int             : t -> string -> int

    (** [get_bool data key] returns the value of [data.key] as a boolean *)
    val get_bool            : t -> string -> bool

    (** [get_int64 data key] returns the value of [data.key] as an int64 type *)
    val get_int64           : t -> string -> int64
    [@@@js.start]

    [@@@js.implem
      let get data key        = Ojs.get data key

      let get_string data key = Ojs.string_of_js (get data key)

      let get_int data key    = Ojs.int_of_js (get data key)

      let get_bool data key   = Ojs.bool_of_js (get data key)

      let get_int64 data key  = Int64.of_string (get_string data key)
    ]
  end

(** [get_token success_callback error_callback] gets a token from FCM.
    If success, the callback [success_callback] is called and the token is given
    in the first parameter.
    If an error occured, the callback [error_callback] is called and the
    error description is given as a string in the first parameter.
 *)
val get_token :
  (token -> unit) ->
  (error -> unit) ->
  unit
[@@js.global "FCMPlugin.getToken"]

(** [subscribe_to_topic topic success_callback error_callback] subscribes to the
    topic [topic].
    If success, the callback [success_callback] is called and a message is given
    in the first parameter.
    If an error occured, the callback [error_callback] is called and the
    error description is given as a string in the first parameter.
 *)
val subscribe_to_topic :
  topic ->
  (string -> unit) ->
  (error -> unit) ->
  unit
[@@js.global "FCMPlugin.subscribeToTopic"]

(** [unsubscribe_to_topic topic success_callback error_callback] unsubscribes to
    the topic [topic].
    If success, the callback [success_callback] is called and a message is given
    in the first parameter.
    If an error occured, the callback [error_callback] is called and the
    error description is given as a string in the first parameter.
 *)
val unsubscribe_from_topic :
  topic ->
  (string -> unit) ->
  (error -> unit) ->
  unit
[@@js.global "FCMPlugin.unsubscribeFromTopic"]

(** [on_notification callback_on_notification success_registering
    error_registering] registers the callback [callback_on_notification] which
    will be executed when the device will receive a notification. A [Data.t]
    value is given in first parameter which contains keys sent by FCM. You can
    get any key values by using the appropriate [Data.get] functions. Wrappers
    for built-in OCaml types like get_string, get_bool, get_int, get_int64 are
    defined to avoid using a cast function.

    [success_registered] will be executed if the onNotification callback is
    successfully registered.
    [error_registered] will be executed if the onNotification callback failed to
    register.
 *)
val on_notification :
  (Data.t -> unit) ->
  (string -> unit) ->
  (error -> unit) ->
  unit
[@@js.global "FCMPlugin.onNotification"]
