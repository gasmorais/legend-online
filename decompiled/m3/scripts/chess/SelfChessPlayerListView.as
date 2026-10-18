package chess
{
   import chess.item.SelfChessPlayerItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.chess.SelfChessManager;
   
   public class SelfChessPlayerListView extends Sprite
   {
      
      public var _rightVbox:VBox;
      
      private var _itemList:Vector.<SelfChessPlayerItem>;
      
      private var MAX:int;
      
      public function SelfChessPlayerListView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _rightVbox = ComponentFactory.Instance.creatCustomObject("ui.selfchess.rightVbox");
         addChild(_rightVbox);
         _itemList = new Vector.<SelfChessPlayerItem>();
         MAX = SelfChessManager.Ins.ROOM_MAX;
         _loc1_ = 0;
         while(_loc1_ < MAX)
         {
            _itemList[_loc1_] = ComponentFactory.Instance.creatCustomObject("chess.item.SelfChessPlayerItem");
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:SelfChessPlayerItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_rightVbox);
         _rightVbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _itemList = null;
      }
      
      public function refreshView() : void
      {
         var _loc1_:SelfChessPlayerItem = null;
         var _loc3_:int = 0;
         var _loc4_:Array = SelfChessManager.Ins.model.playerList.getList();
         var _loc2_:int = int(_loc4_ ? _loc4_.length : 0);
         if(_loc2_ > 0)
         {
            _loc4_.sortOn(["hp","rank"],[0x10 | 2,16]);
            _rightVbox.beginChanges();
            _rightVbox.removeAllChild();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = _itemList[_loc3_];
               _loc1_.data = _loc4_[_loc3_];
               _rightVbox.addChild(_loc1_);
               _loc3_++;
            }
            _rightVbox.commitChanges();
         }
      }
   }
}

