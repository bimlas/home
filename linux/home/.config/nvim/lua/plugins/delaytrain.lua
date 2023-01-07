return function(use)
  use { 'ja-ford/delaytrain.nvim', config = function()
    require('delaytrain').setup()
  end
  }
end
