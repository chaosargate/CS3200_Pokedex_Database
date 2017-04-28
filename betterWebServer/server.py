#!/usr/bin/env python

from sqlalchemy import create_engine
import SimpleHTTPServer
import SocketServer
import json

##############################################################################
#### Get
def getAllPokemonNames():
    return getAllHelper("SELECT pokedexNumber, name FROM Pokemon")

def getAllAbilityNames():
    return getAllHelper("SELECT abilityId, abilityName FROM Ability")

def getAllMoveNames():
    return getAllHelper("SELECT moveId, moveName FROM Moves")

def getAllTypeNames():
    return getAllHelper("SELECT * FROM type")

def getAllClassNames():
    return getAllHelper("SELECT * FROM Class")

def getAllMethodNames():
    return getAllHelper("SELECT * FROM Method")

def getAllHelper(selectString):
    resultArray = []
    resultArray.append(["ID", "Name"])

    for (id, name) in conn.execute(selectString):
        resultArray.append([id, name])

    return json.dumps(resultArray)


#### Search
def getPokemonFromId(id):
    selectString = getPokemonSelectString()
    if id != "all":
        selectString += " WHERE pokedexNumber =" + id + ";"

    return getPokemonHelper(selectString)


def getPokemonFromName(name):
    selectString = getPokemonSelectString()
    if id != "all":
        selectString += " WHERE name = '" + name + "';"

    return getPokemonHelper(selectString)


def getPokemonSelectString():
    return "SELECT pokedexNumber, name, hp, attack, defense, specialAttack, specialDefense, speed FROM pokemon"


def getPokemonHelper(selectString):
    resultArray = []
    resultArray.append(['Pokedex Number', 'Name', 'HP', 'Attack', 'Defense', 'Special Attack', 'Special Defense', 'Speed'])

    for (pokedexId, name, hp, attack, defense, specialAttack, specialDefense, speed) in conn.execute(selectString):
        resultArray.append([pokedexId, name, hp, attack, defense, specialAttack, specialDefense, speed])

    return resultArray



def getPokemonEvolvesIntoById(id):
    selectString = "SELECT name, methodDescription, levelRequirement " \
                   "FROM evolutions, method, pokemon " \
                   "WHERE Evolutions.endPokemonId = Pokemon.pokedexNumber " \
                   "AND Method.methodId = Evolutions.methodId " \
                   "AND startPokemonId = '" + id + "';"
    return getPokemonEvolvesHelper(id, selectString)


def getPokemonEvolvesFromById(id):
    selectString = "SELECT name, methodDescription, levelRequirement " \
                   "FROM evolutions, method, pokemon " \
                   "WHERE Evolutions.startPokemonId = Pokemon.pokedexNumber " \
                   "AND Method.methodId = Evolutions.methodId " \
                   "AND endPokemonId = " + id + ";"
    return getPokemonEvolvesHelper(id, selectString)


def getPokemonEvolvesHelper(id, selectString):
    resultArray = []
    resultArray.append(['Name', 'Method', 'Level Requirement'])

    for (name, methodDescription, levelRequirement) in conn.execute(selectString):
        resultArray.append([name, methodDescription, levelRequirement])

    return resultArray


def getPokemonMoveAcquisitionById(id):
    selectString = "SELECT DISTINCT moveName, methodDescription, level " \
                   "FROM MoveAcquisitions, Moves, Method " \
                   "WHERE pokemonId = " + id + " " \
                   "AND MoveAcquisitions.moveId = Moves.moveId " \
                   "AND MoveAcquisitions.methodId = Method.methodId " \
                   "GROUP BY moveName " \
                   "ORDER BY level;"

    resultArray = []
    resultArray.append(['Name', 'Method', 'Level Requirement'])

    for (name, methodDescription, levelRequirement) in conn.execute(selectString):
        resultArray.append([name, methodDescription, levelRequirement])

    return resultArray


def getMoveById(id):
    selectString = getMoveSelectString()
    if id != "all":
        selectString += " AND moveId=" + id + ""
    selectString +=  " ORDER BY moveId"

    return getMoveHelper(selectString)


def getMoveByName(name):
    selectString = getMoveSelectString()
    if id != "all":
        selectString += " AND moveName='" + name + "'"
    selectString +=  " ORDER BY moveId"

    return getMoveHelper(selectString)


