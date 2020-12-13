const matches = (await Deno.readTextFile("/dev/stdin"))
  .matchAll(/(N|S|E|W|L|R|F)(\d+)/g)


type NavigationCode = {
  code: "N"|"S"|"E"|"W"|"L"|"R"|"F"
  value: number
}

const navigationCodes = [...matches]
  .map(([,code,value]) => ({
    code,
    value: parseInt(value)
  })) as NavigationCode[]

//
// Part 1
//
{
  let ship = { x: 0, y: 0, heading: 0 }

  for (const { code, value } of navigationCodes) {
    switch(code) {
      case "N": { ship.y -= value } break;
      case "S": { ship.y += value } break;
      case "E": { ship.x += value } break;
      case "W": { ship.x -= value } break;
      case "L": { ship.heading += value } break;
      case "R": { ship.heading -= value } break;
      case "F": {
        ship.x += value * Math.round(Math.cos(ship.heading/180*Math.PI))
        ship.y += value * -Math.round(Math.sin(ship.heading/180*Math.PI))
      } break;
    }
  }

  const manhattanDistance = Math.abs(ship.x) + Math.abs(ship.y)

  console.log(`${manhattanDistance}`)
}

//
// Part 2
//
{
  let ship = { x: 0, y: 0 }
  let waypoint = { x: 10, y: -1 }

  for (const { code, value } of navigationCodes) {
    switch(code) {
      case "N": { waypoint.y -= value } break;
      case "S": { waypoint.y += value } break;
      case "E": { waypoint.x += value } break;
      case "W": { waypoint.x -= value } break;
      case "L": {
        const theta = -value / 180 * Math.PI
        waypoint = {
          x: Math.round(Math.cos(theta)*waypoint.x - Math.sin(theta)*waypoint.y),
          y: Math.round(Math.sin(theta)*waypoint.x + Math.cos(theta)*waypoint.y)
        }
      } break;
      case "R": {
        const theta = value / 180 * Math.PI
        waypoint = {
          x: Math.round(Math.cos(theta)*waypoint.x - Math.sin(theta)*waypoint.y),
          y: Math.round(Math.sin(theta)*waypoint.x + Math.cos(theta)*waypoint.y)
        }
      } break;
      case "F": {
        ship.x += value * waypoint.x
        ship.y += value * waypoint.y
      } break;
    }
  }

  const manhattanDistance = Math.abs(ship.x) + Math.abs(ship.y)

  console.log(`${manhattanDistance}`)
}
