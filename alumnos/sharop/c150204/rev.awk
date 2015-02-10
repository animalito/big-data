function rev(str, start)
{
    if (start == 0)
        return ""
    
    return (substr(str, start, 1) rev(str, start - 1))
}
