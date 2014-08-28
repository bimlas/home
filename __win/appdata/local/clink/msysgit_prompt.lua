-- Slower then git_prompt.lua, but using the original __git_ps1
-- ========== BimbaLaszlo(.github.io|gmail.com) ========== 2014.08.27 12:20 ==

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Return true if we are in a git repository.
function insiderepo()
    local file = io.popen("git rev-parse --git-dir 2>nul")
    local output = trim(file:read('*all'))
    local rc = {file:close()}
    if output == "" then
        return false
    else
        return true
    end
end

-- Find the base directory of msysgit.
function msysgitdir()
    local file = io.popen("where git")
    local output = trim(file:read('*all'))
    local rc = {file:close()}
                                                                       -- TODO
                                                   -- replace bin\\git.exe too
    return string.gsub(output, "cmd\\git.exe", "")
end

-- Print the output of __git_ps1 to the end of the prompt.
function git_prompt_filter()
    if not insiderepo() then
      return false
    end

    -- Find msysgit at once at the start of clink and set up the command to
    -- get the output of __git_ps1.
    if cmd == nil then
      cmd = msysgitdir()                                ..
            "\\bin\\sh.exe --noprofile --norc -c "      ..
            "'PATH=/bin; source /etc/git-prompt.sh; "   ..
            "GIT_PS1_SHOWDIRTYSTATE=true; "             ..
            "GIT_PS1_SHOWSTASHSTATE=true; "             ..
            "GIT_PS1_SHOWUNTRACKEDFILES=true; "         ..
            "GIT_PS1_SHOWUPSTREAM=true; "               ..
            " __git_ps1 \"%s\"'"
    end

    local git_prompt = clink.prompt.value

    -- We need only the last line of the shell' output.
    local file = io.popen(cmd)
    local output = string.match(file:read('*all'), "[^%c]*$")
    local rc = {file:close()}

    clink.prompt.value = git_prompt .. " [" .. output .. "] "

    return false
end

clink.prompt.register_filter(git_prompt_filter, 50)
