---
layout: just_the_docs
title: Basics
parent: QuickStart
nav_order: 1
---

# QuickStart - Basics
{: .no_toc }

In this quickstart tutorial we will show you how to download, import, and
interact with a Godot project that includes the PACgd plugin. The project
contains a minimum example composed of one pre-made character with 2 boxes
to interact with. The goal of the player is to stack the **Red Box** in top of
the **White Box**.

{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Download Godot

If you didn't yet, download Godot from their [official website](https://godotengine.org/download/).
If you have never used Godot before you might be interested in taking a quick
look at their step-by-step [getting started tutorial](https://docs.godotengine.org/en/stable/getting_started/step_by_step/your_first_game.html)

## Import PACgd Quickstart Project

Download the PACgd [quickstart project](https://github.com/gagdiez/PACgd/archive/main.zip)
and extract its content into a folder in your computer. Then, import the
project in Godot as shown in the following image.

![import view](/PACgd/docs/quickstart/images/import.png)


## Understanding the Scene

Once the project is imported, Godot will open and you should see a scene with
a character (named **Cole**) and two boxes: the **Red Box** and the **White Box**.

![scene](/PACgd/docs/quickstart/images/scene.png)

Before we dig into the scene and its components, play the game! Press **F5** or the
play button on the top-right corner. Take the **Red box**, and use it on the
**White one** so **Cole** piles them.

### The Objects

Lets look at the objects that compose the scene, don't worry if you don't
understand everything now, we will look at them in detail later.

![objects in scene](/PACgd/docs/quickstart/images/objects.png)

- **Level**: The level is a `Spatial` Godot `Node`. It represents the 3D scene
itself, and it is the parent of all the objects you see in the screen.
	- **Camera**: The `Camera` node, through which the players will see our game
	- **Cole**: Cole is a pre-made `Character`, it is capable to walk around
	and do all the basic interactions a point and click game needs, i.e. "take",
	"talk to", "use item". This is the character we will control in our game.
	- **Floor**: An `StaticObject` with a `CollisionShape` representing the
	floor. In simpler terms, a static rectangle that can detect collisions.
	- **Navigation**: A `Navigation` object is a very useful object in Godot, which
	takes care of computing paths between points in a surface. In our case, it
	computes how to walk from one point to another in the **Floor**. It has a
	`NavigationMeshInstance` child, which is used denote the navigable area.
	- **PointClick**: Our `Point and Click` interface and its logic necessary to
	create games.
	- **Red Box**: A simple `StaticObject` with a `CollisionShape` representing
	a red box. This is the box **Cole** has to put on top of the **White Box**.
	- **White Box**: A simple `StaticObject` with a `CollisionShape` representing
	a white box. The **Red Box** has to be piled on top of it.
 
### The Code

You can access the code of each object by clicking at their
![](https://raw.githubusercontent.com/godotengine/godot/master/editor/icons/Script.svg)
icon. While we will discuss all the code now, the most important scripts are
those of the **Red Box** and **White Box**.

#### Level

In our top Node `Level`, we start by setting two properties of our `Character`
**Cole**: `navigation` and `camera`. The `navigation` node will guide **Cole**
when walking around the scene, while knowing the `camera`'s position will help
him know in which direction to look while walking.

After, we call the `init` function from our `Point and Click` system **PointClick**.
The function `init` takes two properties, in this tutorial we will only use the
first one, which tells our `Point and Click` system which character the user
controls. We will discuss the second parameter in the next tutorials.

#### Cole

Cole's script has only one line of code: `extends Character`, making it a object
of type `Character`. A `Character` is basically a queue of instructions waiting
to be filled and executed sequentially. In order to populate the queue, we use
the `Character` methods. We will see how in just a minute.
	
#### Floor

The script of the Floor is just one line: `extends Floor`, making our object of
type `Floor`. If we click on the `Floor`, **Cole** will ask the `Navigation` for
a path to go to the clicked place and walk there. All this happens automatically,
so no needs to worry about it. In order for the floor to work correctly, it
has to be covered by the `Navigation` object and its `NavigationMeshInstance`.
In this tutorial we have already setted this up for you.

#### Red Box

Most of the relevant code for this example is in the boxes. This is because in
PACgd the `Objects` are the ones giving instructions to the `Characters`. If you
click on an `Interactive` object, the object will call different methods in the
`Character` to instruct they on how to behave. Lets see the code within the
**Red Box**:

```gd
extends Interactive

func _ready():
	# We can take this object
	main_action = ACTIONS.take
	
	# The secondary_action is (implicitly) ACTIONS.examine

	# We have to stand a couple of pixels away from it to interact
	interaction_position = self.transform.origin + Vector3(3, 0, 0)

	# Description and Thumbnail
	description = "The box I have to move"
	thumbnail = "res://thumbnails/red_box.png"

func take(who):
  # Called when the box is clicked
	who.approach(self)
	who.animate_until_finished("raise_hand")
	who.call_function_from(self, "grab")
	who.add_to_inventory(self)
	who.animate_until_finished("lower_hand")

func grab():
	visible = false
	interactive = false
```

In the first line we state that this object is `Interactive`. `Interactive`
objects have six main properties: `main_action`, `secondary_action`,
`interaction_position`, `description`, `thumbnail` and `interactive`.
These properties determine:

- `main_action`, `secondary_action`: What happens when the player clicks on the
object using the primary or secondary click (left and right mouse buttons by
default). The default primary and secondary actions are `ACTIONS.walk_to` and
`ACTIONS.examine`.
- `interaction_position`: Where we want the `Characters` to stand when interacting
with the object.
- `description`: The description of the object when it is examined.
- `thumbnail`: The thumbnail to use in the inventory after the object is grabbed.
- `interactive`: A flag that determines if the Point and Click system can interact
with the object.

Then, in the function `_ready` (executed by Godot when the object is rendered),
we:
1. Set that the `main_action` is `ACTIONS.take`. This indicates that, when the
player clicks on it, **Cole** has to walk towards it, and grab it.
2. Set its `interaction_position` to 3 units to its left, so **Cole** stands
next to it before taking it.
3. Give it a `description` so the player can examine it with the secondary click.
4. Set its `thumbnail`, to be shown when the box is in the inventory.

Since the `main_action` is `ACTIONS.take`, when clicked, the object will
call its method `take(who)`. The method `take` in the **Red Box** calls a
series of methods in **Cole** (`who`). Each method adds instructions to the
queue of **Cole**, and him processes them one at the time in sequencial order.
Lets see the methods called, and what they mean:

- `who.approach(self)`: Approach `self`, this is, approach the **Red Box**
-	`who.animate_until_finished("raise_hand")`: After arriving, **Cole** will raise
his hand to take the object
-	`who.call_function_from(self, "grab")`: queues the instruction of calling the
method `grab()` in `self` (the **Red Box**). `Red Box.grab()` will render the box
invisible, and not interactive.
-	`who.add_to_inventory(self)`: Adds the item to **Cole's** `Inventory`
-	`who.animate_until_finished("lower_hand")`: **Cole** lowers his hand

In this way, the **Red Box** instructs **Cole** on the steps to follow in order
to take it.
	
#### White Box

Finally, we have the code in the **White box**:

```gd
extends Interactive

func _ready():
	# The main_action is (implicitly) "walk_to"
	# The secondary_action is (implicitly) ACTIONS.examine
	
	# We have to stand a couple of pixels away from it to interact
	interaction_position = self.transform.origin - Vector3(3, 0, 0)
	
	# Description
	description = "The mythical white box!"

func use_item(who, item):
	# The WHITE box will interact with the RED one
	who.approach(self)
	who.say("Time to place one box on top of the other")
	who.animate_until_finished("raise_hand")
	who.remove_from_inventory(item)
	who.call_function_from(self, "place_red_box")
	who.animate_until_finished("lower_hand")
	who.say("That is it, thank you for playing")

func place_red_box():
	# Function called by who.queue_interaction_with(self, "place_red_box")
	var red_box = $"../Red Box"
	red_box.transform.origin = self.transform.origin + Vector3(0, 2, 0)
	red_box.visible = true
	
	# Change its main action, so you cannot "use" it anymore
	red_box.main_action = ACTIONS.walk_to
	
	# The boxes are not interactive anymore
	self.interactive = false
	red_box.interactive = false
```

As with the **Red Box**, we extend the class `Interactive` and set its properties.

The `main_action` of the **White Box** is `ACTIONS.walk_to`, meaning that when
clicked, **Cole** will simply walk towards the box.

Since we want to use an `item` on the **White box**, we need to define the function
`use_item`. The function `use_item(who, item)` is called when a `Character` (`who`)
uses an `item` on the **White Box**. In this quickstart we know that `who`
is **Cole** since we only have one `Character`, and that the `item` is the
**Red Box**, since we only have one another `Interactive` object in the Scene.

On each line of `use_item` we call methods of the `Character` `who` in order
to populate its queue. In particular we ask **Cole** to:

- `who.approach(self)`: Approach `self`, this is, approach the **White Box**
- `who.say("Time to place one box on top of the other")`: Say something
- `who.animate_until_finished("raise_hand")`: Raise his hand
- `who.remove_from_inventory(item)`: Remove the `item` from inventory, in this
case, `item` is the **Red Box**
- `who.call_function_from(self, "place_red_box")`: Call the function
`place_red_box` from `self`. This is, call `White Box.place_red_box()`.
- `who.animate_until_finished("lower_hand")`: Lower his hand
- `who.say("That is it, thank you for playing")`: Say something
