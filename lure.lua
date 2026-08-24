local lure = {
    world = {},
    window = {
        title = "Untitled",
        size = {width = 20, height = 20},
        sleep = nil, -- nil is used as a placeholder for functions
        clear = nil
    },
    draw = nil,
    addObject = nil,
    addClass = nil,
    moveObjectToClass = nil,
    removeClass = nil,
    removeObject = nil,
    getObject = nil,
    getClass = nil
}


lure.window.sleep = function(milliseconds)
    milliseconds = milliseconds / 1000
    local targetClock = os.clock() + milliseconds
    repeat
    until os.clock() >= targetClock
end

-- Checks and gets an object in world or given class
lure.getObject = function(objectName, className)
    if className then
        return lure.world[className][objectName]
    else
        return lure.world[objectName]
    end
end

-- Looks for and returns a class in the world
lure.getClass = function(className)
    return lure.world[className]
end

-- Gets rid of an object
lure.removeObject = function(object)
    object = nil
end

-- Gets rid of a class
lure.removeClass = function(class)
    class = nil
end

-- Moves an object into a class
lure.moveObjectToClass = function(object, class)
    local values = {
        ['position'] = {['x'] = object.position.x, ['y'] = object.position.y},
        ['size'] = {['width'] = object.size.width, ['height'] = object.size.height},
        ['show'] = object.show,
        ['priority'] = object.priority,
        ['character'] = object.character,
        ['name'] = object.name
    }
    object = nil
    if not class then
        lure.world[values.name] = values
    else
        class[values.name] = values
    end
end



-- Creates a new class for storing objects
lure.addClass = function(className)
    if not lure.world[className] then
        lure.world[className] = {}
    end
end

-- Creates and adds a new object to the world or a class within the world
lure.addObject = function(name, x, y, width, height, show, priority, character, class)
    local thing = {
        ['position'] = {['x'] = x, ['y'] = y}, -- Starts in bottom left and goes up and right
        ['size'] = {['width'] = width, ['height'] = height},
        ['show'] = show, -- Do show?
        ['priority'] = priority, -- Basicly z index, higher = more priority
        ['character'] = character, -- The displayed character(s)
        ['name'] = name -- the key
    }
    if not class then
        lure.world[name] = thing
    else
        if lure.world[class] then
            lure.world[class][name] = thing
        else
            lure.world[name] = thing
        end
    end
end


-- Finds the highest priority object at x and y for drawing
local function findAt(x, y)
    local output = nil
    for key, values in pairs(lure.world) do
        if type(values) == "table" then
            if values.show == true then
                if values.position.x >= x - values.size.width and values.position.x <= x then
                    if values.position.y >= y - values.size.height and values.position.y <= y then
                        if not output then
                            output = values
                        else
                            if output.priority < values.priority then
                                output = values
                            end
                        end
                    end
                end
            end
        end
        for key2, values2 in pairs(lure.world[key]) do
            if type(values2) == "table" then
                if values2.show == true then
                    if values2.position.x >= x - values2.size.width and values2.position.x <= x then
                        if values2.position.y >= y - values2.size.height and values2.position.y <= y then
                            if not output then
                                output = values2
                            else
                                if output.priority < values2.priority then
                                    output = values2
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return output
end

-- For keeping thigns clean, the console will be cleared before draw is called.
lure.window.clear = function(onWindowsMachine)
    if onWindowsMachine == true or not onWindowsMachine then
        os.execute("cls")
    else
        os.execute("clear")
    end
end

-- Draws the grid
lure.draw = function()
    lure.window.clear()
    print(lure.window.title)
    for y = lure.window.size.height, 1, -1 do
        for x = 1, lure.window.size.width do
            local flooredX, flooredY = math.floor(x), math.floor(y)
            if findAt(flooredX, flooredY) then
                io.write(findAt(flooredX, flooredY).character)
            else
                io.write("_")
            end
            io.write("  ")
        end
        print()
    end
end

return lure