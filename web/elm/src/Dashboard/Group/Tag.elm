module Dashboard.Group.Tag exposing (Tag(..), ordering, splitFirst, tag, text)

import Concourse
import Dict
import List.Extra
import Ordering exposing (Ordering)


type Tag
    = Exposed
    | Member


ordering : Ordering Tag
ordering =
    Ordering.explicit [ Member, Exposed ]


text : Tag -> String
text tag =
    case tag of
        Exposed ->
            "EXPOSED"

        Member ->
            "MEMBER"


splitFirst : Char -> String -> String
splitFirst delim =
    String.toList
        >> List.Extra.takeWhile ((/=) delim)
        >> String.fromList


tag : Concourse.User -> String -> Tag
tag user teamName =
    if Dict.member teamName user.teams then
        Member

    else
        Exposed