def getMoveSelectString():
    return "SELECT moveName, power, pp, accuracy, classDescription, typeName " \
            "FROM moves, class, type " \
            "WHERE moves.classId = class.classId AND moves.typeId = type.typeId"


def getMoveHelper(selectString):
    resultArray = []
    resultArray.append(["Move Name", "Power", "PP", "Accuracy", "Class", "Type"])

    for (moveName, power, pp, accuracy, classDesc, typeName) in conn.execute(selectString):
        resultArray.append([moveName, power, pp, accuracy, classDesc, typeName])

    return resultArray


def getTypeByName(name):
    selectString = "SELECT * FROM type where typeName='" + type + "';"

    resultArray = []
    resultArray.append(["Type ID", "Name"])
    for (id, name) in conn.execute(selectString):
        resultArray.append([id, name])

    return resultArray


#### Create
def createPokemon(pokedexId,
                  name,
                  hp,
                  attack,
                  defense,
                  specialAttack,
                  specialDefense,
                  speed,
                  type1,
                  type2,
                  ability1,
                  ability2,
                  ability3):
    insertString = "INSERT INTO pokemon VALUES (" + \
                   pokedexId + ", '" + \
                   name + "', " + \
                   hp + ", " + \
                   attack + ", " + \
                   defense + ", " + \
                   specialAttack + ", " + \
                   specialDefense + ", " + \
                   speed + ", " + \
                   type1 + ", " + \
                   type2 + ", " + \
                   ability1 + ", " + \
                   ability2 + ", " + \
                   ability3 + ");"

    conn.execute(insertString)

    return getPokemonFromId(pokedexId)


def createNewType(type):
    insertString = "INSERT INTO type(typeName) VALUES('" + type + "');"
    conn.execute(insertString)

    return getTypeByName(type)


def createMove(moveName, power, pp, accuracy, moveClass, moveType):
    moveName = moveName.replace("%20", " ")
    insertString = "INSERT INTO Moves(moveName, power, pp, accuracy, classId, typeId) " + \
                   "VALUES('" + moveName + "', " + \
                                power + ", " + \
                                pp + ", " + \
                                accuracy + ", " + \
                                moveClass + ", " + \
                                moveType + ");"
    print insertString
    conn.execute(insertString)

    return getMoveByName(moveName)


def createEvolution(startPokemonId, endPokemonId, methodId, levelRequirement):
    insertString = "INSERT INTO Evolutions(startPokemonId, endPokemonId, methodId, levelRequirement) " + \
                   "VALUES(" + startPokemonId + ", " + \
                               endPokemonId + ", " + \
                               methodId + ", " + \
                               levelRequirement + ");"
    conn.execute(insertString)

    return getPokemonEvolvesIntoById(startPokemonId)


def createMoveAcquisition(pokemonId, moveId, methodId, level):
    insertString = "INSERT INTO MoveAcquisitions(pokemonId, moveId, methodId, level) " + \
                   "VALUES(" + pokemonId + ", " + \
                               moveId + ", " + \
                               methodId + ", " + \
                               level + ");"
    conn.execute(insertString)

    return getPokemonMoveAcquisitionById(pokemonId)


#### Delete
def deletePokemon(id):
    pokemonToDelete = getPokemonFromId(id)

    deleteString = "DELETE FROM Pokemon WHERE pokedexNumber = " + id + ";"
    conn.execute(deleteString)

    return pokemonToDelete


def deleteType(type):
    typeToDelete = getTypeByName(type)

    deleteString = "DELETE FROM Type WHERE typeName = '" + type + "';"
    conn.execute(deleteString)

    return typeToDelete


def deleteMove(move):
    moveToDelete = getMoveById(move)

    deleteString = "DELETE FROM Moves WHERE moveId = " + move + ";"
    conn.execute(deleteString)

    return moveToDelete


def deleteEvolution(startPokemonId, endPokemonId):
    evolutionToDelete = getPokemonEvolvesIntoById(startPokemonId)

    deleteString = "DELETE FROM Evolutions " \
                   "WHERE startPokemonId = " + startPokemonId + " " \
                   "AND endPokemonId = " + endPokemonId + ";"
    conn.execute(deleteString)

    return evolutionToDelete


def deleteMoveAcquisition(pokemonId, moveId):
    deleteString = "DELETE FROM MoveAcquisitions " \
                   "WHERE pokemonId = " + pokemonId + " " \
                   "AND moveId = " + moveId + ";"
    conn.execute(deleteString)

    return getPokemonMoveAcquisitionById(pokemonId)


