//
//  Global.swift
//  Wordle
//
//  Created by Hanson on 2022/4/3.
//

import UIKit

enum Global {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.size.width
    }
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.size.height
    }
    static var minDimension: CGFloat {
        min(screenWidth,screenHeight)
    }
    static var boardWidth: CGFloat {
        switch minDimension {
        case 0...320:
            return screenWidth - 55
        case 321...430:
            return screenWidth - 50
        case 431...1000:
            return 350
        default:
            return 500
        }
    }
    
    static var keyboardScale: CGFloat {
        switch minDimension {
        case 0...430:
            return screenWidth / 390
        case 431...1000:
            return CGFloat(1.2)
        default:
            return CGFloat(1.6)
        }
    }
    
    static let spaceWords = ["ACRUX", "ALGOL", "ALTAR", "ARIEL", "ARIES", "ARROW", "ATLAS", "CERES", "CETUS", "COMET", "CRANE", "DENEB", "DIONE", "DRACO", "EAGLE", "EARTH", "FLORA", "GEMMA", "HELIX", "HYDRA", "INDUS", "JANUS", "LEPUS", "LEVEL", "LIBRA", "LUPUS", "MENSA", "METIS", "MIMAS", "MUSCA", "NORMA", "OMEGA", "ORBIT", "ORION", "PLUTO", "PYXIS", "RIGEL", "RIVER", "SAILS", "SPICA", "STERN", "THEBE", "TITAN", "TWINS", "VENUS", "VESTA", "VIRGO", "WHALE"]
    
    static let spaceWords2 = ["AQUILA", "ARCHER", "AURIGA", "AUSTIN", "BOOTES", "CAELUM", "CANCER", "CARINA", "CASTOR", "CHARON", "CHIRON", "CHISEL", "CORONA", "CORVUS", "CRATER", "CYGNUS", "DEIMOS", "DIADEM", "DORADO", "DRAGON", "EUROPA", "FISHES", "FORNAX", "GALAXY", "GEMINI", "HUNTER", "HYADES", "HYDRUS", "ICARUS", "INDIAN", "JULIET", "LAGOON", "LIZARD", "METEOR", "MIMOSA", "NEBULA", "NEREID", "OBERON", "OCTANS", "OCTANT", "PALLAS", "PHOBOS", "PHOEBE", "PICTOR", "PISCES", "PLANET", "PLOUGH", "POLLUX", "PSYCHE", "PULSAR", "PUPPIS", "QUASAR", "SAPPHO", "SATURN", "SCALES", "SCUTUM", "SHIELD", "SIRIUS", "TAURUS", "TETHYS", "THALIA", "TOUCAN", "TRIFID", "TRITON", "TUCANA", "URANUS", "VIRGIN", "VOLANS"]

    static let spaceWords3 = ["CANOPUS", "CAPELLA", "CENTAUR", "CEPHEUS", "CLUSTER", "COLUMBA", "COMPASS", "DOLPHIN", "ECLIPSE", "ELECTRA", "EUTERPE", "FURNACE", "GIRAFFE", "HIDALGO", "IAPETUS", "JUPITER", "LACERTA", "MERCURY", "MIRANDA", "NEPTUNE", "PANDORA", "PEACOCK", "PEGASUS", "PERSEUS", "PHOENIX", "POLARIS", "PROCYON", "REGULUS", "ROSETTE", "SAGITTA", "SCORPIO", "SERPENS", "SERPENT", "SEXTANS", "SEXTANT", "UMBRIEL", "UNICORN"]
}
