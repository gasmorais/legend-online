package chat.datas
{
   import chat.utils.ChatFormat;
   import com.pickgliss.ui.core.Disposeable;
   import flash.text.engine.ContentElement;
   
   public class ChatItemData implements Disposeable
   {
      
      public var channelName:String;
      
      public var channel:int;
      
      public var cellVector:Vector.<ChatCellData>;
      
      public function ChatItemData()
      {
         super();
      }
      
      public function getAllElements() : Vector.<ContentElement>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ChatCellData = null;
         var _loc5_:ContentElement = null;
         var _loc4_:Vector.<ContentElement> = ChatFormat.getElementVector();
         if(cellVector)
         {
            _loc1_ = int(cellVector.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = cellVector[_loc2_];
               _loc5_ = _loc3_.cellContentElement;
               _loc4_.push(_loc5_);
               _loc2_++;
            }
         }
         return _loc4_;
      }
      
      public function dispose() : void
      {
         var _loc2_:ChatCellData = null;
         var _loc3_:int = 0;
         channelName = "";
         channel = 0;
         if(!cellVector)
         {
            return;
         }
         var _loc1_:int = int(cellVector.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = cellVector[_loc3_];
            _loc2_.dispose();
            _loc2_ = null;
            cellVector[_loc3_] = null;
            _loc3_++;
         }
         cellVector.splice(0,_loc1_);
         cellVector = null;
      }
   }
}