#### Update
def updatePokemon(pokedexNumber,
                  name,
                  hp,
                  attack,
                  defense,
                  specialAttack,
                  specialDefense,
                  speed,
                  type1,
                  type2,
                  ability1,
                  ability2,
                  ability3):
    updateString = "UPDATE pokemon SET "

    updateString = addToStringIfNotNA_String(updateString, "pokedexNumber", pokedexNumber)
    updateString = addToStringIfNotNA_String(updateString, "hp", hp)
    updateString = addToStringIfNotNA_String(updateString, "attack", attack)
    updateString = addToStringIfNotNA_String(updateString, "defense", defense)
    updateString = addToStringIfNotNA_String(updateString, "specialAttack", specialAttack)
    updateString = addToStringIfNotNA_String(updateString, "specialDefense", specialDefense)
    updateString = addToStringIfNotNA_String(updateString, "speed", speed)
    updateString = addToStringIfNotNA_String(updateString, "type1", type1)
    updateString = addToStringIfNotNA_String(updateString, "type2", type2)
    updateString = addToStringIfNotNA_String(updateString, "ability1", ability1)
    updateString = addToStringIfNotNA_String(updateString, "ability2", ability2)
    updateString = addToStringIfNotNA_String(updateString, "ability3", ability3)
    updateString = cutOffTrailingCommaAndSpace(updateString)

    # add check to see if there's anything to modify?
    updateString = updateString + " WHERE name = '" + name + "';"
    print updateString
    conn.execute(updateString)

    return getPokemonFromName(name)


def updateMove(moveName,
               power,
               pp,
               accuracy,
               classId,
               typeId):
    updateString = "UPDATE Moves SET "

    updateString = addToStringIfNotNA_String(updateString, "power", power)
    updateString = addToStringIfNotNA_String(updateString, "pp", pp)
    updateString = addToStringIfNotNA_String(updateString, "accuracy", accuracy)
    updateString = addToStringIfNotNA_String(updateString, "classId", classId)
    updateString = addToStringIfNotNA_String(updateString, "typeId", typeId)
    updateString = cutOffTrailingCommaAndSpace(updateString)

    # add check to see if there's anything to modify?
    updateString = updateString + " WHERE moveName = '" + moveName + "';"
    conn.execute(updateString)

    return getMoveByName(moveName)


def updateType(type, newName):
    updateString = "UPDATE type SET typeName='" + newName + "' WHERE typeName='" + type + "';"
    conn.execute(updateString)

    return getTypeByName(newName)


def updateEvolution(startPokemonId, endPokemonId, methodId, levelRequirement):
    updateString = "UPDATE Evolutions SET "

    updateString = addToStringIfNotNA_String(updateString, "startPokemonId", startPokemonId)
    updateString = addToStringIfNotNA_String(updateString, "endPokemonId", endPokemonId)
    updateString = addToStringIfNotNA_String(updateString, "methodId", methodId)
    updateString = addToStringIfNotNA_String(updateString, "levelRequirement", levelRequirement)
    updateString = cutOffTrailingCommaAndSpace(updateString)

    # add check to see if there's anything to modify?
    updateString = updateString + " WHERE startPokemonId = " + startPokemonId + " " \
                                  "AND endPokemonId = " + endPokemonId + ";"
    conn.execute(updateString)

    return getPokemonEvolvesIntoById(startPokemonId)


def updateMoveAcquisition(pokemonId, moveId, methodId, level):
    updateString = "UPDATE MoveAcquisitions SET "

    updateString = addToStringIfNotNA_String(updateString, "methodId", methodId)
    updateString = addToStringIfNotNA_String(updateString, "level", level)
    updateString = cutOffTrailingCommaAndSpace(updateString)

    # add check to see if there's anything to modify?
    updateString = updateString + " WHERE pokemonId = " + pokemonId + " " \
                                  "AND moveId = " + moveId + ";"
    conn.execute(updateString)

    return getPokemonMoveAcquisitionById(pokemonId)


##############################################################################
#### Helpers
def htmlTableMaker(givenArray):
    table = "<table style='width:100%' border='1'>"
    for i in givenArray:
        table += "<tr>"
        for j in i:
            table += "<td>" + str(j) + "</td>"
        table += "</tr>"
    table += "</table>[END]"
    return table


