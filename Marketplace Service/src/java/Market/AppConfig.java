/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Market;


import java.util.AbstractMap;
import java.util.Collections;
import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 *
 * @author ASUS
 */
public class AppConfig {
    private static <K, V> Map.Entry<K, V> entry(K key, V value) {
        return new AbstractMap.SimpleEntry<>(key, value);
    }

    private static <K, U> Collector<Map.Entry<K, U>, ?, Map<K, U>> entriesToMap() {
        return Collectors.toMap((e) -> e.getKey(), (e) -> e.getValue());
    }

    private static Map<String, String> configMap() {
        return Collections.unmodifiableMap(Stream.of(
                entry("identity_service_url", "http://localhost:8081/Identity_Service"),
                entry("web_application_url", "http://localhost:8080/Web_Application"),
                entry("db_user", "root"),
                entry("db_pass", ""),
                entry("db_url", "jdbc:mysql://localhost:3306/iton_marketplace?zeroDateTimeBehavior=convertToNull")
                ).
                collect(entriesToMap()));
    }

    private static Map<String, String> config = configMap();

    public static String get(String s) {
        return config.get(s);
    }
}
