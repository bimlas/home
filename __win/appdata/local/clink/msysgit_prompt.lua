-- Slower then git_prompt.lua, but using the original __git_ps1
-- ========== BimbaLaszlo(.github.io|gmail.com) ========== 2014.08.27 12:20 ==

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

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

function findsh()
    local file = io.popen("where git")
    local output = trim(file:read('*all'))
    local rc = {file:close()}
    return string.gsub(output, "cmd\\git.exe", "bin\\sh.exe")
end

function git_prompt_filter()
    if insiderepo() then
      git_prompt = clink.prompt.value
      local file = io.popen(findsh() .. " --login -c 'GIT_PS1_SHOWDIRTYSTATE=true; GIT_PS1_SHOWSTASHSTATE=true; GIT_PS1_SHOWUNTRACKEDFILES=true; GIT_PS1_SHOWUPSTREAM=true; PS1=; __git_ps1 \"%s\"'")
      local output = string.match(file:read('*all'), "[^%c]*$")
      local rc = {file:close()}

      clink.prompt.value = git_prompt .. " [" .. output .. "] "
    end

    return false
end

clink.prompt.register_filter(git_prompt_filter, 50)