def goodResponseWithMessage(self, message):
    return SimpleHTTPServer.SimpleHTTPRequestHandler.send_response(self, RESPONSE_CODE_GOOD, message)


def getArgValue(array, index):
    return array[index].split("=")[1]


def isNotEqualToNA_String(string):
    return string != NA_String


def addToStringIfNotNA_String(string, name, value):
    if isNotEqualToNA_String(value):
        string = string + name + " = " + value + ", "

    return string


def cutOffTrailingCommaAndSpace(string):
    if (string[-2:] == ", "):
        string = string[0:-2]

    return string


##############################################################################
class MyRequestHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):

    def do_GET(self):
        self.send_response(RESPONSE_CODE_GOOD)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()

        #### Get
        if pokemonGetAllString in self.path:
            return goodResponseWithMessage(self, getAllPokemonNames())

        if movesGetAllString in self.path:
            return goodResponseWithMessage(self, getAllMoveNames())

        if typeGetAllString in self.path:
            return goodResponseWithMessage(self, getAllTypeNames())

        if abilityGetAllString in self.path:
            return goodResponseWithMessage(self, getAllAbilityNames())

        if classesGetAllString in self.path:
            return goodResponseWithMessage(self, getAllClassNames())

        if methodGetAllString in self.path:
            return goodResponseWithMessage(self, getAllMethodNames())

        #### Search
        if pokemonSearchString in self.path:
            id = self.path.split(pokemonSearchString)[-1]
            if id != 'all':
                str = htmlTableMaker(getPokemonFromId(id))[0:-5] + "<br>" + htmlTableMaker(getPokemonMoveAcquisitionById(id))
                return goodResponseWithMessage(self, str)
            else:
                return goodResponseWithMessage(self, htmlTableMaker(getPokemonFromId(id)))

        if movesSearchString in self.path:
            id = self.path.split(movesSearchString)[-1]
            return goodResponseWithMessage(self, htmlTableMaker(getMoveById(id)))

        if pokemonEvolvesIntoSearchString in self.path:
            id = self.path.split(pokemonEvolvesIntoSearchString)[-1]
            return goodResponseWithMessage(self, htmlTableMaker(getPokemonEvolvesIntoById(id)))

        if pokemonEvolvesFromSearchString in self.path:
            id = self.path.split(pokemonEvolvesFromSearchString)[-1]
            return goodResponseWithMessage(self, htmlTableMaker(getPokemonEvolvesFromById(id)))

        if pokemonMoveAcquisitionSearchString in self.path:
            id = self.path.split(pokemonMoveAcquisitionSearchString)[-1]
            return goodResponseWithMessage(self, htmlTableMaker(getPokemonMoveAcquisitionById(id)))

        #### Create
        if pokemonCreateString in self.path:
            paramsOnlyString = self.path.split(pokemonCreateString)[-1]
            fieldsString = paramsOnlyString.split("&")
            pokedexNumber  = getArgValue(fieldsString, 0)
            name           = getArgValue(fieldsString, 1)
            hp             = getArgValue(fieldsString, 2)
            attack         = getArgValue(fieldsString, 3)
            defense        = getArgValue(fieldsString, 4)
            specialAttack  = getArgValue(fieldsString, 5)
            specialDefense = getArgValue(fieldsString, 6)
            speed          = getArgValue(fieldsString, 7)
            type1          = getArgValue(fieldsString, 8)
            type2          = getArgValue(fieldsString, 9)
            ability1       = getArgValue(fieldsString, 10)
            ability2       = getArgValue(fieldsString, 11)
            ability3       = getArgValue(fieldsString, 12)
            return goodResponseWithMessage(self, htmlTableMaker(createPokemon(pokedexNumber,
                                                                              name,
                                                                              hp,
                                                                              attack,
                                                                              defense,
                                                                              specialAttack,
                                                                              specialDefense,
                                                                              speed,
                                                                              type1,
                                                                              type2,
                                                                              ability1,
                                                                              ability2,
                                                                              ability3)))

        if typeCreateString in self.path:
            type = self.path.split(typeCreateString)[-1]
            return goodResponseWithMessage(self, htmlTableMaker(createNewType(type)))

        if evolutionCreateString in self.path:
            paramsOnlyString = self.path.split(evolutionCreateString)[-1]
            fieldsString = paramsOnlyString.split("&")
            startPokemonId   = getArgValue(fieldsString, 0)
            endPokemonId     = getArgValue(fieldsString, 1)
            methodId         = getArgValue(fieldsString, 2)
            levelRequirement = getArgValue(fieldsString, 3)

            return goodResponseWithMessage(self, htmlTableMaker(createEvolution(startPokemonId,
                                                                                endPokemonId,
                                                                                methodId,
                                                                                levelRequirement)))

        if moveCreateString in self.path:
            paramsOnlyString = self.path.split(moveCreateString)[-1]
            fieldsString = paramsOnlyString.split("&")
            moveName  = getArgValue(fieldsString, 0)
            power     = getArgValue(fieldsString, 1)
            pp        = getArgValue(fieldsString, 2)
            accuracy  = getArgValue(fieldsString, 3)
            classId   = getArgValue(fieldsString, 4)
            typeId    = getArgValue(fieldsString, 5)
            return goodResponseWithMessage(self, htmlTableMaker(createMove(moveName,
                                                                           power,
                                                                           pp,
                                                                           accuracy,
                                                                           classId,
                                                                           typeId)))

        if moveAcquisitionCreateString in self.path:
            paramsOnlyString = self.path.split(moveAcquisitionCreateString)[-1]
            fieldsString = paramsOnlyString.split("&")
            pokemonId = getArgValue(fieldsString, 0)
            moveId    = getArgValue(fieldsString, 1)
            methodId  = getArgValue(fieldsString, 2)
            level     = getArgValue(fieldsString, 3)

            return goodResponseWithMessage(self, htmlTableMaker(createMoveAcquisition(pokemonId,
                                                                                      moveId,
                                                                                      methodId,
                                                                                      level)))
        #### Delete
        if pokemonDeleteString in self.path:
            id = self.path.split(pokemonDeleteString)[-1]
            return goodResponseWithMessage(self, htmlTableMaker(deletePokemon(id)))

        if typeDeleteString in self.path:
            typeString = self.path.split(typeDeleteString)[-1]
            return goodResponseWithMessage(self, htmlTableMaker(deleteType(typeString)))

        if moveDeleteString in self.path:
            moveString = self.path.split(moveDeleteString)[-1]
            return goodResponseWithMessage(self, htmlTableMaker(deleteMove(moveString)))

        if evolutionDeleteString in self.path:
            evolutionString = self.path.split(evolutionDeleteString)[-1]
            paramsOnlyString = self.path.split(evolutionDeleteString)[-1]
            fieldsString = paramsOnlyString.split("&")
            startPokemonId   = getArgValue(fieldsString, 0)
            endPokemonId     = getArgValue(fieldsString, 1)

            return goodResponseWithMessage(self, htmlTableMaker(deleteEvolution(startPokemonId,
                                                                                endPokemonId)))

        if moveAcquisitionDeleteString in self.path:
            paramsOnlyString = self.path.split(moveAcquisitionDeleteString)[-1]
            fieldsString = paramsOnlyString.split("&")
            pokemonId = getArgValue(fieldsString, 0)
            moveId    = getArgValue(fieldsString, 1)
            return goodResponseWithMessage(self, htmlTableMaker(deleteMoveAcquisition(pokemonId,
                                                                                      moveId)))

        #### Update
        if pokemonUpdateString in self.path:
            paramsOnlyString = self.path.split(pokemonUpdateString)[-1]
            fieldsString = paramsOnlyString.split("&")
            pokedexNumber  = getArgValue(fieldsString, 0)
            name           = getArgValue(fieldsString, 1)
            hp             = getArgValue(fieldsString, 2)
            attack         = getArgValue(fieldsString, 3)
            defense        = getArgValue(fieldsString, 4)
            specialAttack  = getArgValue(fieldsString, 5)
            specialDefense = getArgValue(fieldsString, 6)
            speed          = getArgValue(fieldsString, 7)
            type1          = getArgValue(fieldsString, 8)
            type2          = getArgValue(fieldsString, 9)
            ability1       = getArgValue(fieldsString, 10)
            ability2       = getArgValue(fieldsString, 11)
            ability3       = getArgValue(fieldsString, 12)
            return goodResponseWithMessage(self, htmlTableMaker(updatePokemon(pokedexNumber,
                                                                              name,
                                                                              hp,
                                                                              attack,
                                                                              defense,
                                                                              specialAttack,
                                                                              specialDefense,
                                                                              speed,
                                                                              type1,
                                                                              type2,
                                                                              ability1,
                                                                              ability2,
                                                                              ability3)))
        if typeUpdateString in self.path:
            typeString, newName = self.path.split(typeUpdateString)[-1].split("&&")
            return goodResponseWithMessage(self, htmlTableMaker(updateType(typeString, newName)))

        if moveUpdateString in self.path:
            paramsOnlyString = self.path.split(moveUpdateString)[-1]
            fieldsString = paramsOnlyString.split("&")
            moveName  = getArgValue(fieldsString, 0)
            power     = getArgValue(fieldsString, 1)
            pp        = getArgValue(fieldsString, 2)
            accuracy  = getArgValue(fieldsString, 3)
            classId   = getArgValue(fieldsString, 4)
            typeId    = getArgValue(fieldsString, 5)
            return goodResponseWithMessage(self, htmlTableMaker(updateMove(moveName,
                                                                           power,
                                                                           pp,
                                                                           accuracy,
                                                                           classId,
                                                                           typeId)))

        if evolutionUpdateString in self.path:
            paramsOnlyString = self.path.split(evolutionUpdateString)[-1]
            fieldsString = paramsOnlyString.split("&")
            startPokemonId   = getArgValue(fieldsString, 0)
            endPokemonId     = getArgValue(fieldsString, 1)
            methodId         = getArgValue(fieldsString, 2)
            levelRequirement = getArgValue(fieldsString, 3)

            return goodResponseWithMessage(self, htmlTableMaker(updateEvolution(startPokemonId,
                                                                                endPokemonId,
                                                                                methodId,
                                                                                levelRequirement)))

        if moveAcquisitionUpdateString in self.path:
            paramsOnlyString = self.path.split(moveAcquisitionUpdateString)[-1]
            fieldsString = paramsOnlyString.split("&")
            pokemonId = getArgValue(fieldsString, 0)
            moveId        = getArgValue(fieldsString, 1)
            methodId      = getArgValue(fieldsString, 2)
            level         = getArgValue(fieldsString, 3)

            return goodResponseWithMessage(self, htmlTableMaker(updateMoveAcquisition(pokemonId,
                                                                                      moveId,
                                                                                      methodId,
                                                                                      level)))
        return goodResponseWithMessage(self, "ERROR")

