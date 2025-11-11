add_rules("mode.debug", "mode.release")
set_policy("check.auto_ignore_flags", false)

local laz_sources = os.getenv("LAZARUS_PATHS")

local sources = {}

if laz_sources == nil then
    error("Expected the LAZARUS_PATHS variable to be set")
end

for str in laz_sources:gmatch("([^:]+)") do
    do
        local flag = string.format("-Fu%s", str)
        table.insert(sources, flag)
    end
    do
        local flag = string.format("-FU%s", str)
        table.insert(sources, flag)
    end
end

do
    local srcs = {
        "-Fusrc/serverprotocol",
        "-Fusrc/protocol",
        "-FUsrc/protocol",
        "-FUsrc/serverprotocol",
    }
    for _, src in pairs(srcs) do
        table.insert(sources, src)
    end
end

target("pasls")
set_kind("binary")
add_files("src/standard/pasls.lpr")
add_pcflags(table.unpack(sources, 1, sources.n))
