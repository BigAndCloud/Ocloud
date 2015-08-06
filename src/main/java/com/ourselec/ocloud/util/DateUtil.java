package com.ourselec.ocloud.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {

	public static Date get1000Date() {

		try {
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse("1000-01-01 00:00:00");
		} catch (ParseException e) {
		}
		return null;
	}

	public static Date parse(String timeStr) {
		return parse("yyyy-MM-dd HH:mm:ss", timeStr);
	}

	public static Date parse(String pattern, String timeStr) {
		try {
			return new SimpleDateFormat(pattern).parse(timeStr);
		} catch (ParseException e) {
		}
		return null;
	}

	public static String format(Date date) {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
	}
	
	public static String format(String pattern, Date date) {
		return new SimpleDateFormat(pattern).format(date);
	}
	
	/**
	 * 取得下一个更新统计缓存时间，即明日0点
	 * @return
	 */
	public static Date nextTaskTime() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		calendar.add(Calendar.DATE, 1);
		return calendar.getTime();
	}
	
	/**
	 * 取得当前月份
	 * @return
	 */
	public static Date getCurrentMonth() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		return calendar.getTime();
	}
	
	/**
	 * 取得当日0点
	 * @return
	 */
	public static Date getCurrentDay() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
	
	public static Date getPreDate(int date) {
		Calendar c = Calendar.getInstance();
		c.set(Calendar.DATE, c.get(Calendar.DATE) - date);
		return c.getTime();
	}
	
	/**
	 * 计算两个日期之间的月差
	 */
	public static int dispersionMonth2(String strDate1, String strDate2) {
		int iMonth = 0;
		int flag = 0;
		try {
			Calendar objCalendarDate1 = Calendar.getInstance();
			objCalendarDate1.setTime(DateFormat.getDateInstance().parse(
					strDate1));

			Calendar objCalendarDate2 = Calendar.getInstance();
			objCalendarDate2.setTime(DateFormat.getDateInstance().parse(
					strDate2));

			if (objCalendarDate2.equals(objCalendarDate1))
				return 0;
			if (objCalendarDate1.after(objCalendarDate2)) {
				Calendar temp = objCalendarDate1;
				objCalendarDate1 = objCalendarDate2;
				objCalendarDate2 = temp;
			}
			if (objCalendarDate2.get(Calendar.DAY_OF_MONTH) < objCalendarDate1
					.get(Calendar.DAY_OF_MONTH))
				flag = 1;

			if (objCalendarDate2.get(Calendar.YEAR) > objCalendarDate1
					.get(Calendar.YEAR))
				iMonth = ((objCalendarDate2.get(Calendar.YEAR) - objCalendarDate1
						.get(Calendar.YEAR))
						* 12 + objCalendarDate2.get(Calendar.MONTH) - flag)
						- objCalendarDate1.get(Calendar.MONTH);
			else
				iMonth = objCalendarDate2.get(Calendar.MONTH)
						- objCalendarDate1.get(Calendar.MONTH) - flag;

		} catch (Exception e) {
		}
		return iMonth;
	}
	
	public static String formatHour(Date date) {
		return new SimpleDateFormat("HH").format(date);
	}
	public static String formatDayAndHour(Date date) {
		return new SimpleDateFormat("yyyy-MM-dd HH").format(date);
	}
	
	public static Date getNextDay(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		int day = c.get(Calendar.DATE);
		c.set(Calendar.DATE, day + 1);
		return c.getTime();
	}
	
	public static String getNextDay(String dateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date;
		try {
			date = getNextDay(sdf.parse(dateStr));			
			return sdf.format(date);
		} catch (ParseException e) {			
			
		}
		return "";
	}
	
	public static String getRelativeDay(Integer year, Integer month, Integer day, Integer hour, Integer minute, Integer second) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar c=Calendar.getInstance();
        if(year != null) {
        	c.add(Calendar.YEAR, year);
        }
        if(month != null) {
        	c.add(Calendar.MONTH, month);
        }
        if(day != null) {
        	c.add(Calendar.DAY_OF_MONTH, day);
        }
        if(hour != null) {
        	c.add(Calendar.HOUR_OF_DAY, hour);
        }
        if(minute != null) {
        	c.add(Calendar.MINUTE, minute);
        }
        if(second != null) {
        	c.add(Calendar.SECOND, second);
        }
        return sdf.format(c.getTime());
	}
}
