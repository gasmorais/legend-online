package mvc.module.groupchat
{
   import com.pickgliss.ui.core.Disposeable;
   
   public class ConsortiaGroupChatHistoryData implements Disposeable
   {
      
      public static const TYPE_CHAT:int = 1;
      
      public static const TYPE_INFO:int = 2;
      
      public static const COLOR_CHAT:int = 3;
      
      public static const COLOR_NAME:int = 4;
      
      public static const STYLE_CHAT_NONE:int = 5;
      
      public static const STYLE_CHAT_SPACE:int = 6;
      
      public static const STYLE_INFO_ICON:int = 7;
      
      public static const STYLE_INFO_NONE:int = 8;
      
      public var uid:int;
      
      public var type:int;
      
      public var style:int;
      
      public var color:int;
      
      public var text:String;
      
      public function ConsortiaGroupChatHistoryData()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
   }
}

