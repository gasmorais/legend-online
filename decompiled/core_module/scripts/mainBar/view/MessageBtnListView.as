package mainBar.view
{
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import tasktracetip.event.TaskTraceTipEvent;
   
   public class MessageBtnListView extends Sprite
   {
      
      private static const ITEM_NUM:int = 4;
      
      private var _hBox:HBox;
      
      private var _list:Vector.<MessageBtnView>;
      
      public function MessageBtnListView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _hBox = new HBox();
         _hBox.spacing = 10;
         _list = new Vector.<MessageBtnView>();
         addChild(_hBox);
      }
      
      public function addMessage(param1:TipMessageData) : void
      {
         if(hasType(param1.type))
         {
            return;
         }
         var _loc2_:MessageBtnView = new MessageBtnView();
         _loc2_.addEventListener("click",__onClickHandler);
         _loc2_.data = param1;
         _list.push(_loc2_);
         if(_hBox.numChildren < 4)
         {
            _hBox.addChild(_loc2_);
            _hBox.refreshChildPos();
         }
         dispatchEvent(new TaskTraceTipEvent("UPDATE_TASK_TRACE_TIP"));
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MessageBtnView = param1.currentTarget as MessageBtnView;
         _loc2_.removeEventListener("click",__onClickHandler);
         TaskTraceTipManager.instance.showView(_loc2_.data);
         removeMessageByType(_loc2_.data.type);
      }
      
      public function removeMessageByType(param1:int) : void
      {
         var _loc2_:MessageBtnView = getItemByType(param1);
         if(!_loc2_)
         {
            return;
         }
         _list.splice(_list.indexOf(_loc2_),1);
         _loc2_.removeEventListener("click",__onClickHandler);
         ObjectUtils.disposeObject(_loc2_);
         _hBox.refreshChildPos();
         dispatchEvent(new TaskTraceTipEvent("UPDATE_TASK_TRACE_TIP"));
      }
      
      public function hasType(param1:int) : Boolean
      {
         if(getItemByType(param1))
         {
            return true;
         }
         return false;
      }
      
      private function getItemByType(param1:int) : MessageBtnView
      {
         for each(var _loc2_:MessageBtnView in _list)
         {
            if(_loc2_.data.type == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get hBox() : HBox
      {
         return _hBox;
      }
   }
}

