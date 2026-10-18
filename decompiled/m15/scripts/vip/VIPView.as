package vip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   
   public class VIPView extends Component
   {
      
      private var _privilegeBtn:IconButton;
      
      private var _time:FilterFrameText;
      
      private var _timeBg:Bitmap;
      
      private var _friendBtn:SelectedButton;
      
      private var _selfBtn:SelectedButton;
      
      private var _frameVipIcon:Bitmap;
      
      private var _frameVipIcon01:Bitmap;
      
      private var _frameVipIcon00:Bitmap;
      
      private var _frameExp:MovieImage;
      
      private var _frienView:OpenFriendView;
      
      private var _selfView:OpenSelfView;
      
      private var _levelTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _vipGradeNunBg:BitmapData;
      
      private var _vipGradeSp:Sprite;
      
      private var _vipFrameBack:MutipleImage;
      
      private var _helpBtn:BaseButton;
      
      public function VIPView()
      {
         super();
         initView();
         initEvent();
         __UpViewFrame(null);
      }
      
      private function initView() : void
      {
         _privilegeBtn = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeBtn");
         _time = ComponentFactory.Instance.creatComponentByStylename("vip.vipFrameTime");
         _timeBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipFrameTimeBg");
         _selfBtn = ComponentFactory.Instance.creatComponentByStylename("vip.SelfBtn");
         _friendBtn = ComponentFactory.Instance.creatComponentByStylename("vip.FriendBtn");
         _frameVipIcon = ComponentFactory.Instance.creatBitmap("asset.vip.FrameVipIcon");
         _frameVipIcon01 = ComponentFactory.Instance.creatBitmap("asset.vip.FrameVipIcon01");
         _frameVipIcon00 = ComponentFactory.Instance.creatBitmap("asset.vip.FrameVipIcon00");
         _frameExp = ComponentFactory.Instance.creatComponentByStylename("vip.vipFrameExp");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("vip.LevelTxt");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("vip.ExpTxt");
         _vipFrameBack = ComponentFactory.Instance.creatComponentByStylename("vip.vipFrameBack");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("vip.HelpBtn");
         _vipGradeNunBg = ComponentFactory.Instance.creatBitmapData("asset.vip.VipGradeNunber");
         _vipGradeSp = new Sprite();
         addChild(_vipFrameBack);
         addChild(_privilegeBtn);
         addChild(_frameVipIcon);
         addChild(_frameVipIcon00);
         addChild(_frameVipIcon01);
         addChild(_time);
         addChild(_timeBg);
         addChild(_frameExp);
         addChild(_expTxt);
         addChild(_levelTxt);
         addChild(_vipGradeSp);
         addChild(_helpBtn);
         _vipGradeSp.x = _frameVipIcon.x + 29;
         var _loc1_:String = LanguageMgr.GetTranslation("vip.VIPFrame.tipDataTitle",vipModel.vipInfo.VipGp);
         var _loc2_:String = LanguageMgr.GetTranslation("vip.VIPFrame.tipDataContent");
         _frameExp.tipData = {
            "title":_loc1_,
            "content":_loc2_
         };
         _helpBtn.tipData = LanguageMgr.GetTranslation("vip.VIPFrame.help");
      }
      
      private function initEvent() : void
      {
         _friendBtn.addEventListener("click",__friendHandler);
         _selfBtn.addEventListener("click",__selfHandler);
         _privilegeBtn.addEventListener("click",__privilegeHandler);
         _helpBtn.addEventListener("click",__onHelpClick);
         vipModel.addEventListener("upframeview_change",__UpViewFrame);
         _selfBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      public function __UpViewFrame(param1:Event) : void
      {
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            _frameVipIcon00.visible = false;
            _vipGradeSp.visible = true;
            _time.text = DateFormatter.getFullDateString(vipModel.vipInfo.ExpirData.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
            if(vipModel.vipInfo.VipType == 1)
            {
               _frameVipIcon01.visible = true;
               _frameVipIcon.visible = false;
               _vipGradeSp.y = 30;
            }
            else
            {
               _frameVipIcon.visible = true;
               _frameVipIcon01.visible = false;
               _vipGradeSp.y = 24;
            }
         }
         else
         {
            _frameVipIcon00.visible = true;
            _frameVipIcon.visible = false;
            _frameVipIcon01.visible = false;
            _vipGradeSp.visible = false;
            _time.text = "";
         }
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(vipModel.vipInfo.VipGrade + 1,4);
         if(!_loc2_)
         {
            _frameExp.setFrame(100);
            _expTxt.text = vipModel.vipInfo.VipGp + "";
         }
         else if(_loc2_.Data == 0)
         {
            _frameExp.setFrame(1);
            _expTxt.text = vipModel.vipInfo.VipGp + " / " + vipModel.vipInfo.VipGp;
         }
         else
         {
            _frameExp.setFrame(int(vipModel.vipInfo.VipGp / _loc2_.Data * 100));
            _expTxt.text = vipModel.vipInfo.VipGp + " / " + _loc2_.Data;
         }
         _levelTxt.text = vipModel.vipInfo.VipGrade + "";
         NumberViewUtils.refreshValue(vipModel.vipInfo.VipGrade - 1,_vipGradeSp,_vipGradeNunBg,24,27,0,24);
         var _loc3_:String = LanguageMgr.GetTranslation("vip.VIPFrame.tipDataTitle",vipModel.vipInfo.VipGp);
         var _loc4_:String = LanguageMgr.GetTranslation("vip.VIPFrame.tipDataContent");
         _frameExp.tipData = {
            "title":_loc3_,
            "content":_loc4_
         };
      }
      
      private function __friendHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _selfBtn.selected = false;
         _selfBtn.mouseEnabled = true;
         _friendBtn.selected = true;
         _friendBtn.mouseEnabled = false;
         if(_selfView)
         {
            if(_selfView.parent)
            {
               _selfView.parent.removeChild(_selfView);
            }
            _selfView.dispose();
            _selfView = null;
         }
         if(!_frienView)
         {
            _frienView = new OpenFriendView();
            addChild(_frienView);
            _frienView.x = 2;
            _frienView.y = 145;
         }
      }
      
      private function __selfHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _selfBtn.selected = true;
         _selfBtn.mouseEnabled = false;
         _friendBtn.selected = false;
         _friendBtn.mouseEnabled = true;
         if(_frienView)
         {
            if(_frienView.parent)
            {
               _frienView.parent.removeChild(_frienView);
            }
            _frienView.dispose();
            _frienView = null;
         }
         if(!_selfView)
         {
            _selfView = new OpenSelfView();
            addChild(_selfView);
            _selfView.x = 2;
            _selfView.y = 120;
         }
      }
      
      private function __privilegeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.vipController.showPrivilegeFrame();
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("vip.VIPHelpFrame");
         _loc2_["show"]();
      }
      
      private function removeEvent() : void
      {
         _friendBtn.removeEventListener("click",__friendHandler);
         _selfBtn.removeEventListener("click",__selfHandler);
         _privilegeBtn.removeEventListener("click",__privilegeHandler);
         _helpBtn.removeEventListener("click",__onHelpClick);
         vipModel.removeEventListener("upframeview_change",__UpViewFrame);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,600,565);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

