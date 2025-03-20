package com.ovez.mufreak

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform