package vehicle.daimontrial.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class DaimonTrialRightView extends Component
   {
      
      private var _border:Scale9CornerImage;
      
      private var _bg:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _infoContain:Sprite;
      
      private var _infoTxt:FilterFrameText;
      
      private var _changeBtn:IconButton;
      
      private var _tip:DaimonInfoTip;
      
      private var _contentSprite:Sprite;
      
      private var _vehiclemc:Bitmap;
      
      private var _daimonFrame:Frame;
      
      public function DaimonTrialRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialRightView.BgBorder2");
         _bg = ComponentFactory.Instance.creat("asset.daimon.VehicleBack");
         _bg.x = 1;
         _bg.y = -1;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialLeftView.NameTxt");
         _infoTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialLeftView.InfoTxt");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialLeftView.ChangeBtn");
         _contentSprite = new Sprite();
         _contentSprite.x = 135;
         _contentSprite.y = 200;
         _infoContain = new Sprite();
         _infoContain.x = _infoTxt.x;
         _infoContain.y = _infoTxt.y;
         _infoTxt.x = 0;
         _infoTxt.y = 0;
         _infoContain.addChild(_infoTxt);
         _infoContain.buttonMode = true;
         addChild(_border);
         addChild(_bg);
         addChild(_contentSprite);
         addChild(_nameTxt);
         addChild(_infoContain);
         addChild(_changeBtn);
         _infoTxt.htmlText = "<u><a href=\'event:#\'>" + LanguageMgr.GetTranslation("vehicle.lookInfo") + "</a></u>";
         _infoTxt.mouseEnabled = _infoTxt.selectable = false;
      }
      
      private function addEvent() : void
      {
         _changeBtn.addEventListener("click",__changeClickHandler);
         _infoContain.addEventListener("click",__linkClickHandler);
         StageReferance.stage.addEventListener("click",__downHandler);
      }
      
      private function removeEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",__changeClickHandler);
         }
         if(_infoContain)
         {
            _infoContain.removeEventListener("click",__linkClickHandler);
         }
         StageReferance.stage.removeEventListener("click",__downHandler);
      }
      
      private function __changeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_daimonFrame)
         {
            _daimonFrame.dispose();
            _daimonFrame = null;
         }
         _daimonFrame = FrameControllerManager.instance.vehicleDaimonController.openWithoutGroup();
      }
      
      private function __linkClickHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(_tip)
         {
            _tip.dispose();
            _tip = null;
            param1.stopImmediatePropagation();
            return;
         }
         _tip = new DaimonInfoTip();
         _tip.x = _infoContain.x + _infoContain.width;
         _tip.y = _infoContain.y + _infoTxt.textHeight + 3;
         addChild(_tip);
      }
      
      private function __downHandler(param1:Event) : void
      {
         if(_tip && param1.target != _infoTxt)
         {
            _tip.dispose();
            _tip = null;
            return;
         }
      }
      
      private function unitView() : void
      {
         _bg = null;
         _nameTxt = null;
         _infoTxt = null;
         _changeBtn = null;
         _border = null;
      }
      
      public function update() : void
      {
         var _loc2_:VehicleObjectTempInfo = PlayerManager.instance.currentPlayerModel.playerInfo.vehicleTemplate;
         if(!_loc2_)
         {
            return;
         }
         _nameTxt.text = _loc2_.TemplateName;
         var _loc1_:String = PathManager.getVehicleShowAvatarPath(_loc2_.Avatar);
         if(_loc1_ == "")
         {
            return;
         }
         LoaderManagerII.instance.load(_loc1_,2,8,__onCompleteHandler);
      }
      
      private function __onCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_contentSprite);
         _vehiclemc = param2 as Bitmap;
         if(_vehiclemc)
         {
            _contentSprite.addChild(_vehiclemc);
            _vehiclemc.x = -(_vehiclemc.width >> 1);
            _vehiclemc.y = -(_vehiclemc.height - 35);
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onCompleteHandler);
         if(_daimonFrame)
         {
            _daimonFrame.dispose();
            _daimonFrame = null;
         }
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