##############################################################################
#### Connection settings
settings = {
    'userName': "root",
    'password': "",
    'serverName': "localhost",
    'portNumber': 3307,
    'dbName': "pokemon",
}

pokemonGetAllString   = "getAllPokemon?="
movesGetAllString     = "getAllMoves?="
typeGetAllString      = "getAllTypes?="
abilityGetAllString   = "getAllAbilities?="
classesGetAllString   = "getAllClasses?="
methodGetAllString    = "getAllMethods?="

pokemonSearchString   = "searchPokemon?="
movesSearchString     = "searchMove?="
pokemonEvolvesIntoSearchString = "pokemonEvolvesInto?="
pokemonEvolvesFromSearchString = "pokemonEvolvesFrom?="
pokemonMoveAcquisitionSearchString = "searchPokemonMoveAcquisition?="

pokemonCreateString   = "pokemonAdd?="
typeCreateString      = "newType?="
moveCreateString      = "moveAdd?="
evolutionCreateString = "evolutionAdd?="
moveAcquisitionCreateString = "moveAcquisitionAdd?="

pokemonDeleteString   = "pokemonDelete?="
typeDeleteString      = "delType?="
moveDeleteString      = "moveDelete?="
evolutionDeleteString = "evolutionDelete?="
moveAcquisitionDeleteString = "moveAcquisitionDelete?="

pokemonUpdateString   = "pokemonUpdate?="
typeUpdateString      = "updateType?="
moveUpdateString      = "moveUpdate?="
evolutionUpdateString = "evolutionUpdate?="
moveAcquisitionUpdateString = "moveAcquisitionUpdate?="

NA_String = "_NA_"

##### Connect to the database
conn = create_engine('mysql://{0[userName]}:{0[password]}@{0[serverName]}:{0[portNumber]}/{0[dbName]}'.format(settings))
print 'Connected to database'

PORT = 8000
RESPONSE_CODE_GOOD = 200

Handler = MyRequestHandler
server = SocketServer.TCPServer(('127.0.0.1', PORT), Handler)

print "Serving at port", PORT
server.serve_forever()
