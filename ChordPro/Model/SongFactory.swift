//
//  SongFactory.swift
//  ChordPro
//
//  Created by Carlistle ZHENG on 8/3/19.
//  Copyright © 2019 Carlistle ZHENG. All rights reserved.
//

import Foundation
class SongFactory {
    static func getLyric(of songName: String) -> [Line] {
        var lineStrings: [String] = []
        switch songName {
        case "All Too Well":
            lineStrings.append(contentsOf: [
                "[00:00:55]D D D DU - D D D DU##Strumming##",
                "[00:00:57]Intro{{C}} C",
                "[00:03:00]Intro{{G}} G",
                "[00:05:20]Intro{{Am}} Am",
                "[00:08:00]Intro{{F}} F",
                "[00:11:57]Intro{{C}} C",
                "[00:14:80]Intro{{G}} G",
                "[00:18:30]Intro{{Am}} Am",
                "[00:16:50]Intro{{F}} F",
                "[00:20:30]D D D DF - D D D DU##Strumming##",
                "[00:20.60]I{{C}} walked through the door with you [00:23:29]the{{G}} air was cold",
                "[00:25.91]But{{Am}} something ′bout it felt like [00:28:00]home{{F}} somehow and I",
                "[00:31.51]Left{{C}} my scarf there at your [00:34:00]sister′s{{G}} house",
                "[00:35.51]And{{Am}} you still got it in your [00:38:77]drawer{{F}} even now",
                "[00:41:57]Verse{{C}} C",
                "[00:44:00]Verse{{G}} G",
                "[00:46:50]Verse{{Am}} Am",
                "[00:48:50]Verse{{F}} F",
                "[00:51:00]D D D DU - D D D DU##Strumming##",
                "[00:51.11]Oh,{{C}} your sweet disposition and my [00:54:34]wide{{G}} eyed gaze",
                "[00:56.61]We{{Am}} are singing in the car‚ getting [00:59:10]lost{{F}} upstate",
                "[01:02.11]The{{C}} Autumn leaves falling down like [00:64:67]pieces{{G}} into place",
                "[01:06.31]And{{Am}} I can picture it after [01:09:00]all{{F}} these days",
                "[01:12.02]And{{F}} I [01:12:20]know{{C}} It is long gone",
                "[01:14.22]And{{C}} that [01:15:10]magic′s{{G}} not here no more",
                "[01:17.11]And{{Am}} I might be okay",
                "[01:19.21]But{{Am}} I am not [01:20:00]fine{{G}} at all",
                "[01:21:50]Chorus{{C}} F",
                "[01:22:90]Chorus{{G}} G",
                "[01:23:80]Chorus{{Am}} Am",
                "[01:25:45]Chorus{{G}} G",
                "[01:27:60]D D D DF - D D D DU##Strumming##",
                "[01:27.92]′Cause{{C}} there we are again on that [01:30:20]little{{G}} town street",
                "[01:32.40]You{{Am}} almost ran the red ′cause you were [01:35:50]looking{{F}} over me",
                "[01:37.31]Wind{{F}} in my [01:38:10]hair,{{C}} I was there‚ I [01:40:30]remember{{G}} it all [01:42:40]too{{Am}} [01:43:60]well{{F}}",
                "[01:48:00]D D D DU - D D D DU##Strumming##",
                "[01:48.11]Photo{{C}} album on the counter‚ your cheks were turning red",
                "[01:53.01]You used to be a little kid with glasses in a twin size bed",
                "[01:58.51]And your mother′s telling stories about you on a tee ball team",
                "[02:03.11]You tell me ′bout your past‚ thinking your future was me",
                "[02:08.51]And I know It is long gone",
                "[02:11.00]And there was nothing else I could do",
                "[02:13.71]And I forget about you long enough",
                "[02:16.50]To forget why I needed to",
                "[02:24.60]′Cause there we are again in the middle of the night",
                "[02:29.51]We dance around the kitchen in the refrigerator light",
                "[02:34.30]Down the stairs‚ I was there‚ I remember it all too well‚ yeah",
                "[02:59.92]Maybe we got lost in translation‚ maybe I asked for too much",
                "[03:04.10]And maybe this thing was a masterpiece ′til you tore it all up",
                "[03:10.01]Running scared‚ I was there‚ I remember it all too well",
                "[03:20.62]Hey‚ you call me up again just to break me like a promise",
                "[03:26.00]So casually cruel in the name of being honest",
                "[03:30.80]I am a crumpled up piece of paper lying here",
                "[03:35.10]′Cause I remember it all‚ all‚ all too well",
                "[03:55.01]Time won′t fly‚ It is like I am paralyzed by it",
                "[03:59.81]I had like to be my old self again‚ but I am still trying to find it",
                "[04:05.01]After plaid shirt days and nights when you made me your own",
                "[04:09.50]Now you mail back my things and I walk home alone",
                "[04:15.40]But you keep my old scarf from that very first week",
                "[04:19.91]′Cause it reminds you of innocence and it smells like me",
                "[04:25.62]You can′t get rid of it‚ ′cause you remember it all too well‚ yeah",
                "[04:35.71]′Cause there we are again‚ when I loved you so",
                "[04:40.71]Back before you lost the one real thing You have ever known",
                "[04:45.91]It was rare‚ I was there‚ I remember it all too well",
                "[04:56.50]Wind in my hair‚ you were there‚ you remember it all",
                "[05:01.11]Down the stairs‚ you were there‚ you remember it all",
                "[05:06.41]It was rare‚ I was there‚ I remember it all too well"
                ])
        case "Perfect":
            lineStrings.append(contentsOf: [
                "[00:02.81]I found a love for me",
                "[00:10.42]Darling‚ just dive right in and follow my lead",
                "[00:17.92]Well‚ I found a girl‚ beautiful and sweet",
                "[00:25.31]Oh‚ I never knew you were the someone waiting for me",
                "[00:32.01]′Cause we were just kids when we fell in love",
                "[00:36.91]Not knowing what it was",
                "[00:40.50]I will not give you up this time",
                "[00:48.11]But darling‚ just kiss me slow‚ your heart is all I own",
                "[00:55.71]And in your eyes You are holding mine",
                "[01:02.30]Baby‚ I am dancing in the dark with you between my arms",
                "[01:13.81]Barefoot on the grass‚ listening to our favorite song",
                "[01:20.80]When you said you looked a mess‚ I whispered underneath my breath",
                "[01:27.82]But you heard it‚ darling‚ you look perfect tonight",
                "[01:41.21]Well I found a woman‚ stronger than anyone I know",
                "[01:48.80]She shares my dreams‚ I hope that someday I will share her home",
                "[01:56.42]I found a love‚ to carry more than just my secrets",
                "[02:04.41]To carry love‚ to carry children of our own",
                "[02:10.72]We are still kids‚ but We are so in love",
                "[02:15.32]Fighting against all odds",
                "[02:19.10]I know we′ll be alright this time",
                "[02:26.70]Darling‚ just hold my hand",
                "[02:30.21]Be my girl‚ I will be your man",
                "[02:34.32]I see my future in your eyes",
                "[02:40.81]Baby‚ I am dancing in the dark‚ with you between my arms",
                "[02:52.20]Barefoot on the grass‚ listening to our favorite song",
                "[02:59.31]When I saw you in that dress‚ looking so beautiful",
                "[03:05.21]I don′t deserve this‚ darling‚ you look perfect tonight",
                "[03:26.41]Baby‚ I am dancing in the dark‚ with you between my arms",
                "[03:37.61]Barefoot on the grass‚ listening to our favorite song",
                "[03:44.70]I have faith in what I see",
                "[03:48.31]Now I know I have met an angel in person",
                "[03:54.41]And she looks perfect‚ I don′t deserve this",
                "[04:02.31]You look perfect tonight"
                ])
        default:
            lineStrings.append("")
        }
        var lines: [Line] = []
        for lineString in lineStrings {
            lines.append(Line(lineString))
        }
        return lines
    }
}
