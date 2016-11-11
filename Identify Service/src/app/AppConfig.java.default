package app;

import java.util.AbstractMap;
import java.util.Collections;
import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Created by anthony on 11/11/16.
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
                entry("marketplace_service_url", "http://localhost:8082/Marketplace_Service"),
                entry("web_application_url", "http://localhost:8080/Web_Application"),
                entry("expired_time", String.valueOf(1000 * 60 * 60 * 2)),
                entry("db_user", "root"),
                entry("db_pass", "123456"),
                entry("db_url", "jdbc:mysql://localhost:3306/iton_account?zeroDateTimeBehavior=convertToNull")
        ).
                collect(entriesToMap()));
    }

    private static Map<String, String> config = configMap();

    public static String get(String s) {
        return config.get(s);
    }

}
