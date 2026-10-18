package chat.datas
{
   import chat.view.ChatPopView;
   import com.pickgliss.ui.core.Component;
   import mainBar.ChatBar;
   
   public class ChatFactory
   {
      
      public function ChatFactory()
      {
         super();
      }
      
      public static function createChatPopByType(param1:ChatData, param2:Function = null, param3:String = "default") : Component
      {
         var _loc4_:ChatPopView = null;
         if(!ChatBar.instance.isLoaded)
         {
            return new Component();
         }
         var _loc5_:String = param3;
         if("default" === _loc5_)
         {
            _loc4_ = new ChatPopView(param2);
         }
         if(_loc4_)
         {
            _loc4_.data = param1;
         }
         return _loc4_;
      }
   }
}

