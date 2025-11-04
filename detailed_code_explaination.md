# 📚 Complete Flutter Portfolio App - Line-by-Line Explanation

## 🎯 **Every Single Concept Explained**

---

## 📦 **Part 1: Imports & Entry Point**

```dart
import 'package:flutter/material.dart';
```

**What it does:** Imports Flutter's Material Design library  
**Why we need it:** Contains ALL the widgets we use (Container, Text, Column, etc.)  
**Material Design:** Google's design system with pre-built beautiful widgets  
**Think of it as:** Importing a toolbox with all your tools

---

```dart
void main() {
  runApp(const PortfolioApp());
}
```

**Line by line:**
- `void main()` - Entry point of every Dart program (like `main()` in C/Java)
- `runApp()` - Flutter function that starts your app
- `const PortfolioApp()` - Creates our main app widget
- `const` - Tells Dart this widget never changes (optimization)

**What happens:** 
1. Program starts → 
2. Calls main() → 
3. Runs PortfolioApp → 
4. App appears on screen

---

## 🏗️ **Part 2: Main Application Widget**

```dart
class PortfolioApp extends StatelessWidget {
```

**Breaking it down:**
- `class` - Defines a new class (blueprint for objects)
- `PortfolioApp` - Name of our class (use PascalCase)
- `extends StatelessWidget` - Inherits from StatelessWidget
- `StatelessWidget` - A widget that NEVER changes after it's built

**Why StatelessWidget here?** 
Because the app structure (theme, title) doesn't change. Only the content inside changes.

---

```dart
const PortfolioApp({super.key});
```

**What is this?**
- `const` - Constructor that creates immutable instances
- `{super.key}` - Optional named parameter passed to parent class
- `super.key` - Unique identifier for this widget in the widget tree

**Why super.key?**
Flutter uses keys to track widgets efficiently. It helps Flutter know "this is the SAME widget, just updated"

**Think of it as:** An ID card for your widget

---

```dart
@override
Widget build(BuildContext context) {
```

**Breaking it down:**
- `@override` - Annotation saying "I'm replacing the parent's method"
- `Widget` - Return type (this function returns a Widget)
- `build` - Method name (required by Flutter)
- `BuildContext context` - Information about where this widget is in the tree

**BuildContext:** 
- Like GPS coordinates for your widget
- Tells you: "Where am I in the app?"
- Needed for: Theme access, navigation, showing dialogs

**This method runs:** Every time Flutter needs to draw this widget

---

```dart
return MaterialApp(
```

**What is MaterialApp?**
- Root widget for Material Design apps
- Sets up: routing, theme, title, localization
- MUST be the top-level widget in most Flutter apps

**Think of it as:** The foundation of your house

---

```dart
title: 'Workshop Portfolio',
```

**What it does:** Sets the app name  
**Where you see it:** 
- Android: Recent apps list
- iOS: App switcher
- Web: Browser tab title
- Desktop: Window title

---

```dart
theme: ThemeData(
  primarySwatch: Colors.blueGrey,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
),
```

**ThemeData:** Global styling for your entire app

**Line by line:**
- `primarySwatch: Colors.blueGrey` 
  - Main color family for your app
  - Automatically generates shades (100, 200, 300... 900)
  
- `visualDensity: VisualDensity.adaptivePlatformDensity`
  - Makes widgets comfortable on different platforms
  - Mobile: More spacing
  - Desktop: Tighter spacing
  
- `useMaterial3: true`
  - Uses Material Design 3 (newest version)
  - Modern, rounded, colorful design

**Think of it as:** Setting the "vibe" of your entire app

---

```dart
home: const PortfolioScreen(),
```

**What it does:** Sets the first screen users see  
**home:** The starting route/page of your app  
**const PortfolioScreen():** Our custom screen widget (we define it next)

---

## 📱 **Part 3: Stateful Screen Widget**

```dart
class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});
```

**Why StatefulWidget?**
Because this screen has data that CHANGES:
- ✅ User can edit their name
- ✅ Toggle between edit/view mode
- ✅ UI updates when data changes

**StatelessWidget vs StatefulWidget:**
```
StatelessWidget: Like a printed poster (never changes)
StatefulWidget: Like a whiteboard (can erase and redraw)
```

---

```dart
@override
State<PortfolioScreen> createState() => _PortfolioScreenState();
```

