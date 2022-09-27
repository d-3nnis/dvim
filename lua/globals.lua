DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

-- Functions --

-- @USAGE:
-- local foo = safe_require('foo')
-- if not foo then return end
_G.safe_require = function(module_name)
    local package_exists, module = pcall(require, module_name)
    if not package_exists then
        vim.defer_fn(function()
            vim.schedule(function()
                vim.notify('Could not load module: ' .. module_name, 'error', { title = 'Module Not Found' })
            end)
        end, 1000)
        return nil
    else
        return module
    end
end

-- @USAGE: :lua safe_reload('foo')
function _G.safe_reload(module)
    package.loaded[module] = nil
    return safe_require(module)
end

function _G.print_inspect(str, to_inspect)
    print(str, vim.inspect(to_inspect))
end
