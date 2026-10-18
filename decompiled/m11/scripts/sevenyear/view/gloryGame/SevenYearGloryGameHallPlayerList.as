package sevenyear.view.gloryGame
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.GloryGameManager;
   import mvc.module.gloryGame.GloryGameModel;
   
   public class SevenYearGloryGameHallPlayerList extends Sprite implements Disposeable
   {
      
      public static const LIST_NUM:int = 4;
      
      private var _itemList:Vector.<SevenYearGloryGameHallPlayer>;
      
      private var _tempItem:SevenYearGloryGameHallPlayer;
      
      private var _posArr:Array = [[-11,177],[124,117],[319,117],[464,177]];
      
      public function SevenYearGloryGameHallPlayerList()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _itemList = new Vector.<SevenYearGloryGameHallPlayer>();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _tempItem = new SevenYearGloryGameHallPlayer(_loc1_ + 1);
            _tempItem.x = _posArr[_loc1_][0];
            _tempItem.y = _posArr[_loc1_][1];
            addChild(_tempItem);
            _itemList.push(_tempItem);
            _loc1_++;
         }
         _tempItem = null;
      }
      
      private function uninitView() : void
      {
         while(_itemList && _itemList.length > 0)
         {
            _itemList.pop().dispose();
         }
         _itemList = null;
         ObjectUtils.disposeObject(_tempItem);
         _tempItem = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         if(!model.teamPlayers)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < model.teamPlayers.length)
         {
            _itemList[_loc1_].data = model.teamPlayers[_loc1_];
            _loc1_++;
         }
      }
      
      public function get model() : GloryGameModel
      {
         return GloryGameManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

