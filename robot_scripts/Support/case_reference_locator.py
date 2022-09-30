def extract_reference_number(text, heading="CCMS Reference"):
    """
    Cypress script includes case reference to the console output like this:
    over two lines:
    CCMS Reference
    300001347374
    
    Find and return the case reference from suplied text based on the position of
    the heading and assumption that each is on consecutive line.
    """
    reference = ""
    pos = text.find(heading)
    if pos == -1:
        # Could add error message for missing heading
        pass
    else:
        newline_pos1 = text.find("\n", pos)
        newline_pos2 = text.find("\n", newline_pos1 + 1)
        reference = text[newline_pos1:newline_pos2].strip()
    return reference
