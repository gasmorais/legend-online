package chess
{
   import chess.item.SelfChessTeamItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.chess.SelfChessModel;
   import mvc.module.chess.SelfChessPlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class SelfChessHeroTeamView extends Sprite
   {
      
      private var _itemList:Vector.<SelfChessTeamItem>;
      
      private var _standPos:Array = [3,6,9,12,1,4,7,10];
      
      public function SelfChessHeroTeamView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:SelfChessTeamItem = null;
         var _loc3_:int = 0;
         _itemList = new Vector.<SelfChessTeamItem>();
         var _loc2_:Array = [{
            "x":287,
            "y":207
         },{
            "x":245,
            "y":265
         },{
            "x":202,
            "y":317
         },{
            "x":152,
            "y":367
         },{
            "x":496,
            "y":207
         },{
            "x":458,
            "y":265
         },{
            "x":412,
            "y":317
         },{
            "x":362,
            "y":367
         }];
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("chess.item.SelfChessTeamItem",[_loc3_ + 1]);
            _loc1_.x = _loc2_[_loc3_].x;
            _loc1_.y = _loc2_[_loc3_].y;
            addChild(_loc1_);
            _itemList[_loc3_] = _loc1_;
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
      }
      
      private function __startDragHandler(param1:NotificationEvent) : void
      {
         var _loc3_:SelfChessTeamItem = param1.data as SelfChessTeamItem;
         for each(var _loc2_:SelfChessTeamItem in _itemList)
         {
            if(_loc2_.pos != _loc3_.pos)
            {
               _loc2_.setBottomVisible(true);
               _loc2_.dark();
            }
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:SelfChessTeamItem in _itemList)
         {
            _loc2_.setBottomVisible(false);
            _loc2_.normal();
         }
      }
      
      public function refreshView() : void
      {
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:SelfChessPlayerInfo = model.selfInfo;
         if(_loc1_)
         {
            _loc4_ = _loc1_.battleAry;
            _loc2_ = int(_loc4_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _itemList[_loc3_].dateTempId = _loc4_[_loc3_];
               _loc3_++;
            }
         }
      }
      
      private function get model() : SelfChessModel
      {
         return SelfChessManager.Ins.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:SelfChessTeamItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

