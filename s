import notify.dispatch.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import queue.manager.QManager;

import java.util.HashMap;
import java.util.Map;

import static org.mockito.Mockito.*;

class POSTMonitorTest {
    @Mock
    private HandlerManager handlerManager;
    @Mock
    private NotificationThread notificationThread;
    @Mock
    private POSTRetryThread postRetryThread;
    @Mock
    private QManager qManager;

    private POSTMonitor postMonitor;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        postMonitor = new POSTMonitor();
        postMonitor.m_objHandlerManager = handlerManager;
        postMonitor.objNotification = notificationThread;
        postMonitor.objNotificationRetry = postRetryThread;
        postMonitor.m_objQueueService = mock(QueueService.class);
    }

    @Test
    void main_WhenPropertiesLoaded_Successfully() throws Exception {
        // Arrange
        String[] args = new String[1];
        args[0] = "testProps.properties";
        when(handlerManager.init(any(), anyInt())).thenReturn(true);
        when(postRetryThread.init(any(), anyInt())).thenReturn(true);
        when(notificationThread.init(any(), any())).thenReturn(true);
        when(qManager.init(any())).thenReturn(true);
        when(m_objQueueService.start(any(QManager.class), any(Config.class))).thenReturn(true);
        when(objMonitorStatus.sendStatusMessage(anyString(), anyString(), anyString(), anyString(), anyString(), anyString()))
                .thenReturn(true);

        // Act
        POSTMonitor.main(args);

        // Assert
        // Verify that the necessary initialization methods are called
        verify(handlerManager).init(any(), anyInt());
        verify(postRetryThread).init(any(), anyInt());
        verify(notificationThread).init(any(), any());
        verify(qManager).init(any());
        verify(m_objQueueService).start(any(QManager.class), any(Config.class));
        // Verify that the status message is sent successfully
        verify(objMonitorStatus).sendStatusMessage(anyString(), anyString(), anyString(), anyString(), anyString(), anyString());
    }
  
    @Test
    void checkInitFailed_WhenInitFailed_Successfully() {
        // Arrange
        when(objMonitorStatus.sendStatusMessage(anyString(), anyString(), anyString(), anyString(), anyString(), anyString()))
                .thenReturn(true);

        // Act
        POSTMonitor.checkInitFailed(true, objMonitorStatus);

        // Assert
        // Verify that the status message is sent successfully
        verify(objMonitorStatus).sendStatusMessage(anyString(), anyString(), anyString(), anyString(), anyString(), anyString());
    }

    @Test
    void shutdownThread_WhenCalled_ShouldStopQueueServiceAndDeinitializeThreads() throws Exception {
        // Arrange
        when(m_objQueueService.isStarted()).thenReturn(true);

        // Act
        postMonitor.ShutdownThread Runnable();

        // Assert
        // Verify that the queue service is stopped
        verify(m_objQueueService).stopService();
        // Verify that the necessary deinitialization methods are called
        verify(notificationThread).deinit();
        verify(postRetryThread).deinit();
        verify(NotifyDBConnector).destroyDataSource();
    }

    @Test
    void process_WhenConsumingProcessingTypeIsNotify_CallsNotificationThreadRunMethod() throws Exception {
        // Arrange
        QueueInfo queueInfo = new QueueInfo();
        queueInfo.setConsumingProcessingType("notify");

        String message = "testMessage";
        Map<String, Object> extras = new HashMap<>();

        // Act
        postMonitor.process(queueInfo, message, extras);

        // Assert
        // Verify that the notification thread's run method is called with the correct parameters
        verify(notificationThread).run(eq(message), anyString());
        verify(postRetryThread, never()).addToNotifyQ(anyString(), anyString());
    }

    @Test
    void process_WhenConsumingProcessingTypeIsNotifyRetry_CallsPostRetryThreadAddToNotifyQMethod() throws Exception {
        // Arrange
        QueueInfo queueInfo = new QueueInfo();
        queueInfo.setConsumingProcessingType("notify_retry");

        String message = "testMessage";
        Map<String, Object> extras = new HashMap<>();

        // Act
        postMonitor.process(queueInfo, message, extras);

        // Assert
        // Verify that the post retry thread's addToNotifyQ method is called with the correct parameters
        verify(notificationThread, never()).run(anyString(), anyString());
        verify(postRetryThread).addToNotifyQ(eq(message), anyString());
    }

    @Test
    void process_WhenConsumingProcessingTypeIsInvalid_DoesNotCallNotificationThreadOrPostRetryThread() throws Exception {
        // Arrange
        QueueInfo queueInfo = new QueueInfo();
        queueInfo.setConsumingProcessingType("invalid");

        String message = "testMessage";
        Map<String, Object> extras = new HashMap<>();

        // Act
        postMonitor.process(queueInfo, message, extras);

        // Assert
        // Verify that neither the notification thread nor the post retry thread are called
        verify(notificationThread, never()).run(anyString(), anyString());
        verify(postRetryThread, never()).addToNotifyQ(anyString(), anyString());
    }
}