**What's happening:**
- `createState()` - Required method for StatefulWidget
- `State<PortfolioScreen>` - Return type (State object for this widget)
- `_PortfolioScreenState()` - Creates the State object
- `=>` - Arrow function (shorthand for `return`)

**Why separate State class?**
- Widget describes WHAT to show
- State manages HOW it changes
- Separation of concerns

---

## 🔧 **Part 4: State Class - The Brain**

```dart
class _PortfolioScreenState extends State<PortfolioScreen> {
```

**Breaking it down:**
- `_PortfolioScreenState` - Underscore = private (only this file can use it)
- `extends State<PortfolioScreen>` - This is the State for PortfolioScreen
- Generic `<PortfolioScreen>` - Type safety (connects State to Widget)

---

### **State Variables - The Memory**

```dart
String userName = "Alex Developer";
```

**What it is:** A mutable variable that stores the user's name  
**Type:** `String` - Text data  
**Initial value:** "Alex Developer"  
**Why mutable?** We want to change it when user edits

---

```dart
bool isEditing = false;
```

**What it is:** Flag to track edit mode  
**Type:** `bool` - Boolean (true/false)  
**Initial value:** `false` - Start in view mode  
**Used for:** Conditional rendering (show TextField or Text)

**Think of it as:** A light switch (on/off)

---

```dart
late final TextEditingController _nameController;
```

**Breaking it down:**
- `late` - "I'll initialize this later, but before I use it"
- `final` - Once initialized, can't be reassigned
- `TextEditingController` - Class that manages text input
- `_nameController` - Private variable (underscore)

**What is TextEditingController?**
- Remote control for TextField
- Can: read text, set text, listen to changes, clear text
- MUST be disposed (cleaned up) to prevent memory leaks

**Why `late`?**
We initialize it in `initState()`, not here. `late` tells Dart: "Trust me, I'll set this before using it"

---

```dart
final List<Map<String, String>> portfolioEntries = [
```

**Breaking this down:**

**`final`** - Can't reassign the list itself (but can modify contents)

**`List`** - Ordered collection of items
```dart
Example: [item1, item2, item3]
```

**`Map<String, String>`** - Key-value pairs
```dart
Example: {'key': 'value', 'name': 'Alex'}
```

**`List<Map<String, String>>`** - List of Maps
```dart
Example: [
  {'title': 'Project 1', 'subtitle': 'Description 1'},
  {'title': 'Project 2', 'subtitle': 'Description 2'}
]
```

**Why this structure?**
Each portfolio entry is a Map with title and subtitle

---

```dart
{
  'title': 'Flutter Developer (Workshop)',
  'subtitle': 'Built interactive UI screens...',
},
```

**Structure:**
- `'title'` - Key (string)
- `'Flutter Developer (Workshop)'` - Value (string)
- `:` - Separates key from value
- `,` - Separates pairs

**Access example:**
```dart
portfolioEntries[0]['title']  // Returns: 'Flutter Developer (Workshop)'
```

---

## ♻️ **Part 5: Lifecycle Methods**

```dart
@override
void initState() {
  super.initState();
  _nameController = TextEditingController(text: userName);
}
```

**What is initState()?**
- Called ONCE when widget is first created
- Perfect for: initializing controllers, loading data, starting timers
- Happens BEFORE the first build()

**Line by line:**
- `super.initState()` - MUST call parent's initState first
- `_nameController = TextEditingController(...)` - Create the controller
- `text: userName` - Initialize with current userName value

**Lifecycle order:**
```
1. Constructor
2. initState() ← We are here
3. build()
4. (user interacts)
5. setState() → build() again
6. dispose()
```

---

```dart
@override
void dispose() {
  _nameController.dispose();
  super.dispose();
}
```

**What is dispose()?**
- Called when widget is PERMANENTLY removed
- Clean up: controllers, streams, timers, listeners
- Prevents memory leaks

**Why dispose controllers?**
TextEditingController uses resources (memory, listeners). If you don't dispose:
- ❌ Memory leak
- ❌ App gets slower
- ❌ Eventually crashes

**Order matters:**
1. Dispose your stuff FIRST
2. Then call super.dispose()

---

## 🔄 **Part 6: State Update Function**

```dart
void _toggleEdit() {
```

**Naming convention:** 
- Underscore `_` = private method
- `toggleEdit` = descriptive name
- camelCase naming

---

```dart
setState(() {
```

