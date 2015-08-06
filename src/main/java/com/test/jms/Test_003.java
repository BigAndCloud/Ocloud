package com.test.jms;

import java.util.concurrent.atomic.AtomicInteger;

public class Test_003 {

	
	public static void main(String[] args) {
		final AtomicInteger counter = new AtomicInteger(6);
//		String s = String.format("C%05d",counter.incrementAndGet());
		
		for (int i = 0; i < 20; i++) {
			String s = String.format("C%05d",counter.incrementAndGet());
			System.out.println(s);	
		}
	}
}
