package bottle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.item.BottlePackage;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.BottleManager;
   import mvc.module.bottle.BottleModel;
   import mvc.module.bottle.BottleUserInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class BottleIntergalBoxView extends Component implements Disposeable
   {
      
      private var _boxBg:Image;
      
      private var _getedBitmap:Bitmap;
      
      private var _light:MovieClip;
      
      private var _index:int = -1;
      
      private var _packData:BottlePackage;
      
      private var _prize:Bitmap;
      
      private var _flag:Boolean;
      
      public function BottleIntergalBoxView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _getedBitmap = ComponentFactory.Instance.creatBitmap("asset.bottle.IntergalBoxGeted");
         _prize = ComponentFactory.Instance.creatBitmap("asset.bottle.prize");
         _light = ComponentFactory.Instance.creatCustomObject("bottle.CTBoxLight");
         _light.effect_01.stop();
         _light.mouseChildren = _light.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",onBoxClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",onBoxClick);
      }
      
      private function onBoxClick(param1:MouseEvent) : void
      {
         if(_packData)
         {
            if(_flag)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("bottle.view.BottleFrame.tips"));
               return;
            }
            BottleManager.instance.sendOpenInfo(6,_packData.param);
         }
      }
      
      public function set boxIndex(param1:int) : void
      {
         _index = param1;
         _packData = model.floorRewardArr[_index];
         if(_boxBg && _boxBg.parent)
         {
            _boxBg.parent.removeChild(_boxBg);
         }
         _boxBg = ComponentFactory.Instance.creatComponentByStylename("bottle.boxBg" + (param1 + 1));
         addChild(_boxBg);
         var _loc2_:Object = {};
         if(model.userArray[_index])
         {
            _loc2_.userInfo = model.userArray[_index];
         }
         _loc2_.packageData = _packData;
         if(_packData)
         {
            _boxBg.tipData = _loc2_;
         }
      }
      
      public function refreshStatus() : void
      {
         if(_getedBitmap == null || _light == null)
         {
            return;
         }
         buttonMode = true;
         _flag = false;
         if(_light)
         {
            _light.effect_01.gotoAndStop(1);
         }
         if(_light.parent)
         {
            _light.parent.removeChild(_light);
         }
         if(_getedBitmap.parent)
         {
            _getedBitmap.parent.removeChild(_getedBitmap);
         }
         if(model.userArray[_index] as BottleUserInfo && (model.userArray[_index] as BottleUserInfo).userId > 0 && (model.userArray[_index] as BottleUserInfo).state == 0)
         {
            buttonMode = true;
            _light.effect_01.play();
            addChild(_prize);
            if(_getedBitmap && _getedBitmap.parent)
            {
               _getedBitmap.parent.removeChild(_light);
            }
            if(model.userArray[_index] as BottleUserInfo && (model.userArray[_index] as BottleUserInfo).userName == playerInfo.nickName)
            {
               addChild(_light);
            }
            else if(_light && _light.parent)
            {
               _light.parent.removeChild(_light);
            }
         }
         else if(model.userArray[_index] as BottleUserInfo && (model.userArray[_index] as BottleUserInfo).userId > 0 && (model.userArray[_index] as BottleUserInfo).state == 1)
         {
            _flag = true;
            if(_light && _light.parent)
            {
               _light.parent.removeChild(_light);
            }
            addChild(_prize);
            addChild(_getedBitmap);
         }
         else
         {
            if(_prize && _prize.parent)
            {
               _prize.parent.removeChild(_prize);
            }
            if(_light && _light.parent)
            {
               _light.parent.removeChild(_light);
            }
            if(_getedBitmap && _getedBitmap.parent)
            {
               _getedBitmap.parent.removeChild(_light);
            }
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : BottleModel
      {
         return BottleManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_getedBitmap);
         _getedBitmap = null;
         ObjectUtils.disposeObject(_boxBg);
         _boxBg = null;
         ObjectUtils.disposeObject(_prize);
         _prize = null;
         ObjectUtils.disposeViolentMc(_light);
         _light = null;
         ObjectUtils.disposeAllChildren(this);
         _packData = null;
         super.dispose();
      }
   }
}

