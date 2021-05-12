# Flutter keyboard focus bug on Android TV

Example project showing how we lose the focus and cannot navigate after text input with native keyboard on Android TV.

## Steps to reproduce

1. Tap "Open text input" button
2. Enter some text and tap the search icon
3. Navigate up and down buttons
4. Repeat

After 3-4 repetitions the traversal fails and the keyboard appears when select or a keyboard key is pressed.

