When refactoring:
1. First, identify all files touching the symbol via Grep
2. Confirm the target namespace with the user before moving code
3. Verify no backwards namespace dependencies are introduced
4. Run the full test suite after each logical step
5. NEVER touch unrelated code — leave a TODO comment instead

