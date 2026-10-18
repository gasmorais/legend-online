package outyard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.OutyardUserInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.PlayerMenu;
   
   public class OutyardMemberItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _overBg:ScaleBitmapImage;
      
      private var _jobIcon:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _stateTxt:FilterFrameText;
      
      private var _changeBtn:IconButton;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _menu:PlayerMenu;
      
      private var _filter:UIFilter;
      
      private var _data:OutyardUserInfo;
      
      private var _type:int;
      
      private var _thaneInfo:ThaneInfo;
      
      private var _index:int = 1;
      
      private var _isSelected:Boolean;
      
      public function OutyardMemberItem()
      {
         super();
         initView();
         addEvent();
         setVipIcon();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarItemBg");
         _overBg = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarOverBg");
         _jobIcon = ComponentFactory.Instance.creatComponentByStylename("core.HeroVocation");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.SteelMemberItem.NameTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.SteelMemberItem.GradeTxt");
         _stateTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.SteelMemberItem.StateTxt");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.SteelMemberItem.FightPowerTxt");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.SteelMemberItem.DelBtn");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("outyard.VocationIcon");
         _filter = new UIFilter();
         _jobIcon.x = 33;
         _jobIcon.y = 4;
         _overBg.visible = false;
         _vocationIcon.visible = false;
         addChild(_bg);
         addChild(_overBg);
         addChild(_jobIcon);
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_stateTxt);
         addChild(_fightPowerTxt);
         addChild(_changeBtn);
         addChild(_vocationIcon);
         _changeBtn.enable = false;
         var _loc2_:SimpleDictionary = ConsortiaManager.instance.model.consortiaMemberList;
         for each(var _loc1_:ThaneInfo in _loc2_)
         {
            if(_loc1_.userId == playerInfo.userId && _loc1_.dutyId == 1)
            {
               _changeBtn.enable = true;
            }
         }
      }
      
      private function addEvent() : void
      {
         _changeBtn.addEventListener("click",onClick);
         this.addEventListener("mouseOver",onMouseOver);
         this.addEventListener("rollOut",onMouseOut);
      }
      
      private function removeEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",onClick);
         }
         this.removeEventListener("mouseOver",onMouseOver);
         this.removeEventListener("rollOut",onMouseOut);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.outyardControler.selectSenior = _data.index;
         var _loc2_:OutyardChangeFrame = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardChangeFrame");
         _loc2_.show();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(_thaneInfo)
         {
            _overBg.visible = true;
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         _overBg.visible = false;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         if(!_isSelected)
         {
            _overBg.visible = false;
         }
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get data() : OutyardUserInfo
      {
         return _data;
      }
      
      public function set data(param1:OutyardUserInfo) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         _data = param1;
         if(data)
         {
            _thaneInfo = data.thane;
            _jobIcon.setFrame(_thaneInfo.job);
            _nameTxt.text = _thaneInfo.nickName ? _thaneInfo.nickName : "";
            _jobIcon.visible = true;
            if(_type == 0)
            {
               _gradeTxt.text = String(_thaneInfo.grades);
               _fightPowerTxt.text = String(_thaneInfo.fightingCapacity);
               _loc3_ = LanguageMgr.GetTranslation("outyard.OutyardMemberItem.DefenceHandler");
               _loc2_ = LanguageMgr.GetTranslation("outyard.OutyardMemberItem.DefeatedHandler");
               _stateTxt.text = _data.defenceAlive ? _loc3_ : _loc2_;
               _changeBtn.visible = false;
            }
            else
            {
               _gradeTxt.text = _thaneInfo.fightingCapacity != 0 ? String(_thaneInfo.fightingCapacity) : "";
               _loc4_ = ConfigInfoManager.instance.getStackHeadSeniorGeneralBuff();
               _loc5_ = int(_loc4_[_data.index - 1]);
               _fightPowerTxt.text = String(_loc5_) + "%";
               _changeBtn.visible = true;
            }
            gray = _data.defenceAlive;
            if(isVip)
            {
               _vipIcon.visible = true;
               _nameTxt.visible = false;
               _vipText.visible = true;
               _vipText.text = _nameTxt.text;
            }
            else
            {
               _vipIcon.visible = false;
               _nameTxt.visible = true;
               _vipText.visible = false;
            }
         }
         else
         {
            gray = true;
            removeEvent();
            _changeBtn.visible = false;
            _jobIcon.visible = false;
            _vipIcon.visible = false;
            _vipText.visible = false;
            _nameTxt.visible = false;
         }
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         if(_thaneInfo && _thaneInfo.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_thaneInfo.templateInfo.Job,_thaneInfo.vocationStep,_thaneInfo.vocationLevel);
            _vocationIcon.setFrame(_thaneInfo.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      private function setVipIcon() : void
      {
         _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
         _vipText = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarText01_R.GradientText");
         _vipIcon.x = _nameTxt.x - _vipIcon.width;
         _vipIcon.y = _nameTxt.y + 1;
         addChild(_vipIcon);
         addChild(_vipText);
      }
      
      private function get isVip() : Boolean
      {
         return _thaneInfo.IsVipAndNoExpirt;
      }
      
      public function set gray(param1:Boolean) : void
      {
         if(param1)
         {
            if(_bg)
            {
               _filter.setNormalFilter(_bg);
            }
            if(_jobIcon)
            {
               _filter.setNormalFilter(_jobIcon);
            }
            if(_nameTxt)
            {
               _filter.setNormalFilter(_nameTxt);
            }
            if(_vipIcon)
            {
               _filter.setNormalFilter(_vipIcon);
            }
            if(_vipText)
            {
               _filter.setNormalFilter(_vipText);
            }
            if(_gradeTxt)
            {
               _filter.setNormalFilter(_gradeTxt);
            }
            if(_stateTxt)
            {
               _filter.setNormalFilter(_stateTxt);
            }
            if(_fightPowerTxt)
            {
               _filter.setNormalFilter(_fightPowerTxt);
            }
            if(_vocationIcon)
            {
               _filter.setNormalFilter(_vocationIcon);
            }
         }
         else
         {
            if(_bg)
            {
               _filter.setGrayFilter(_bg);
            }
            if(_jobIcon)
            {
               _filter.setGrayFilter(_jobIcon);
            }
            if(_nameTxt)
            {
               _filter.setGrayFilter(_nameTxt);
            }
            if(_vipIcon)
            {
               _filter.setGrayFilter(_vipIcon);
            }
            if(_vipText)
            {
               _filter.setGrayFilter(_vipText);
            }
            if(_gradeTxt)
            {
               _filter.setGrayFilter(_gradeTxt);
            }
            if(_stateTxt)
            {
               _filter.setGrayFilter(_stateTxt);
            }
            if(_fightPowerTxt)
            {
               _filter.setGrayFilter(_fightPowerTxt);
            }
            if(_vocationIcon)
            {
               _filter.setGrayFilter(_vocationIcon);
            }
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _bg.setFrame(_index % 2 + 1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_jobIcon);
         _jobIcon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_fightPowerTxt);
         _fightPowerTxt = null;
         ObjectUtils.disposeObject(_stateTxt);
         _stateTxt = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         _data = null;
         _thaneInfo = null;
         super.dispose();
      }
   }
}

