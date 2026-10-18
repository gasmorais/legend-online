package star.view
{
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.StarEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.DragManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PlayerStarListView extends Sprite implements Disposeable
   {
      
      public static const PLAYER_STAR_BAG_COUNT:int = 18;
      
      public static const ORIGINAL_OPEN_BAG_COUNT:int = 12;
      
      private var _area:Sprite;
      
      private var _itemList:Vector.<StarBagCell>;
      
      public function PlayerStarListView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:StarBagCell = null;
         _area = new Sprite();
         _area.graphics.beginFill(16777215,0);
         _area.graphics.drawRect(-5,-5,429,190);
         _area.graphics.endFill();
         addChild(_area);
         _itemList = new Vector.<StarBagCell>();
         var _loc2_:int = 12 + playerInfo.starBagCount;
         _loc3_ = 0;
         while(_loc3_ < 18)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("star.SmallStarBagCell");
            _loc1_.acceptDrop = true;
            _loc1_.setScaleCell();
            _loc1_.data = StarManager.instance.getStarInfoByBagTypeAndPos(1,_loc3_);
            _loc1_.bagType = 1;
            _loc1_.bagPos = _loc3_;
            _loc1_.x = _loc3_ % 6 * (_loc1_.viewRectangle.width + 10);
            _loc1_.y = int(_loc3_ / 6) * _loc1_.viewRectangle.height + 5;
            _loc3_ < _loc2_ ? (_loc1_.lock = false) : (Boolean(_loc1_.lock = true));
            _itemList.push(_loc1_);
            addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         var _loc1_:String = null;
         for each(var _loc2_:StarBagCell in _itemList)
         {
            if(_loc2_.lock == true)
            {
               _loc1_ = LanguageMgr.GetTranslation("armyII.viewII.horoscope.PlayerStarListView.command02");
               _loc2_.tipData = _loc1_;
               _loc2_.buttonMode = true;
               _loc2_.addEventListener("click",__bagLockClick);
            }
         }
         StarManager.instance.addEventListener("UPDATE_STAR",__updateHandler);
         StarManager.instance.addEventListener("DELETE_STAR",__deleteHandler);
         playerInfo.addEventListener("STARBAG_CAPICITY_INCRESS",__increaseBagHandler);
      }
      
      private function removeEvent() : void
      {
         for each(var _loc1_:StarBagCell in _itemList)
         {
            if(_loc1_.lock == true)
            {
               _loc1_.buttonMode = false;
               _loc1_.removeEventListener("click",__bagLockClick);
            }
         }
         StarManager.instance.removeEventListener("UPDATE_STAR",__updateHandler);
         StarManager.instance.removeEventListener("DELETE_STAR",__deleteHandler);
         playerInfo.removeEventListener("STARBAG_CAPICITY_INCRESS",__increaseBagHandler);
      }
      
      private function __increaseBagHandler(param1:PlayerEvent) : void
      {
         var _loc3_:StarBagCell = null;
         var _loc4_:int = 0;
         var _loc2_:String = null;
         _loc4_ = 12;
         while(_loc4_ < 12 + playerInfo.starBagCount)
         {
            if(_loc4_ >= 0 && _loc4_ < 18)
            {
               _loc3_ = _itemList[_loc4_];
               if(_loc3_.lock == true)
               {
                  _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.horoscope.PlayerStarListView.command01");
                  MessageTipManager.instance().show(_loc2_);
                  _loc3_.buttonMode = false;
                  _loc3_.removeEventListener("click",__bagLockClick);
                  _loc3_.lock = false;
                  _loc3_.tipData = "";
                  ShowTipManager.Instance.removeTip(_loc3_);
               }
            }
            _loc4_++;
         }
      }
      
      private function __bagLockClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         starManager.sendBagCellBuy();
      }
      
      private function __updateHandler(param1:StarEvent) : void
      {
         var _loc2_:StarBagCell = null;
         var _loc3_:StarInfo = param1.starInfo;
         if(_loc3_.bagType == 1)
         {
            _loc2_ = _itemList[_loc3_.pos] as StarBagCell;
            if(_loc2_)
            {
               _loc2_.data = _loc3_;
            }
         }
      }
      
      private function __deleteHandler(param1:StarEvent) : void
      {
         var _loc2_:StarBagCell = null;
         var _loc3_:StarInfo = param1.starInfo;
         if(_loc3_.bagType == 1)
         {
            _loc2_ = _itemList[_loc3_.pos] as StarBagCell;
            if(_loc2_)
            {
               _loc2_.data = null;
            }
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      public function dispose() : void
      {
         removeEvent();
         DragManager.getInstance().stopDrag();
         for each(var _loc1_:StarBagCell in _itemList)
         {
            _loc1_.tipData = "";
            _loc1_.dispose();
            _loc1_ = null;
         }
         _itemList = null;
         ObjectUtils.disposeViolentMc(_area);
         _area = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

