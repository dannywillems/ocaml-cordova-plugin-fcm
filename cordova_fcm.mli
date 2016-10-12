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
    val was_tapped : t -> bool
    [@@js.get]

    (** The ID of the application. For FCM, it's the project number.
        NOTE: A value is set only if the application was in background.
     *)
    val from : t -> string option
    [@@js.get]

    val collapse_key : t -> string option
    [@@js.get "collapse_key"]

    (** The topic message ID when GCM has successfully received the request and
        will attempt to deliver to all subscribed devices.
        NOTE: A value is set only if the application was in background.
     *)
    val google_message_id : t -> string option
    [@@js.get "google.message_id"]

    [@@@js.stop]
    (** [get data key] returns the value of [data.key] as an [Ojs.t] type *)
    val get : t -> string -> Ojs.t

    (** [get data key] returns the value of [data.key] as a [string] *)
    val get_str : t -> string -> string
    [@@@js.start]

    [@@@js.implem
      let get data str = Ojs.get data str

      let get_str data str = Ojs.string_of_js (Ojs.get data str)
    ]
  end

val get_token :
  (token -> unit) ->
  (error -> unit) ->
  unit
[@@js.global "FCMPlugin.getToken"]

val subscribe_to_topic :
  topic ->
  (string -> unit) ->
  (error -> unit) ->
  unit
[@@js.global "FCMPlugin.subscribeToTopic"]

val unsubscribe_from_topic :
  topic ->
  (string -> unit) ->
  (error -> unit) ->
  unit
[@@js.global "FCMPlugin.unsubscribeFromTopic"]

val on_notification :
  (Data.t -> unit) ->
  (string -> unit) ->
  (error -> unit) ->
  unit
[@@js.global "FCMPlugin.onNotification"]
