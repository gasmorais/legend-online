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
   import map.campaign.data.SvsModel;
   import map.campaign.data.SvsUserInfo;
   import mvc.controler.SvsController;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.ConsortiaPlayerMenu;
   
   public class SvsEnterWarLeftItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _overBg:ScaleBitmapImage;
      
      private var _jobIcon:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _addBtn:SimpleBitmapButton;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _menu:ConsortiaPlayerMenu;
      
      private var _filter:UIFilter;
      
      private var _data:SvsUserInfo;
      
      private var _thaneInfo:ThaneInfo;
      
      private var _index:int = 1;
      
      private var _controller:SvsController;
      
      private var _model:SvsModel;
      
      public function SvsEnterWarLeftItem()
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
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("gvg.EnterWarItemBg");
         _overBg = ComponentFactory.Instance.creatComponentByStylename("gvg.EnterWarOverBg");
         _jobIcon = ComponentFactory.Instance.creatComponentByStylename("core.HeroVocation");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("gvg.EnterWarText01");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("gvg.EnterWarText02");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("gvg.EnterWarText04");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("gvg.EnterWarAddBtn");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("gvg.VocationIcon");
         _bg.width = 349;
         _overBg.width = 357;
         _jobIcon.x = 15;
         _jobIcon.y = 4;
         _overBg.visible = false;
         _vocationIcon.visible = false;
         addChild(_bg);
         addChild(_overBg);
         addChild(_jobIcon);
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_fightPowerTxt);
         addChild(_addBtn);
         addChild(_vocationIcon);
         _jobIcon.visible = _addBtn.visible = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         _addBtn.addEventListener("click",onClick);
         this.addEventListener("mouseOver",onMouseOver);
         this.addEventListener("rollOut",onMouseOut);
         this.addEventListener("click",__onClick);
      }
      
      private function removeEvent() : void
      {
         _addBtn.removeEventListener("click",onClick);
         this.removeEventListener("mouseOver",onMouseOver);
         this.removeEventListener("rollOut",onMouseOut);
         this.removeEventListener("click",__onClick);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         if(_data.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            return;
         }
         _menu = new ConsortiaPlayerMenu();
         _menu.x = StageReferance.stage.mouseX;
         var _loc2_:Point = localToGlobal(new Point(0,height));
         _menu.y = _loc2_.y - 10;
         _menu.closeRights = false;
         _menu.setData(_data.thane);
         LayerManager.Instance.addToLayer(_menu,7);
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
         _controller.sendSvsUserInfoEdit(_thaneInfo.userId,true);
         if(param1)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      public function get data() : SvsUserInfo
      {
         return _data;
      }
      
      public function set data(param1:SvsUserInfo) : void
      {
         _data = param1;
         if(data)
         {
            _thaneInfo = data.thane;
            _jobIcon.setFrame(ThaneInfoHelper.getJob(_thaneInfo.job));
            _nameTxt.text = _thaneInfo.nickName;
            _gradeTxt.text = String(_thaneInfo.grades);
            _fightPowerTxt.text = String(_thaneInfo.fightingCapacity);
            _addBtn.visible = _model.isHostPlayer;
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
            _jobIcon.visible = _addBtn.visible = _vipIcon.visible = _vipText.visible = false;
            removeEvent();
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
         addChild(_vipIcon);
         _vipIcon.x = _nameTxt.x - _vipIcon.width;
         _vipIcon.y = _nameTxt.y + 1;
         _vipText = ComponentFactory.Instance.creatComponentByStylename("gvg.EnterWarText01.GradientText");
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