**What is setState()?**
- THE way to update UI in StatefulWidget
- Tells Flutter: "My data changed, please rebuild!"
- MUST wrap all state changes

**How it works:**
```
1. You call setState()
2. Flutter marks widget as "dirty"
3. Flutter calls build() again
4. New UI appears on screen
```

**Without setState:**
```dart
userName = "New Name";  // ❌ UI won't update
```

**With setState:**
```dart
setState(() {
  userName = "New Name";  // ✅ UI updates!
});
```

---

```dart
if (isEditing) {
  userName = _nameController.text;
}
```

**What's happening:**
- `if (isEditing)` - Check if we're in edit mode
- `userName = _nameController.text` - Save the typed text
- `.text` - Gets current text from controller

**Flow:**
```
User types "John" → 
Controller stores "John" → 
User clicks ✓ → 
We copy "John" to userName → 
UI shows "John"
```

---

```dart
isEditing = !isEditing;
```

**What's `!`?**
- NOT operator (reverses boolean)
- `!true` = `false`
- `!false` = `true`

**Effect:**
```
First click:  false → true  (Enter edit mode)
Second click: true → false  (Exit edit mode)
```

**Think of it as:** Toggling a light switch

---

## 🎨 **Part 7: Build Method - The UI**

```dart
@override
Widget build(BuildContext context) {
```

**What is build()?**
- REQUIRED method in all widgets
- Describes what the UI looks like
- Called when: widget is created, setState() called, parent rebuilds

**How often does it run?**
- Initial: 1 time
- Every setState(): 1 time
- Could run 100+ times in an app's lifetime

**Important:** build() should be FAST and have NO side effects

---

```dart
return Scaffold(
```

**What is Scaffold?**
- Material Design screen structure
- Provides: AppBar, Body, FloatingActionButton, Drawer, BottomNavBar
- Most screens use Scaffold

**Think of it as:** The skeleton of a house (walls, roof, floor)

---

```dart
appBar: AppBar(
  title: const Text('My Flutter Portfolio'),
  backgroundColor: Colors.blueGrey.shade700,
  foregroundColor: Colors.white,
  centerTitle: true,
),
```

**AppBar:** Top bar of the app

**Properties explained:**
- `title` - Widget shown in center/left
- `const Text(...)` - Immutable text widget
- `backgroundColor` - Bar background color
- `.shade700` - Darker shade of blueGrey (100-900 scale)
- `foregroundColor` - Text/icon color
- `centerTitle: true` - Centers the title (default false on Android)

---

```dart
body: SingleChildScrollView(
```

**What is SingleChildScrollView?**
- Makes content scrollable
- Use when: content might be taller than screen
- Takes: ONE child widget

**Without it:** Content gets cut off or causes overflow errors

**Think of it as:** A scroll wheel for your content

---

```dart
padding: const EdgeInsets.all(16.0),
```

**What is EdgeInsets?**
- Defines spacing/padding
- Options:
  - `EdgeInsets.all(16)` - Same on all sides
  - `EdgeInsets.symmetric(horizontal: 16, vertical: 8)` - Different H/V
  - `EdgeInsets.only(left: 16, top: 8)` - Specific sides
  - `EdgeInsets.fromLTRB(left, top, right, bottom)` - All different

**16.0:** 
- 16 logical pixels
- `.0` makes it a double (decimal number)

---

```dart
child: Column(
```

**What is Column?**
- Arranges children VERTICALLY (top to bottom)
- Flexible: Can contain any number of children
- Counterpart: Row (horizontal)

**Visual:**
```
┌─────────┐
│ Child 1 │
├─────────┤
│ Child 2 │
├─────────┤
│ Child 3 │
└─────────┘
```

---

```dart
crossAxisAlignment: CrossAxisAlignment.stretch,
```

**What is crossAxisAlignment?**
- Controls horizontal alignment in Column
- Or vertical alignment in Row

**Options:**
- `CrossAxisAlignment.start` - Left align (default)
- `CrossAxisAlignment.center` - Center align
- `CrossAxisAlignment.end` - Right align
- `CrossAxisAlignment.stretch` - Fill width ← We use this

**Why stretch?**
Makes all children take full width

**Visual:**
```
Without stretch:         With stretch:
┌──────────┐            ┌──────────────┐
│  Child 1 │            │   Child 1    │
└──────────┘            └──────────────┘
```

---

```dart
children: <Widget>[
```

**What is children?**
- List of widgets to display
- Can contain: any number of widgets
- Must be: List<Widget> type

**`<Widget>`:** Generic type annotation (optional but good practice)

---

```dart
_buildProfileHeader(),
```

**What's happening:**
- Calling our custom method
- `_buildProfileHeader()` returns a Widget
- That widget becomes a child in the Column

**Why separate method?**
- Cleaner code
- Reusable
- Easier to read

---

```dart
const SizedBox(height: 30),
```

**What is SizedBox?**
- Box with fixed dimensions
- Use for: spacing, constraining size

**Common uses:**
```dart
SizedBox(height: 20)        // Vertical space
SizedBox(width: 20)         // Horizontal space
SizedBox(width: 100, height: 50)  // Fixed size container
SizedBox.shrink()           // Invisible widget (0x0)
```

**Why `const`?**
This SizedBox never changes, so mark it const for optimization

---

```dart
Text(
  "Portfolio Entries",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey.shade800,
  ),
),
```

**Text widget:** Displays text on screen

**TextStyle properties:**
- `fontSize: 22` - Size in logical pixels
- `fontWeight: FontWeight.bold` - Makes text bold
  - Options: `normal`, `bold`, `w100` to `w900`
- `color: Colors.blueGrey.shade800` - Text color

**Logical pixels vs physical pixels:**
- Logical: Same size across devices
- 22px looks same size on phone and tablet

---

```dart
const Divider(height: 20, thickness: 2),
```

**What is Divider?**
- Horizontal line to separate content
- Material Design component

**Properties:**
- `height: 20` - Total space (line + padding)
- `thickness: 2` - Line thickness in pixels

**Visual:**
```
Content above
────────────── ← Divider (2px thick, 20px total space)
Content below
```

---

```dart
_buildEntryList(context),
```

**Calling our method with context**
- Pass BuildContext to access theme, size, etc.
- Returns: Widget showing portfolio entries

---

## 👤 **Part 8: Profile Header Method**

```dart
Widget _buildProfileHeader() {
```

**Method signature:**
- Returns: `Widget`
- Name: `_buildProfileHeader` (private, descriptive)
- Parameters: none

**Purpose:** Extract profile UI into separate method

---

```dart
return Center(
```

**What is Center?**
- Centers its child horizontally and vertically
- Simple wrapper widget

**Effect:** Everything inside appears centered

---

```dart
child: Column(
  children: <Widget>[
```

**Nested Column inside Center**
- Center positions the Column
- Column stacks widgets vertically

---

```dart
const CircleAvatar(
  radius: 50,
  backgroundColor: Colors.blueGrey,
  child: Icon(Icons.person, size: 60, color: Colors.white),
),
```

**CircleAvatar:** Circular widget for profile pictures

**Properties:**
- `radius: 50` - Circle size (50 logical pixels from center)
- `backgroundColor` - Circle background
- `child` - Widget inside (we use an Icon)

**Icon:**
- `Icons.person` - Material Design icon
- `size: 60` - Icon size
- `color: Colors.white` - Icon color

**Visual:**
```
     ╭───────╮
    │         │
    │    👤   │  ← Icon
    │         │
     ╰───────╯
  Radius: 50px
```

---

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
```

**Row:** Horizontal arrangement

**mainAxisAlignment:**
- For Row: controls horizontal alignment
- For Column: controls vertical alignment

**MainAxisAlignment.center:** Centers children horizontally

---

```dart
isEditing
    ? SizedBox(...)
    : Text(...),
```

**Ternary Operator:** Inline if-else

**Syntax:**
```dart
condition ? valueIfTrue : valueIfFalse
```

**What's happening:**
```
If editing mode:   Show TextField
If viewing mode:   Show Text
```

**Visual flow:**
```
isEditing = false → Text("Alex Developer")
     ↓ Click edit
isEditing = true → TextField with "Alex Developer"
     ↓ Type "John"
TextField shows "John"
     ↓ Click save
