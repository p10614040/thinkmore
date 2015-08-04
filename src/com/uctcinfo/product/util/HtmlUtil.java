package com.uctcinfo.product.util;

import java.util.regex.Pattern;
 /**
 * @ClassName: HtmlUtil.java
 * @Description: TODO
 *
 * @author： even.jin
 * @version： V1.0
 * @Date： 2014-1-5 下午4:09:57
 */
public class HtmlUtil {
	public static String subhtml(String html,int width ){
		return subhtml(html,width,null);
	}
	public static String subhtml(String html,int width,String ellipsis ){
		if(ellipsis==null){
			ellipsis="...";
		}
		return abbreviate(html2Text(html),width,ellipsis);
	}
	
	  public static String abbreviate(String str, int width, String ellipsis) {   
	        if (str == null || "".equals(str)) {   
	            return "";   
	       }   
	  
	        int d = 0; // byte length   
	        int n = 0; // char length   
	        for (; n < str.length(); n++) {   
	            d = (int) str.charAt(n) > 256 ? d + 2 : d + 1;   
	            if (d > width) {   
	                break;   
	            }   
	        }   
	  
	       if (d > width) {   
	            n = n - ellipsis.length() / 2;   
	            return str.substring(0, n > 0 ? n : 0) + ellipsis;   
	        }   
	  
	       return str = str.substring(0, n);   
	    }
	 public static String html2Text(String inputString) {   
	       String htmlStr = inputString; // 含html标签的字符串   
	       String textStr = "";   
	       java.util.regex.Pattern p_script;   
	        java.util.regex.Matcher m_script;   
	        java.util.regex.Pattern p_style;   
	       java.util.regex.Matcher m_style;   
	        java.util.regex.Pattern p_html;   
	        java.util.regex.Matcher m_html;   
	  
	        java.util.regex.Pattern p_html1;   
	        java.util.regex.Matcher m_html1;   
	  
	        try {   
	String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; // 定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script>   
	            // }   
	            String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; // 定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style>   
	           // }   
	           String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式   
	            String regEx_html1 = "<[^>]+";   
	           p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);   
	           m_script = p_script.matcher(htmlStr);   
	            htmlStr = m_script.replaceAll(""); // 过滤script标签   
	 
	            p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);   
	            m_style = p_style.matcher(htmlStr);   
	            htmlStr = m_style.replaceAll(""); // 过滤style标签   
	  
	           p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);   
	            m_html = p_html.matcher(htmlStr);   
	            htmlStr = m_html.replaceAll(""); // 过滤html标签   
	  
	            p_html1 = Pattern.compile(regEx_html1, Pattern.CASE_INSENSITIVE);   
	            m_html1 = p_html1.matcher(htmlStr);   
	            htmlStr = m_html1.replaceAll(""); // 过滤html标签   
	  
	           textStr = htmlStr;   
	  
	        } catch (Exception e) {   
	            System.err.println("Html2Text: " + e.getMessage());   
	        }   
	 
	       return textStr;// 返回文本字符串   
	   }   

}
