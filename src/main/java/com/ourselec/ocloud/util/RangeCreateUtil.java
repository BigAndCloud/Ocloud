package com.ourselec.ocloud.util;

import java.util.concurrent.atomic.AtomicInteger;

public class RangeCreateUtil {

	public static String CreateNumber(Integer range_width,AtomicInteger Counter){
		
		
		String result = String.format("%0"+range_width+"d",Counter.incrementAndGet());
				return result;
	}
	public static AtomicInteger getCounter(String range_min){
		int min = Integer.parseInt(range_min);
		final AtomicInteger counter = new AtomicInteger(min-1);
		return counter;
	}
	public static void main(String[] args) {
		AtomicInteger Counter = getCounter("1");
		for (int i = 0; i < 5; i++) {
		System.out.println(CreateNumber(5, Counter));
		}
	}

}
