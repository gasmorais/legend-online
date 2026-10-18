package theseuspvp.item
{
   import avatar.view.AppellView;
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseusPvpManager;
   import mvc.module.theseuspvp.TheseusPvpShowInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.TheseusPvpTempInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class TheseusPvpZanItem extends Sprite implements IEnterFrame
   {
      
      private var _zanNickTxt:FilterFrameText;
      
      private var _zanServerNameTxt:FilterFrameText;
      
      private var _zanBtn:BaseButton;
      
      private var _zanVbg:Image;
      
      private var _zanGolryTxt:FilterFrameText;
      
      private var _grolyItemIcon:ScaleFrameImage;
      
      private var _man:Bitmap;
      
      private var _avatar:ShowAvatar;
      
      private var _data:ThaneInfo;
      
      private var _honerView:AppellView;
      
      private var _sortIdx:ScaleFrameImage;
      
      private var _appellId:int;
      
      private var _showInfo:TheseusPvpShowInfo;
      
      public function TheseusPvpZanItem(param1:int)
      {
         super();
         initView();
         _sortIdx.setFrame(param1);
         addEvent();
      }
      
      private function initView() : void
      {
         _avatar = new ShowAvatar(false,__onCompleteHandler);
         _avatar.scaleX = _avatar.scaleY = 0.85;
         _avatar.mouseEnabled = _avatar.mouseChildren = false;
         _avatar.x = -80;
         _avatar.y = -237;
         _zanNickTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.zanNickTxt");
         _zanServerNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.zanServerNameTxt");
         _zanBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.zanBtn");
         _zanVbg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.zanVbg");
         _zanGolryTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.zanGolryTxt");
         _grolyItemIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.grolyItemIcon");
         _man = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.man");
         _sortIdx = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.zanSortIdx");
         addChild(_avatar);
         addChild(_zanNickTxt);
         addChild(_zanServerNameTxt);
         addChild(_zanBtn);
         addChild(_zanVbg);
         addChild(_zanGolryTxt);
         addChild(_grolyItemIcon);
         addChild(_man);
         addChild(_sortIdx);
         _zanBtn.enable = false;
         data = null;
      }
      
      public function set appelId(param1:int) : void
      {
         if(_appellId == param1)
         {
            return;
         }
         _appellId = param1;
         var _loc2_:AppellInfoTemplate = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(param1);
         if(_loc2_)
         {
            _honerView = new AppellView(_loc2_);
            _honerView.x = -47;
            _honerView.y = -339;
            addChild(_honerView);
         }
      }
      
      public function set data(param1:TheseusPvpShowInfo) : void
      {
         var _loc2_:TheseusPvpTempInfo = null;
         _showInfo = param1;
         if(param1)
         {
            _zanBtn.visible = true;
            _grolyItemIcon.visible = true;
            _data = param1.thaneInfo;
            _avatar.data = _data;
            _zanNickTxt.text = _data.nickName;
            _zanServerNameTxt.text = "[" + param1.serverName + "]";
            _zanGolryTxt.text = "" + param1.integral;
            _loc2_ = TempleteManager.instance.theseusPvpTempCate.getTempById(param1.pvpId);
            if(_loc2_)
            {
               _grolyItemIcon.setFrame(_loc2_.MainType);
            }
            if(_honerView)
            {
               addChild(_honerView);
            }
            if(_man.parent)
            {
               _man.parent.removeChild(_man);
            }
         }
         else
         {
            _zanBtn.visible = false;
            _zanNickTxt.text = LanguageMgr.GetTranslation("ui.theseuspvp.waitRank");
            _zanServerNameTxt.text = "";
            _zanGolryTxt.text = "";
            _grolyItemIcon.visible = false;
            _avatar.data = null;
            if(_honerView != null && _honerView.parent)
            {
               _honerView.parent.removeChild(_honerView);
            }
            if(_man)
            {
               addChild(_man);
            }
         }
      }
      
      public function updateZanState(param1:int, param2:int) : void
      {
         if(_showInfo != null)
         {
            if(_showInfo.seasonId == param2)
            {
               _zanBtn.enable = param1 == 1 ? false : true;
            }
            else
            {
               _zanBtn.enable = false;
            }
         }
         else
         {
            _zanBtn.enable = false;
         }
      }
      
      private function __onCompleteHandler() : void
      {
         var _loc1_:Boolean = false;
         if(_data)
         {
            _avatar.data = _data;
            _loc1_ = Boolean(PlayerManager.instance.getIsDragonTalkerState(_data));
            _avatar.y = _loc1_ ? -247 : -237;
         }
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         _zanBtn.addEventListener("click",zanHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _zanBtn.removeEventListener("click",zanHandler);
      }
      
      private function zanHandler(param1:MouseEvent) : void
      {
         if(_showInfo)
         {
            TheseusPvpManager.Instance.doSomething(8,_showInfo.rank);
         }
      }
      
      public function enterFrame() : void
      {
         if(_honerView)
         {
            _honerView.draw();
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_zanNickTxt);
         _zanNickTxt = null;
         ObjectUtils.disposeObject(_zanServerNameTxt);
         _zanServerNameTxt = null;
         ObjectUtils.disposeObject(_zanBtn);
         _zanBtn = null;
         ObjectUtils.disposeObject(_zanVbg);
         _zanVbg = null;
         ObjectUtils.disposeObject(_zanGolryTxt);
         _zanGolryTxt = null;
         ObjectUtils.disposeObject(_grolyItemIcon);
         _grolyItemIcon = null;
         ObjectUtils.disposeObject(_man);
         _man = null;
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_sortIdx);
         _sortIdx = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _showInfo = null;
         _data = null;
      }
   }
}

