package outyard
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.hugehead.StackHeadSeniorGeneralMsg;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.data.OutyardUserInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   
   public class OutyardChangeItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _overBg:ScaleBitmapImage;
      
      private var _captionIcon:ScaleBitmapImage;
      
      private var _jobIcon:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _stateTxt:FilterFrameText;
      
      private var _info:OutyardUserInfo;
      
      private var _data:ThaneInfo;
      
      private var _index:int = 1;
      
      private var _filter:UIFilter;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _isSelected:Boolean;
      
      public function OutyardChangeItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarItemBg2");
         _overBg = ComponentFactory.Instance.creatComponentByStylename("outyard.Item.EnterWarOverBg");
         _captionIcon = ComponentFactory.Instance.creatComponentByStylename("outyard.CaptainFlag");
         _jobIcon = ComponentFactory.Instance.creatComponentByStylename("core.HeroVocation");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarText01_R");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarText02");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarText03");
         _stateTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarText04");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("outyard.VocationIcon");
         _captionIcon.x = 0;
         _captionIcon.y = 4;
         _jobIcon.x = 20;
         _jobIcon.y = 4;
         _stateTxt.x = 215;
         _captionIcon.visible = false;
         _overBg.visible = false;
         _vocationIcon.visible = false;
         addChild(_bg);
         addChild(_overBg);
         addChild(_captionIcon);
         addChild(_jobIcon);
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_stateTxt);
         addChild(_fightPowerTxt);
         _fightPowerTxt.x = 322;
         addChild(_vocationIcon);
         setVipIcon();
      }
      
      private function addEvent() : void
      {
         this.addEventListener("mouseOver",onMouseOver);
         this.addEventListener("rollOut",onMouseOut);
         this.addEventListener("click",__selectItemHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseOver",onMouseOver);
         this.removeEventListener("rollOut",onMouseOut);
         this.removeEventListener("click",__selectItemHandler);
      }
      
      private function __selectItemHandler(param1:MouseEvent) : void
      {
         var _loc2_:StackHeadSeniorGeneralMsg = null;
         if(_data)
         {
            _loc2_ = new StackHeadSeniorGeneralMsg();
            _loc2_.userUid = _info.userUid;
            _loc2_.index = FrameControllerManager.instance.outyardControler.selectSenior;
            OutyardManager.instance.OperateOutyard(8,0,"",_loc2_);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_CHANGE_SENIOR"));
         }
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         if(!_isSelected)
         {
            _overBg.visible = false;
         }
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
         if(_data)
         {
            _overBg.visible = true;
         }
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
         _overBg.visible = false;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         param1.stopImmediatePropagation();
      }
      
      private function addDataListener() : void
      {
         if(_data)
         {
            _data.addEventListener("UPDE_MEMEBER_STATE",__memberStateChangeHandler);
         }
      }
      
      private function removeDataListener() : void
      {
         if(_data)
         {
            _data.removeEventListener("UPDE_MEMEBER_STATE",__memberStateChangeHandler);
         }
      }
      
      private function __memberStateChangeHandler(param1:ConsortiaEvent) : void
      {
         if(_data)
         {
            gray = _data.isOnline;
         }
      }
      
      public function get info() : OutyardUserInfo
      {
         return _info;
      }
      
      public function set info(param1:OutyardUserInfo) : void
      {
         _info = param1;
         data = _info ? _info.thane : null;
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         var _loc2_:int = 0;
         removeDataListener();
         _data = param1;
         addDataListener();
         if(data)
         {
            _jobIcon.setFrame(_info.job);
            _nameTxt.text = data.nickName;
            _gradeTxt.text = String(data.grades);
            _fightPowerTxt.text = String(data.fightingCapacity);
            _captionIcon.visible = _data.dutyId == 1 || _data.dutyId == 2;
            _stateTxt.text = _data.isInwar == 0 ? LanguageMgr.GetTranslation("groupfb.GroupfbTeamItem.wait") : LanguageMgr.GetTranslation("gvg.view.EnterWarrightitem");
            addEvent();
            _loc2_ = int(ConsortiaManager.instance.model.consortiaInfo.chairmanID);
            _jobIcon.visible = true;
            gray = _data.isOnline;
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
            removeEvent();
            _jobIcon.visible = false;
            _vipIcon.visible = false;
            _vipText.visible = false;
            _nameTxt.visible = false;
         }
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         if(_data && _data.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_data.templateInfo.Job,_data.vocationStep,_data.vocationLevel);
            _vocationIcon.setFrame(_data.vocationLevel);
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
         addChild(_vipIcon);
         _vipIcon.x = _nameTxt.x - _vipIcon.width;
         _vipIcon.y = _nameTxt.y + 1;
         _vipText = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarText01_R.GradientText");
         addChild(_vipText);
      }
      
      private function get isVip() : Boolean
      {
         return _data.IsVipAndNoExpirt;
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
      
      public function dispose() : void
      {
         removeDataListener();
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_overBg)
         {
            _overBg.dispose();
         }
         _overBg = null;
         if(_captionIcon)
         {
            _captionIcon.dispose();
         }
         _captionIcon = null;
         if(_jobIcon)
         {
            _jobIcon.dispose();
         }
         _jobIcon = null;
         if(_fightPowerTxt)
         {
            _fightPowerTxt.dispose();
         }
         _fightPowerTxt = null;
         if(_stateTxt)
         {
            _stateTxt.dispose();
         }
         _stateTxt = null;
         _bg = null;
         _overBg = null;
         _captionIcon = null;
         _gradeTxt = null;
         _fightPowerTxt = null;
         _data = null;
         if(_jobIcon)
         {
            _jobIcon.filters = null;
            _jobIcon.dispose();
            _jobIcon = null;
         }
         if(_nameTxt)
         {
            _nameTxt.filters = null;
            _nameTxt.dispose();
            _nameTxt = null;
         }
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         if(parent)
         {
            parent.removeChild(this);
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
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,441,32);
      }
   }
}

