-- wiki to learn neorg: https://github.com/nvim-neorg/neorg/wiki
-- Youtube learn playlist: https://www.youtube.com/playlist?list=PLx2ksyallYzVI8CN1JMXhEf62j2AijeDa
return {
  'nvim-neorg/neorg',
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = '*', -- Pin Neorg to the latest stable release
  config = true,
}
