 import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

public class PluginManagerTest {

private PluginManager manager;
private PluginManager spyManager;
private PluginManager pluginChanged;

@Before
public void setUp() {
 manager = new PluginManager();
 spyManager = Mockito.spy(manager);
 pluginChanged = new PluginManager();
}

@Test
public void testPluginChanged() {
 String strName = "TestHandler";
 boolean result = pluginChanged.pluginChanged(strName, spyManager);
 assertTrue(result);
}

@Test
public void testPluginChangedNullName() {
 String strName = null;
 boolean result = pluginChanged.pluginChanged(strName, spyManager);
 assertFalse(result);
}

@Test
public void testPluginChangedEmptyName() {
 String strName = "";
 boolean result = pluginChanged.pluginChanged(strName, spyManager);
 assertFalse(result);
}

@Test
public void testPluginChangedInitSuccess() {
 String strName = "TestHandler";
 IHTTPHandlerV2 mockHandler = Mockito.mock(IHTTPHandlerV2.class);
 Mockito.when(mockHandler.init(Mockito.any())).thenReturn(true);
 Mockito.when(spyManager.loadClass(strName)).thenReturn(IHTTPHandlerV2.class);
 Mockito.when(spyManager.newInstance()).thenReturn(mockHandler);

 boolean result = pluginChanged.pluginChanged(strName, spyManager);
 assertTrue(result);
}

@Test
public void testPluginChangedInitFail() {
 String strName = "TestHandler";
 IHTTPHandlerV2 mockHandler = Mockito.mock(IHTTPHandlerV2.class);
 Mockito.when(mockHandler.init(Mockito.any())).thenReturn(false);
 Mockito.when(spyManager.loadClass(strName)).thenReturn(IHTTPHandlerV2.class);
 Mockito.when(spyManager.newInstance()).thenReturn(mockHandler);

 boolean result = pluginChanged.pluginChanged(strName, spyManager);
 assertFalse(result);
}

@Test
public void testPluginChangedException() {
 String strName = "TestHandler";
 Mockito.when(spyManager.loadClass(strName)).thenThrow(new ClassNotFoundException());

 boolean result = pluginChanged.pluginChanged(strName, spyManager);
 assertFalse(result);
}
}