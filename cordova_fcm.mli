type token = string
type topic = string
type error = string

module Data :
  sig
    type t = Ojs.t

    val was_tapped : t -> bool
    [@@js.call]

    [@@@js.stop]
    val get : t -> string -> Ojs.t
    [@@@js.start]

    [@@@js.implem
      let get data str = Ojs.get data str
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
