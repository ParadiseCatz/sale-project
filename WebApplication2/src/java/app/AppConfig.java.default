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
        return Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue);
    }

    private static Map<String, String> configMap() {
        return Collections.unmodifiableMap(Stream.of(
                entry("identity_service_url", "http://localhost:8081/Identity_Service"),
                entry("marketplace_service_url", "http://localhost:8082/Marketplace_Service")
        ).
                collect(entriesToMap()));
    }

    private static Map<String, String> config = configMap();

    public static String get(String s) {
        return config.get(s);
    }

}
