package outyard.shuttle
{
   import battle.utils.Int64Utils;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shuttle.ArcaneZoneBossMsg;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class OutyardArcaneItem extends Component implements IEnterFrame
   {
      
      private var _shareBtn:IconButton;
      
      private var _attackBtn:IconButton;
      
      private var _data:ArcaneZoneBossMsg;
      
      public const ARCANE_CLASS_PATH:String = "avatar.view.OutyardArcaneAvatarView";
      
      private var _person:*;
      
      private var _redBar:MovieClip;
      
      private var _bossNameTxt:FilterFrameText;
      
      private var _finderTxt:FilterFrameText;
      
      private var _leftTimeTxt:FilterFrameText;
      
      public function OutyardArcaneItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _shareBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.shareBtn");
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.attackBtn");
         _redBar = ComponentFactory.Instance.creatCustomObject("outyard.arcane.redBar");
         _bossNameTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.BossNameTxt");
         _finderTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.FinderTxt");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.LeftTimeTxt");
         addChild(_shareBtn);
         addChild(_attackBtn);
         addChild(_redBar);
         addChild(_bossNameTxt);
         addChild(_finderTxt);
         addChild(_leftTimeTxt);
         _redBar.gotoAndStop(1);
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         _shareBtn.addEventListener("click",__shareHandler);
         _attackBtn.addEventListener("click",__attackHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _shareBtn.removeEventListener("click",__shareHandler);
         _attackBtn.removeEventListener("click",__attackHandler);
      }
      
      public function set data(param1:ArcaneZoneBossMsg) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:GameHeroTempInfo = null;
         _data = param1;
         if(_data)
         {
            this.visible = true;
            if(_person)
            {
               ObjectUtils.disposeObject(_person);
            }
            _person = null;
            _loc2_ = ConfigInfoManager.instance.getArcaneZoneBossTempId();
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc3_ = _loc2_[_loc5_].split(",");
               if(int(_loc3_[0]) == _data.heroTempId)
               {
                  createAvatar(int(_loc3_[1]));
                  break;
               }
               _loc5_++;
            }
            _loc4_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_data.heroTempId);
            _redBar.gotoAndStop(_data.hpPercent);
            _bossNameTxt.text = _loc4_.TemplateName;
            _finderTxt.htmlText = LanguageMgr.GetTranslation("outyard.Arcane.finder.txt",_data.name);
            _leftTimeTxt.htmlText = LanguageMgr.GetTranslation("outyard.Arcane.leftTime.txt",leftTime);
            _shareBtn.visible = _data.selfFound;
         }
         else
         {
            this.visible = false;
         }
      }
      
      public function createAvatar(param1:int) : void
      {
         var _loc2_:Class = DisplayLoader.Context.applicationDomain.getDefinition("avatar.view.OutyardArcaneAvatarView") as Class;
         _person = new _loc2_();
         var _loc3_:CampaignNode = new CampaignNode();
         _loc3_.info = new PhysicInfo();
         _loc3_.info.types = 21;
         _loc3_.toward = 12;
         _loc3_.sonType = param1;
         _person.nodeInfo = _loc3_;
         var _loc4_:AIBaseInfo = new AIBaseInfo();
         _loc4_.isLiving = true;
         _loc4_.speed = 8;
         _person.info = _loc4_;
         _person.standImp();
         _person.x = 125;
         _person.y = 262;
         addChild(_person);
         addChild(_finderTxt);
      }
      
      public function get leftTime() : String
      {
         var _loc1_:int = Int64Utils.int64ToNumber(_data.escapeTime) / 1000 - PlayerManager.instance.currentPlayerModel.sysSecond;
         var _loc2_:String = DateFormatter.getStopDateString(_loc1_);
         if(_loc1_ <= 60)
         {
            return LanguageMgr.GetTranslation("SaleItemView.lessThanOneMinute");
         }
         return _loc2_;
      }
      
      private function __shareHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         OutyardManager.instance.OperateArcaneShare(2,_data.bossId);
      }
      
      private function __attackHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         OutyardManager.instance.OperateArcane(3,_data.bossId);
      }
      
      public function enterFrame() : void
      {
         if(_person && _person.info)
         {
            _person.execute();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_shareBtn);
         _shareBtn = null;
         ObjectUtils.disposeObject(_attackBtn);
         _attackBtn = null;
         ObjectUtils.disposeObject(_person);
         _person = null;
         ObjectUtils.disposeViolentMc(_redBar);
         _redBar = null;
         ObjectUtils.disposeObject(_bossNameTxt);
         _bossNameTxt = null;
         ObjectUtils.disposeObject(_finderTxt);
         _finderTxt = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         _data = null;
         super.dispose();
      }
   }
}

