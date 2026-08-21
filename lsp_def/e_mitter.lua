---@meta

Handy.e_mitter = {}

---@param type string
---@param callback function
---@param args? { key?: string, before?: string, after?: string, start?: boolean }
function Handy.e_mitter.on(type, callback, args) end

---@param type string
---@param ... any[] Arguments to send to callbacks
---@return boolean prevented Is any of callbacks returned `true`
function Handy.e_mitter.emit(type, ...) end

---@param type string
---@param key string
---@return boolean removed Is callback found and was removed succesfully
function Handy.e_mitter.off(type, key) end
