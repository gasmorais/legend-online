package map.internals.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import map.internals.data.BaseCastle;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class CastleDefenceView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _icon:Bitmap;
      
      private var _time:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      private var _consortiaName:FilterFrameText;
      
      private var _nameBg:*;
      
      private var _vipNameBg:ScaleLeftRightImage;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _data:BaseCastle;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _hourLen:int;
      
      public function CastleDefenceView()
      {
         super();
         _icon = ComponentFactory.Instance.creatBitmap("asset.outercity.DefenceImgAsset");
         _back = ComponentFactory.Instance.creatBitmap("asset.outercity.DefenceBackAsset");
         _time = ComponentFactory.Instance.creatComponentByStylename("outercity.DefensiveTime");
         _name = ComponentFactory.Instance.creatComponentByStylename("outercity.OutercityNameText");
         _consortiaName = ComponentFactory.Instance.creatComponentByStylename("outercity.OutercityConsortiaNameText");
         _nameBg = ComponentFactory.Instance.creatCustomObject("outercity.ThaneNamebg");
         _vipNameBg = ComponentFactory.Instance.creatComponentByStylename("outercity.CastleNameVipBg");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("outercity.VipIcon");
         addChild(_consortiaName);
         addChild(_name);
      }
      
      private function get isVip() : Boolean
      {
         return _data.info.occupyPlayerId > 0 && _data.info.vipCastleView > 0;
      }
      
      public function set data(param1:BaseCastle) : void
      {
         var _loc4_:String = null;
         _data = param1;
         _count = _data.defenceLeftTime;
         var _loc5_:Number = 0;
         var _loc2_:Number = 140;
         if(_nameBg && _nameBg.parent)
         {
            removeChild(_nameBg);
         }
         if(_vipNameBg && _vipNameBg.parent)
         {
            removeChild(_vipNameBg);
         }
         if(_vipIcon && _vipIcon.parent)
         {
            removeChild(_vipIcon);
         }
         if(isVip)
         {
            addChildAt(_vipIcon,0);
            addChildAt(_vipNameBg,0);
            _vipIcon.setFrame(1);
            _loc5_ = 40;
            _loc2_ = 130;
         }
         else
         {
            if(_data.info.occupyPlayerId > 0)
            {
               addChildAt(_nameBg,0);
            }
            _loc5_ = 0;
            _loc2_ = 140;
         }
         _name.x = _loc5_;
         _name.width = _loc2_ - _loc5_;
         _consortiaName.x = _loc5_;
         _consortiaName.width = _loc2_ - _loc5_;
         if(_data.info.names == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
         {
            _loc4_ = LanguageMgr.GetTranslation("public.nickName");
            _name.text = _loc4_;
         }
         else
         {
            _name.text = _data.info.names;
         }
         if(_data.info.occupyLeagueName.replace(" ","") != "")
         {
            _consortiaName.text = "<" + _data.info.occupyLeagueName + ">";
         }
         else
         {
            _consortiaName.text = "";
         }
         var _loc3_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(_loc3_.userId == param1.info.occupyPlayerId)
         {
            _name.setFrame(1);
            _consortiaName.setFrame(1);
         }
         else if(_loc3_.consortiaID > 0 && _loc3_.consortiaName == param1.info.occupyLeagueName)
         {
            _name.setFrame(3);
            _consortiaName.setFrame(3);
         }
         else
         {
            _name.setFrame(2);
            _consortiaName.setFrame(2);
         }
         if(_data.defenceLeftTime > 0)
         {
            addChild(_icon);
            addChild(_back);
            addChild(_time);
            removeTimeEvent();
            addTimeEvent();
         }
         else
         {
            if(_icon.parent)
            {
               _icon.parent.removeChild(_icon);
            }
            if(_back.parent)
            {
               _back.parent.removeChild(_back);
            }
            if(_time.parent)
            {
               _time.parent.removeChild(_time);
            }
            removeTimeEvent();
         }
         setNamesNovice();
      }
      
      private function setNamesNovice() : void
      {
         var _loc1_:BaseCastle = null;
         if(PlayerManager.instance.newbieProcess < 0)
         {
            _loc1_ = PlayerManager.instance.currentPlayerModel.mapNodeInfo;
            if(_loc1_.info.names == _data.info.names)
            {
               _name.text = "";
            }
         }
      }
      
      private function addTimeEvent() : void
      {
         _timer = new Timer(1000,_count);
         _timer.addEventListener("timer",updateTime);
         _timer.addEventListener("timerComplete",__timeComplete);
         _timer.start();
      }
      
      private function removeTimeEvent() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",updateTime);
            _timer.removeEventListener("timerComplete",__timeComplete);
            _timer = null;
         }
      }
      
      private function __timeComplete(param1:TimerEvent) : void
      {
         _data.defenceLeftTime = 0;
         if(_icon && _icon.parent)
         {
            _icon.parent.removeChild(_icon);
         }
         if(_back && _back.parent)
         {
            _back.parent.removeChild(_back);
         }
         if(_time && _time.parent)
         {
            _time.parent.removeChild(_time);
         }
         removeTimeEvent();
      }
      
      private function updateTime(param1:TimerEvent) : void
      {
         _count = _count - 1;
         if(_count >= 36000000)
         {
            _time.text = "9999:59:59";
         }
         else
         {
            if(_count >= 3600000)
            {
               _hourLen = 4;
            }
            else if(_count >= 360000)
            {
               _hourLen = 3;
            }
            else
            {
               _hourLen = 2;
            }
            _time.text = DateFormatter.getCountDate(_count,_hourLen);
         }
      }
      
      public function get nameText() : FilterFrameText
      {
         return _name;
      }
      
      public function dispose() : void
      {
         removeTimeEvent();
         ObjectUtils.disposeObject(_icon);
         ObjectUtils.disposeObject(_back);
         ObjectUtils.disposeObject(_time);
         ObjectUtils.disposeObject(_name);
         ObjectUtils.disposeObject(_consortiaName);
         ObjectUtils.disposeObject(_nameBg);
         ObjectUtils.disposeObject(_vipNameBg);
         ObjectUtils.disposeObject(_vipIcon);
         _icon = null;
         _back = null;
         _time = null;
         _name = null;
         _consortiaName = null;
         _nameBg = null;
         _vipNameBg = null;
         _vipIcon = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

