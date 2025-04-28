# mygrep-project-
This Repo is For the Fawry N² DevOps Internship Exam

# mygrep - Custom grep Implementation
A custom implementation of grep with case-insensitive search and additional features.

## Features

✅ **Basic Functionality**  
- Case-insensitive string search  
- Print matching lines from text files  

✅ **Command-Line Options**  
- `-n`/`--line-number` - Show line numbers  
- `-v`/`--invert-match` - Invert matching logic  
- Combined options support (`-vn`, `-nv`)  

✅ **Error Handling**  
- Missing file detection  
- Missing search string validation  
- Invalid option handling  

✅ **Bonus Features**  
- `--help` flag with examples  
- `--version` flag  
- Colorized output  
- Match statistics  
- GNU-style long options support  

## Usage

```bash
./mygrep.sh [OPTIONS] SEARCH_STRING FILE
```

## Examples

**Basic search:**
```bash
./mygrep.sh hello testfile.txt
```

**Search with line numbers:**
```bash
./mygrep.sh -n hello testfile.txt
# or
./mygrep.sh --line-number hello testfile.txt
```

**Inverted match:**
```bash
./mygrep.sh -v hello testfile.txt
# or
./mygrep.sh --invert-match hello testfile.txt
```

**Combined options:**
```bash
./mygrep.sh -vn hello testfile.txt
```

**Help and version:**
```bash
./mygrep.sh --help
./mygrep.sh --version
```

## Implementation Details

### Argument Handling
- Uses Bash parameter expansion for option parsing
- Supports both short (-v) and long (--invert-match) options
- Handles combined short options (-vn)
- Validates all input before processing

### Future Improvements
1. **Regex Support**: Would require integrating `grep -E` or `grep -P`
2. **Additional Flags**: 
   - `-i` for explicit case sensitivity control
   - `-c` for count-only output
   - `-l` for filename-only output
3. **Multi-file Support**: Process multiple input files

### Challenges
The most challenging aspects were:
- Implementing proper option parsing that handles all combinations
- Maintaining clean code while supporting all features
- Creating intuitive error messages that guide users

## Testing

The script includes comprehensive error checking. Test cases:

1. **Basic Functionality**
```bash
./mygrep.sh hello testfile.txt
```

2. **Line Numbers**
```bash
./mygrep.sh -n hello testfile.txt
```

3. **Inverted Match**
```bash
./mygrep.sh -v hello testfile.txt
```

4. **Error Handling**
```bash
./mygrep.sh -v testfile.txt  # Missing search string
./mygrep.sh hello missing.txt  # Missing file
```

## License

MIT License - Free to use and modify
