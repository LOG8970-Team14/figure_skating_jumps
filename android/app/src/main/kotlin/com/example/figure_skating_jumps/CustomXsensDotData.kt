package com.example.figure_skating_jumps

import com.xsens.dot.android.sdk.events.XsensDotData

class CustomXsensDotData(data: XsensDotData?) {
    private val acc: DoubleArray? = data?.acc
    private val gyr: DoubleArray? = data?.gyr
    private val time: Long? = data?.sampleTimeFine
    private val num: Int? = data?.packetCounter
}