isEditing = false → Text("John")
```

---

```dart
SizedBox(
  width: 200,
  child: TextField(
```

**Why SizedBox?**
TextField takes all available width. SizedBox constrains it.

**TextField:** Input field for text

---

```dart
controller: _nameController,
```

**Connects TextField to controller**
- Controller manages the text
- Two-way binding: controller ↔ TextField

---

```dart
textAlign: TextAlign.center,
```

**TextAlign options:**
- `left` - Left align (default)
- `center` - Center align ← We use
- `right` - Right align
- `justify` - Justified

---

```dart
style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
```

**Styles the text user types**
- `fontSize: 28` - Large text
- `fontWeight.w600` - Semi-bold (between normal and bold)

**Font weights:**
```
w100 - Thin
w300 - Light
w400 - Normal
w500 - Medium
w600 - Semi-bold ← We use
w700 - Bold
w900 - Black
```

---

```dart
decoration: const InputDecoration(
  border: InputBorder.none,
  isDense: true,
  contentPadding: EdgeInsets.zero,
),
```

**InputDecoration:** Customizes TextField appearance

**Properties:**
- `border: InputBorder.none` - No border line
- `isDense: true` - Reduces vertical space
- `contentPadding: EdgeInsets.zero` - No internal padding

**Why?** Make TextField look like regular Text

---

```dart
Text(
  userName,
  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
),
```

**Display mode:**
- Shows static text (not editable)
- Same styling as TextField for consistency
- Gets value from `userName` variable

---

```dart
const SizedBox(width: 8),
```

**Horizontal spacing**
- Creates 8 pixels space between name and button

---

```dart
IconButton(
  icon: Icon(isEditing ? Icons.check : Icons.edit),
  color: isEditing ? Colors.green.shade600 : Colors.blueGrey,
  onPressed: _toggleEdit,
),
```

**IconButton:** Clickable icon

**Conditional icon:**
```
Editing: ✓ (check mark)
Viewing: ✏️ (edit pencil)
```

**Conditional color:**
```
Editing: Green
Viewing: Blue-grey
```

**onPressed:** Function to call when clicked
- `_toggleEdit` - Our toggle function (no parentheses!)
- `_toggleEdit()` would call it immediately ❌
- `_toggleEdit` passes reference ✅

---

```dart
Text(
  'Mobile App Development Enthusiast',
  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
),
```

**Subtitle text:**
- Smaller font (16 vs 28)
- Grey color (de-emphasized)
- `.shade600` - Medium grey

---

## 📋 **Part 9: Entry List Method**

```dart
Widget _buildEntryList(BuildContext context) {
```

**Takes BuildContext:** Needed to access theme, size, navigation

---

```dart
return Column(
  children: portfolioEntries.map((entry) {
```

**Map function:**
- Transforms each item in a list
- `portfolioEntries.map(...)` - For each entry...
- `(entry)` - Current item (a Map)
- Returns new list of Widgets

**Example:**
```dart
['a', 'b', 'c'].map((letter) => Text(letter))
// Returns: [Text('a'), Text('b'), Text('c')]
```

---

```dart
return Card(
  margin: const EdgeInsets.only(bottom: 12),
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12)
  ),
```

**Card:** Material Design card with shadow

**Properties:**
- `margin: EdgeInsets.only(bottom: 12)` - 12px space below each card
- `elevation: 2` - Shadow depth (0-24, higher = more shadow)
- `shape: RoundedRectangleBorder(...)` - Rounded corners

**BorderRadius.circular(12):**
- All 4 corners: 12px radius
- Makes smooth rounded corners

**Visual:**
```
╭────────────╮
│    Card    │  ← elevation creates shadow
│  Content   │
╰────────────╯
```

---

```dart
child: ListTile(
```

**ListTile:** Pre-built row layout
- Common pattern: icon, title, subtitle
- Handles spacing, alignment automatically

**Structure:**
```
[Icon] Title
       Subtitle
```

---

```dart
leading: const Icon(Icons.code, color: Colors.blueGrey),
```

**leading:** Widget before title (usually Icon or Avatar)

**Icons.code:** Material icon (</> symbol)

---

```dart
title: Text(
  entry['title']!,
  style: const TextStyle(fontWeight: FontWeight.bold),
),
```

**entry['title']:**
- Access 'title' key from Map
- Returns: String value

**`!` operator:**
- Null assertion
- Says: "I KNOW this isn't null"
- If it IS null → runtime error

**Why use it?**
Map returns `String?` (might be null), but Text needs `String`

---

```dart
subtitle: Text(entry['subtitle']!),
```

**subtitle:** Smaller text below title

**Same `!` operator** for null assertion

---

```dart
}).toList(),
```

**toList():** Converts map result to List

**Why needed?**
- `map()` returns Iterable
- `children` needs List<Widget>
- `toList()` converts Iterable → List

**Full transformation:**
```dart
portfolioEntries          // List<Map<String, String>>
  .map((entry) => Card)   // Iterable<Card>
  .toList()               // List<Card>
```

---

## 🎓 **Key Concepts Summary**

### **1. Widget Tree**
```
PortfolioApp
  └─ MaterialApp
      └─ PortfolioScreen
          └─ Scaffold
              ├─ AppBar
              └─ Body
                  └─ Column
                      ├─ ProfileHeader
                      └─ EntryList
```

### **2. State Management Flow**
```
User clicks edit button
  → onPressed: _toggleEdit
    → setState(() {...})
      → isEditing = !isEditing
        → build() called
          → UI rebuilds
            → Shows TextField or Text
```

### **3. Controller Lifecycle**
```
initState()
  → Create controller
    → Use controller
      → User types
        → Controller stores text
          → Click save
            → Read controller.text
              → dispose()
                → Cleanup controller
```

### **4. Data Flow**
```
portfolioEntries (List)
  → .map() transforms each item
    → Card widget created
      → ListTile displays data
        → .toList() finalizes
          → Column shows all cards
```

---

## 💡 **Common Patterns Used**

### **1. Const Optimization**
```dart
const Text('Hello')  // ✅ Better performance
Text('Hello')        // ✅ Works but slower
```

### **2. Private Methods/Variables**
```dart
_buildHeader()  // ✅ Private (only this file)
buildHeader()   // ✅ Public (any file can access)
```

### **3. Null Safety**
```dart
entry['title']!  // ✅ Assert non-null
entry['title']?  // ✅ Safe access (returns null if missing)
```

### **4. Arrow Functions**
```dart
() => print('hello')     // Single expression
() { print('hello'); }   // Multiple statements
```

### **5. Method Extraction**
```dart
// ❌ Everything in build()
Widget build(BuildContext context) {
  return Column(children: [
    // 200 lines of code...
  ]);
}

// ✅ Extracted methods
Widget build(BuildContext context) {
  return Column(children: [
    _buildHeader(),
    _buildList(),
  ]);
}
```

---

## 🐛 **What Could Go Wrong?**

### **1. Forgetting setState()**
```dart
// ❌ UI won't update
userName = "New Name";

// ✅ UI updates
setState(() {
  userName = "New Name";
});
```

### **2. Not Disposing Controller**
```dart
// ❌ Memory leak
// (No dispose)

// ✅ Proper cleanup
@override
void dispose() {
  _nameController.dispose();
  super.dispose();
}
```

### **3. Using ! on Null**
```dart
Map<String, String?> entry = {'title': null};
Text(entry['title']!)  // ❌ Runtime error!
Text(entry['title'] ?? 'Default')  // ✅ Safe
```

### **4. Calling setState After Dispose**
```dart
// ❌ Error: setState after dispose
dispose() {
  someAsyncFunction().then((_) {
    setState(() {});  // Widget already disposed!
  });
}

// ✅ Check if mounted
if (mounted) {
  setState(() {});
}
```

---

## 📚 **Every Widget/Concept Used**

| Concept | Purpose | Example |
|---------|---------|---------|
| **StatelessWidget** | Immutable UI | App structure |
| **StatefulWidget** | Mutable UI | Editable screen |
| **MaterialApp** | App root | Theme, routing |
| **Scaffold** | Screen structure | AppBar + Body |
| **AppBar** | Top bar | Title, actions |
| **Column** | Vertical layout | Stack widgets |
| **Row** | Horizontal layout | Side by side |
| **Text** | Display text | Labels, titles |
| **TextField** | Input text | Editable name |
| **Icon** | Display icon | Edit button |
| **IconButton** | Clickable icon | Toggle edit |
| **Card** | Material card | Portfolio items |
| **ListTile** | List row | Icon + text |
| **CircleAvatar** | Circular widget | Profile pic |
| **SizedBox** | Spacing/sizing | Gaps, constraints |
| **Center** | Center widget | Profile section |
| **SingleChildScrollView** | Make scrollable | Long content |
| **Divider** | Horizontal line | Separator |
| **TextEditingController** | Manage text | TextField control |
| **setState()** | Update UI | Trigger rebuild |
| **initState()** | Initialize | Setup controllers |
| **dispose()** | Cleanup | Prevent leaks |
| **BuildContext** | Widget location | Theme, navigation |

---

**This is EVERYTHING in the code explained!** 🎉

Every line, every concept, every pattern - you now understand it all!