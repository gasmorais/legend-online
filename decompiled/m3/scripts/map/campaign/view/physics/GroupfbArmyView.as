package map.campaign.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import events.ArmyEvent;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.skill.MapSkillHurtData;
   import map.campaign.event.CampaignMapEvent;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.tools.SimpleMovie;
   
   public class GroupfbArmyView extends CampaignArmyView
   {
      
      private var _precentSpeed:Number = 1;
      
      private var _buffDelay:uint;
      
      private var _buffIcon:BaseIconView;
      
      private var _reviveFlag:Boolean;
      
      private var _reviveDelay:uint;
      
      public function GroupfbArmyView()
      {
         super();
      }
      
      override public function set data(param1:CampaignArmy) : void
      {
         super.data = param1;
         this.mouseChildren = this.mouseEnabled = true;
      }
      
      override protected function __isDieHandler(param1:CampaignMapEvent) : void
      {
         super.__isDieHandler(param1);
         _precentSpeed = 1;
         changeSpeedTo(_precentSpeed);
         _reviveFlag = true;
         _reviveDelay = setTimeout(setFlag,15000);
         clearBuff();
      }
      
      private function setFlag() : void
      {
         if(_reviveDelay)
         {
            clearTimeout(_reviveDelay);
            _reviveDelay = 0;
         }
         _reviveFlag = false;
      }
      
      override protected function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("DANNAY",__onDannyHandler);
         }
         super.addEvent();
      }
      
      override protected function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("DANNAY",__onDannyHandler);
         }
         super.removeEvent();
      }
      
      private function __onDannyHandler(param1:ArmyEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc9_:MovieClip = null;
         var _loc2_:BitmapData = null;
         var _loc5_:Sprite = null;
         var _loc6_:int = 0;
         var _loc7_:SimpleMovie = null;
         var _loc8_:MapSkillHurtData = param1.data as MapSkillHurtData;
         if(_loc8_ == null)
         {
            return;
         }
         if(_loc8_.effectValue != 0)
         {
            _loc3_ = ComponentFactory.Instance.creat("asset.groupfbmovie.HurtEffect");
            _loc4_ = _loc3_["effectValue"]["number_mc"];
            _loc9_ = _loc3_["effectValue"]["effectType"];
            if(_loc8_.effectType == 1)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmapData("asset.groupfbmovie.AddNumber");
               _loc9_.gotoAndStop(2);
            }
            else if(_loc8_.effectType == 0)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmapData("asset.groupfbmovie.HurtNumber");
               _loc9_.gotoAndStop(1);
            }
            _loc5_ = new Sprite();
            _loc6_ = Math.abs(_loc8_.effectValue);
            NumberViewUtils.getNumberView(_loc6_,_loc5_,_loc2_,21,21,15,21,"1234567890");
            _loc4_.gotoAndStop(1);
            _loc4_.addChild(_loc5_);
            _loc7_ = new SimpleMovie(_loc3_);
            _loc7_.x = -54;
            _loc7_.y = -186;
            addChild(_loc7_);
         }
         if(_reviveFlag)
         {
            return;
         }
         refreshBuff(_loc8_);
      }
      
      private function refreshBuff(param1:MapSkillHurtData) : void
      {
         if(param1.buffLeftTime > 0)
         {
            clearTimeout(_buffDelay);
            if(_buffIcon == null)
            {
               _buffIcon = ComponentFactory.Instance.creatCustomObject("GroupfbArmyView.buffer.ItemIcon");
               addChild(_buffIcon);
            }
            if(_npcName)
            {
               _buffIcon.x = _npcName.x + (_npcName.width + _npcName.textWidth) / 2 + 5;
               _buffIcon.y = _npcName.y;
            }
            if(param1.attackType == 15)
            {
               _buffIcon.icon = ComponentFactory.Instance.creatBitmap("asset.groupfbmovie.buff_poison");
               _buffDelay = setTimeout(clearBuff,param1.buffLeftTime * 1000);
               _buffIcon.tipData = LanguageMgr.GetTranslation("GroupfbArmyView.buffer.decribe01",param1.effectValue,param1.buffLeftTime);
            }
            else if(param1.attackType == 16)
            {
               _buffIcon.icon = ComponentFactory.Instance.creatBitmap("asset.groupfbmovie.buff_ice");
               _buffIcon.tipData = LanguageMgr.GetTranslation("GroupfbArmyView.buffer.decribe02");
               _precentSpeed = 0.3;
               changeSpeedTo(_precentSpeed);
            }
            else if(param1.attackType == 17)
            {
               clearBuff();
            }
         }
         else if(param1.attackType != 16)
         {
            clearBuff();
         }
      }
      
      override protected function showAvatar(param1:CampaignArmy) : void
      {
         super.showAvatar(param1);
         changeSpeedTo(_precentSpeed);
      }
      
      private function clearBuff() : void
      {
         if(_buffIcon)
         {
            _buffIcon.dispose();
         }
         _buffIcon = null;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         clearBuff();
         super.dispose();
      }
   }
}

