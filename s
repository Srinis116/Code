 
1. HandlerManagerTest.java

```java
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.mockito.Mockito.*;

public class HandlerManagerTest {

    @Mock
    private java.util.Properties props;

    @InjectMocks
    private HandlerManager handlerManager;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testCreateInstance() {
        // Test createInstance() method
        
        // Mocking the necessary dependencies
        when(props.getProperty("property.key")).thenReturn("property.value");
        
        // Test the method
        HandlerManager manager = HandlerManager.createInstance(props, 1);
        
        // Verify the results
        assertNotNull(manager);
        verify(props, times(1)).getProperty("property.key");
    }
}
```

2. NotificationThreadTest.java

```java
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.mockito.Mockito.*;

public class NotificationThreadTest {

    @Mock
    private java.util.Properties props;

    @Mock
    private HandlerManager handlerManager;

    @InjectMocks
    private NotificationThread notificationThread;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testInit() {
        // Test init() method
        
        // Mocking the necessary dependencies
        when(props.getProperty("property.key")).thenReturn("property.value");
        when(handlerManager.someMethod()).thenReturn(true);
        
        // Test the method
        boolean result = notificationThread.init(props, handlerManager, 1, 1, -1);
        
        // Verify the results
        assertTrue(result);
        verify(props, times(1)).getProperty("property.key");
        verify(handlerManager, times(1)).someMethod();
    }
}
```

3. POSTRetryThreadTest.java

```java
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.mockito.Mockito.*;

public class POSTRetryThreadTest {

    @Mock
    private java.util.Properties props;

    @InjectMocks
    private POSTRetryThread postRetryThread;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testInit() {
        // Test init() method
        
        // Mocking the necessary dependencies
        when(props.getProperty("property.key")).thenReturn("property.value");
        
        // Test the method
        boolean result = postRetryThread.init(props, 1, -1);
        
        // Verify the results
        assertTrue(result);
        verify(props, times(1)).getProperty("property.key");
    }
}
```

4. QManagerTest.java

```java
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.mockito.Mockito.*;

public class QManagerTest {

    @Mock
    private java.util.Properties props;

    @InjectMocks
    private QManager qManager;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testInit() {
        // Test init() method
        
        // Mocking the necessary dependencies
        when(props.getProperty("property.key")).thenReturn("property.value");
        
        // Test the method
        boolean result = qManager.init(props);
        
        // Verify the results
        assertTrue(result);
        verify(props, times(1)).getProperty("property.key");
    }
}