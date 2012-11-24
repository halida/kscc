def init_test_data
  cs = Cheatsheet.create(title: "Half-Life", desc: "Cheatsheet for Half-Life")

  gm = cs.groups.create(name: "Movement", color: "#76D36D")
  shortcuts = {
    "a" => "move left",
    "d" => "move right",
    "w" => "move forward",
    "s" => "move backword",
  }
  shortcuts.each{|key, desc| gm.shortcuts.create(key: key, desc: desc)}

  gm = cs.groups.create(name: "Operation", color: "#6D85D3")
  shortcuts = {
    "e" => "use",
    "f" => "flash light",
    "g" => "drop weapon",
    "v" => "team",
  }
  shortcuts.each{|key, desc| gm.shortcuts.create(key: key, desc: desc)}
end

init_test_data
