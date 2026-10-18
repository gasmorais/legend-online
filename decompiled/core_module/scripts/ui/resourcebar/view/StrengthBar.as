package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   
   public class StrengthBar extends Component
   {
      
      private var _back:Bitmap;
      
      private var _numContainer:Sprite;
      
      private var _simpleInfo:SimplePlayerInfo;
      
      private var _startPosX:uint = 108;
      
      private var _bgWidth:uint = 155;
      
      public function StrengthBar()
      {
         super();
         initUI();
         addEvent();
      }
      
      protected function addEvent() : void
      {
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",thaneInfoChangeHandler);
         thane.addEventListener("PLAYER_INFO_UPDATE",thaneInfoChangeHandler);
      }
      
      protected function removeEvent() : void
      {
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",thaneInfoChangeHandler);
         thane.removeEventListener("PLAYER_INFO_UPDATE",thaneInfoChangeHandler);
      }
      
      private function thaneInfoChangeHandler(param1:PlayerEvent) : void
      {
         _simpleInfo = param1.currentTarget as SimplePlayerInfo;
         updateStrength();
      }
      
      private function initUI() : void
      {
         y = 99;
         _back = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.strengthBg");
         this.addChild(_back);
         _numContainer = new Sprite();
         _numContainer.x = 57;
         _numContainer.y = 1;
         this.addChild(_numContainer);
         updateStrength();
      }
      
      protected function strengthBtnHandler(param1:MouseEvent) : void
      {
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function updateStrength() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Bitmap = null;
         ObjectUtils.removeChildAllChildren(_numContainer);
         _loc2_ = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.strengthNum");
         if(_simpleInfo == null)
         {
            _loc1_ = thane.fightingCapacity;
         }
         else
         {
            _loc1_ = _simpleInfo.fightingCapacity;
         }
         NumberViewUtils.getNumberView(_loc1_,_numContainer,_loc2_.bitmapData,13,17,11,13,"0123456789",1);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
         x = _startPosX + (_bgWidth - (_back.width + _numContainer.width)) * 0.5;
      }
   }
}

