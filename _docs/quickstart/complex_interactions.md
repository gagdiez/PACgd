---
layout: just_the_docs
title: Complex Interaction
parent: QuickStart
nav_order: 3
---

# QuickStart - Character Interaction
{: .no_toc }

As you saw on previous tutorials, PACgd simplifies creating interactions between 
`Characters` and `Objects`. In this tutorial we will see how to create
Interactions between two or more `Characters`.

{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Import PACgd Quickstart - Character Interaction

Download the PACgd [example projects](https://github.com/gagdiez/PACgd_examples/archive/main.zip)
and extract its content into a folder in your computer. Then, import the
project "Character_Interaction" in Godot.

## Understanding the Scene

Once the project is imported, Godot will open and you should see a scene with
two character (**Cole** and **Shadow Cole**) and three boxes: **Red Box**,
**Green Box**, and **White Box**.

![scene](/docs/quickstart/images/scene3.png)

Before we dig into the scene and its components, play the game! Press F5 or the
play button on the top-right corner.

### The Objects

The objects in this scene are the same as in our [Cutscene tutorial](/docs/quickstart/cutscenes),
with the addition of **Shadow cole**

### The Code - Interaction Between Characters

The main addition of this project is the code in **Shadow Cole**:

```gd
func use_item(who, item):
	# Called when <WHO> uses <ITEM> on me
	# Cole approaches Shadow Cole
	who.approach(self)
	who.emit_message("arrived")

	# Shadow Cole waits until Cole arrives and looks at him
	self.wait_on_character(who, "arrived")
	self.face_object(who)

	if item != $"../Green Box":
		self.say("No, please give me the green box")
		return

	# Cole moves hand and remove from inventory
	who.animate_until_finished("raise_hand")
	who.remove_from_inventory(item)
	who.animate_until_finished("lower_hand")

	# Shadow Cole moves hand and add to inventory
	self.animate_until_finished("raise_hand")
	self.add_to_inventory(item)
	self.animate_until_finished("lower_hand")

	self.say("Thanks")
	$"../Red Box".use_item(self, item) #-> it populates the queue of Shadow Cole 
	self.emit_message("box_placed")

	# Cole waits and says thank you
	who.wait_on_character(self, "box_placed")
	who.say("That's it, now you can check the code!")
	who.say("Thanks for being interested in our work")
	who.emit_message("finished_talking")

	# Shadow Cole waits says thank you
	self.wait_on_character(who, "finished_talking")
	self.say("We are sure you will make awesome games!")
```

You will notice that the code has calls like `who.emit_message()` and
`who.wait_on_character()`. What are these?. Well, in Godot, each `Character` is
running on its own thread, therefore, if we populate the queues of each
subject, they will start running their own tasks immediately. Sometimes however,
we want one `Character` to wait for a certain event before starting to act. 
In this game for example, we want **Shadow Cole** to say "Hi" only after
**Cole** is next to him. For this we populate the queue of **Cole** with the
task of emitting the message `"arrived"` after finishing walking. Meanwhile, we
populate the queue of **Shadow Cole** with the task of waiting for **Cole**'s
message before starting to talk.

Once again, this is because each `Character` is running their own tasks
simultaneously. `emit_message` and `wait_on_character` are ways to coordinate
events across `Characters`, so they can act based on each other actions.

This can actually be greatly simplified by using a CutScene. Uncomment the
second version of `use_item` in **Shadow Cole**:

```gd
func use_item(who, item):
  $"../PointClick".play_scene('res://cutscenes/ShadowBox.txt', {"item":item})
```

will execute the following Cutscene:

```yaml
cole walk_to: shadow_cole

if: item != green_box
	shadow_cole say: No, please give me the Green Box
else:
	cole give: green_box shadow_cole
	shadow_cole say: Thanks
	shadow_cole use_item: green_box red_box

	cole say: That's it, now you can check the code!
	cole say: Thanks for being interested in our work
	shadow_cole say: We are sure you will make awesome games!
```

Notice how `play_scene` has a second parameter `{"item":item}`?. This is our
way of defining `item` only for this execution of the `CutScene` `ShadowBox`.

### Important
{: .no_toc }
- Remember that `CutScenes` execute one line at the time, making it simpler to
describe actions that need to happen one after the other. Meanwhile, `emit_message`
and `wait_on_character` are designed to coordinate `Characters`, allowing them
to do actions simultaneously, up to a point when they coordinate.
