package svs.view.warteam
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import map.campaign.data.SvsModel;
   import map.campaign.data.SvsUserInfo;
   import mvc.controler.SvsController;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.PlayerMenu;
   
   public class SvsEnterWarRightItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _overBg:ScaleBitmapImage;
      
      private var _captionIcon:ScaleBitmapImage;
      
      private var _jobIcon:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _stateTxt:FilterFrameText;
      
      private var _teamTxt:FilterFrameText;
      
      private var _delBtn:SimpleBitmapButton;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _menu:PlayerMenu;
      
      private var _filter:UIFilter;
      
      private var _data:SvsUserInfo;
      
      private var _thaneInfo:ThaneInfo;
      
      private var _index:int = 1;
      
      private var _controller:SvsController;
      
      private var _model:SvsModel;
      
      private var _isSelected:Boolean;
      
      public function SvsEnterWarRightItem()
      {
         super();
         _controller = FrameControllerManager.instance.svsController;
         _model = _controller.model;
         initView();
         addEvent();
         setVipIcon();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,441,32);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("svs.EnterWarItemBg");
         _overBg = ComponentFactory.Instance.creatComponentByStylename("svs.EnterWarOverBg");
         _captionIcon = ComponentFactory.Instance.creatComponentByStylename("svs.CaptainFlag");
         _jobIcon = ComponentFactory.Instance.creatComponentByStylename("core.HeroVocation");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("svs.EnterWarText01_R");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("svs.EnterWarText02");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("svs.EnterWarText03");
         _stateTxt = ComponentFactory.Instance.creatComponentByStylename("svs.EnterWarText04");
         _teamTxt = ComponentFactory.Instance.creatComponentByStylename("svs.EnterWarText05");
         _delBtn = ComponentFactory.Instance.creatComponentByStylename("svs.EnterWarDelBtn");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("svs.VocationIcon");
         _filter = new UIFilter();
         _captionIcon.x = 0;
         _captionIcon.y = 4;
         _jobIcon.x = 20;
         _jobIcon.y = 4;
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
         addChild(_teamTxt);
         addChild(_fightPowerTxt);
         addChild(_delBtn);
         addChild(_vocationIcon);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_captionIcon);
         _captionIcon = null;
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
         ObjectUtils.disposeObject(_delBtn);
         _delBtn = null;
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
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         _delBtn.addEventListener("click",onClick);
         this.addEventListener("mouseOver",onMouseOver);
         this.addEventListener("rollOut",onMouseOut);
         this.addEventListener("click",__selectItemHandler);
      }
      
      private function removeEvent() : void
      {
         _delBtn.removeEventListener("click",onClick);
         this.removeEventListener("mouseOver",onMouseOver);
         this.removeEventListener("rollOut",onMouseOut);
         this.removeEventListener("click",__selectItemHandler);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _controller.sendSvsUserInfoEdit(_thaneInfo.userId,false);
         if(param1)
         {
            param1.stopImmediatePropagation();
         }
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
         if(_controller.model.selectUser != _thaneInfo)
         {
            _overBg.visible = false;
         }
      }
      
      private function __selectItemHandler(param1:MouseEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:Point = null;
         if(_thaneInfo)
         {
            if(_thaneInfo.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               return;
            }
            _loc3_ = FreedomTeamManager.instance.canInviteMember(_thaneInfo.id,_thaneInfo.grades);
            _menu = new PlayerMenu(false,false,false,false,_loc3_);
            _menu.x = StageReferance.stage.mouseX;
            _loc2_ = localToGlobal(new Point(0,height));
            _menu.y = _loc2_.y - 10;
            _menu.setData(_thaneInfo);
            LayerManager.Instance.addToLayer(_menu,7);
            param1.stopImmediatePropagation();
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
      
      public function get data() : SvsUserInfo
      {
         return _data;
      }
      
      public function set data(param1:SvsUserInfo) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         _data = param1;
         if(data)
         {
            _thaneInfo = data.thane;
            _jobIcon.setFrame(ThaneInfoHelper.getJob(_thaneInfo.job));
            _nameTxt.text = _thaneInfo.nickName;
            _gradeTxt.text = String(_thaneInfo.grades);
            _fightPowerTxt.text = String(_thaneInfo.fightingCapacity);
            _captionIcon.visible = _data.hostPlayer == 1;
            _loc3_ = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.UserStateTipsTxtNone");
            _loc2_ = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.UserStateTipsTxtEnter");
            _loc4_ = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.UserStateTipsTxtTeam");
            _stateTxt.text = _data.isEnterPvp ? _loc2_ : _loc3_;
            _teamTxt.text = _data.hasTeam ? _loc4_ : _loc3_;
            _delBtn.visible = _data.userId != _model.hostPlayerId && _model.isHostPlayer;
            _jobIcon.visible = true;
            gray = _thaneInfo.isOnline;
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
            _delBtn.visible = false;
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
         _vipText = ComponentFactory.Instance.creatComponentByStylename("svs.EnterWarText01_R.GradientText");
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
            if(_teamTxt)
            {
               _filter.setNormalFilter(_teamTxt);
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
            if(_teamTxt)
            {
               _filter.setGrayFilter(_teamTxt);
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

