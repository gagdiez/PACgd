---
layout: just_the_docs
title: Actions
nav_order: 3
---

# Actions
{: .no_toc }

Actions are an important part of PACgd, since they define what a `Character` 
can do with each `Interactive` objects. There are four types of `Actions` in
PACgd: `INTERACTIVE`, `IMMEDIATE`, `TO_COMBINE` and `INTERNAL`.

{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Interactive Actions

`Interactive actions` are used to define the `main_action` and `secondary_action`
of `Interactive` objects. Each `Interactive action` defines a method that will
be called in the object when the player clicks on it.

| Action          |  Cutscene Syntax          | Method to define in Object | Default method's code |
|:----------------|:--------------------------|:---------------|:-----------------------|
| ACTIONS.examine | `<who> examine: <object>` | `examine(who)` | `who.say(description)` |
| ACTIONS.go\_to  | `<who> go_to: <object>`   | `go_to(who)`   | -                      |
| ACTIONS.open    | `<who> open: <object>`    | `open(who)`    | -                      |
| ACTIONS.read    | `<who> read: <object>`    | `read(who)`    | -                      |
| ACTIONS.search  | `<who> search: <object>`  | `search(who)`  | -                      |
| ACTIONS.take    | `<who> take: <object>`    | `take(who)`    | see below              |
| ACTIONS.talk\_to| `<who> talk_to: <whom>`   | `talk_to(who)` | see below              |
| ACTIONS.use     | `<who> use: <object>`     | `use(who)`     | -                      |
| ACTIONS.walk\_to| `<who> walk_to: <object>` | `walk_to(who)` | `who.approach(self)`   |

**take:** By default the `Character` will approach the object, move its hand
and put it the object in the `Inventory`. The object then becomes invisible and
stops being `Interactive`. This is the default code in the `Interactive` Class:

```gd
func take(who):
	who.approach(self)
	who.animate_until_finished("raise_hand")
	who.call_function_from(self, "grab")
	who.add_to_inventory(self)
	who.animate_until_finished("lower_hand")

func grab():
	visible = false
	interactive = false
```

**talk_to:** The talk_to function is by default only defined for `Characters`.
It will make the player walk towards the clicked `Character`, and on arrival the
`Character` will greet them. For complex dialogues we recommend to overriding
the default method and play a `CutScene`.

```gd
func talk_to(who):
	# Called when main_action is invoked by the click
	self.wait_on_character(who, "arrived")
	self.face_object(who)
	self.say("Hi " + who.name)

	who.approach(self)
	who.emit_message("arrived")
```

## To-Combine Actions

To-combine `Actions` are actions that need two elements in order to be executed.
So far there are 2 to-combine actions: `use_item` and `give`. `use_item` is set
automatically by PACgd as the `main_action` of `items` in the `Inventory`. Meanwhile,
`give` is to be used in `CutScenes` to exchange `items` between `Characters`.

| Action           | Cutscene Syntax | Method to define in the Object | Default code |
|:-----------------|:---------------------| :---------------------|:--     ---------|
| ACTIONS.use\_item| `<who> use_item: <item> <object>` | `use_item(who, item)`| `who.say("I don't know how to use it")` |
| ACTIONS.give     | `<who> give: <item> <to_whom>` | `receive_item(who, item)` | see below      |

**give:** The `give` `Action` evokes the `receive_item(who, item)` function
in the `Character` (`who`) receiving the `item`. By default the player will
walk to the `Character` that implements the function, and exchange the item
from one `Inventory` to the other.

```gd
func receive_item(who, item):
	# Remove item
	who.animate_until_finished("raise_hand")
	who.remove_from_inventory(item)
	who.animate_until_finished("lower_hand")
	who.emit_message("gave_item")
	
	# Take item
	self.animate_until_finished("raise_hand")
	self.animate_until_finished("lower_hand")
	self.wait_on_character(who, "gave_item")
	self.add_to_inventory(item)
```

## Immediate Actions

Immediate `Actions` are actions executed by the `Characters`.


| Action                          | Cutscene Syntax      | Method      | Default behavior |
|:--------------------------------|:---------------------|:------------|:------------------------|
| ACTIONS.say                     | `<who> say: <what>`  | `say(what)` | `Character` says `what` |
| ACTIONS.add\_to\_inventory      | `<who> add_to_inventory: <item>`  | `add_to_inventory(item)` | `Character` adds the `item` to its `Inventory` |
| ACTIONS.remove\_from\_inventory | `<who> remove_from_inventory: <item>` |`remove_from_inventory(item)` | `Character` removes the `item` to its `Inventory` |


## Internal Actions

Internal `Actions` call or modify parameters of `Objects`. They are helpful
to set internal variables during `CutScenes`, or call Objects' methods.

| Action       | Cutscene Syntax      | Default behavior |
|:-------------|:---------------------|:------------------|
| ACTIONS.set  | `<object> set: <variable> <value>`  | `object.set(variable, value)` |
| ACTIONS.call | `<object> call: <function> <param1> ... <paramN>`  | `object.call(function, param1, ..., paramN)` |


### Important
{: .no_toc }
- The `Internal action` `set` cannot create new variables. To correctly execute
`object.set(variable, value)` or `object set: variable value` the `object`
**must** have the property `variable` **already defined**
- If the wrong number or type of parameters are used during a `call`, the
execution of the game will continue, without **failing nor halting**.

## Empty Action

The empty action (`ACTIONS.none`) is a special type of `Action` to denote that
either the `main_action` or `secondary_action` of an Object does nothing. The
click will simply be ignored.
