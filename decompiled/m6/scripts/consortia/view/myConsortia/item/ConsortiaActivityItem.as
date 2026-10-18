package consortia.view.myConsortia.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaActivityInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaNewBossModel;
   import yishi.datas.VersionSwitch;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.ConsortiaNewBossManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaActivityItem extends Component implements IManualSize
   {
      
      private var _operateText:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _itemBg:Image;
      
      private var _joinBtn:IconButton;
      
      private var _shopBtn:IconButton;
      
      private var _activityIcon:ScaleFrameImage;
      
      private var _activityNameImage:ScaleFrameImage;
      
      private var _infoTipMc:MovieClip;
      
      private var _data:ConsortiaActivityInfo;
      
      private var _openStateMc:MovieClip;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _txtBg:Bitmap;
      
      public function ConsortiaActivityItem()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,300,217);
      }
      
      private function initView() : void
      {
         _operateText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaActivityItem.operateText");
         _descText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaActivityItem.descText");
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaActivityItem.itemBg");
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaActivityItem.joinBtn");
         _activityNameImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaActivityItem.activityNameImage");
         _activityIcon = ComponentFactory.Instance.creatComponentByStylename("ConsortiaActivityItem.activityIcon");
         _infoTipMc = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaActivityItem.shopBtn");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.Consortia.resource.activity.txtBg");
         addChild(_itemBg);
         addChild(_activityIcon);
         addChild(_activityNameImage);
         addChild(_descText);
         addChild(_txtBg);
         _txtBg.visible = false;
         addChild(_operateText);
         addChild(_shopBtn);
         addChild(_joinBtn);
         _joinBtn.addChild(_infoTipMc);
         _effect = new MainToolBtnGlowEffect(_joinBtn);
         _effect.stop();
         _infoTipMc.mouseChildren = false;
         _infoTipMc.mouseEnabled = false;
         _infoTipMc.x = 85;
         _infoTipMc.y = -9;
         _operateText.mouseEnabled = true;
         this.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _joinBtn.addEventListener("click",_joinBtnClickHandler);
         _operateText.addEventListener("click",_operateClickHandler);
         _shopBtn.addEventListener("click",_shopBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_joinBtn)
         {
            _joinBtn.removeEventListener("click",_joinBtnClickHandler);
         }
         if(_operateText)
         {
            _operateText.removeEventListener("click",_operateClickHandler);
         }
         if(_shopBtn)
         {
            _shopBtn.removeEventListener("click",_shopBtnClickHandler);
         }
      }
      
      private function _shopBtnClickHandler(param1:MouseEvent) : void
      {
         if(ConsortiaManager.instance.model.consortiaInfo.shopLevel > 0)
         {
            if(data.id == 5)
            {
               FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":4});
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":5});
            }
         }
         else if(data.id == 5)
         {
            FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":0});
         }
         else if(VersionSwitch.CROSS_GUILD)
         {
            FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":1});
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":0});
         }
      }
      
      private function _joinBtnClickHandler(param1:MouseEvent) : void
      {
         if(_openStateMc)
         {
            model.openEffectDic[_data.id] = false;
            ObjectUtils.disposeViolentMc(_openStateMc);
            _openStateMc = null;
         }
         if(data && data.gotoFunction != null)
         {
            data.gotoFunction();
         }
      }
      
      private function _operateClickHandler(param1:MouseEvent) : void
      {
         if(data && data.operatingFun != null)
         {
            data.operatingFun();
         }
      }
      
      public function set data(param1:ConsortiaActivityInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         _shopBtn.visible = false;
         if(data)
         {
            _loc2_ = 3;
            _joinBtn.visible = true;
            _activityNameImage.visible = true;
            _activityIcon.visible = true;
            _activityIcon.setFrame(data.id + _loc2_);
            _activityNameImage.setFrame(data.id + _loc2_);
            _descText.text = data.promptTxt;
            _operateText.htmlText = data.operatingLabel ? data.operatingLabel : "";
            _txtBg.visible = data.operatingLabel ? true : false;
            _infoTipMc.visible = data.redTipNum > 0;
            _infoTipMc.txt.text = data.redTipNum + "";
            setEffectById(data.id);
            if(data.isNeedJoinMc)
            {
               _effect.play();
            }
            else
            {
               _effect.stop();
            }
            if(data.id == 0)
            {
               if(consortiaNewBossModel.bossId > 0 && !consortiaNewBossModel.isOver())
               {
                  _shopBtn.visible = true;
               }
            }
         }
         else
         {
            _descText.text = "";
            _operateText.text = "";
            _txtBg.visible = false;
            _joinBtn.visible = false;
            _activityNameImage.visible = false;
            _activityIcon.visible = false;
            _infoTipMc.visible = false;
            _effect.stop();
            setEffect(false);
         }
      }
      
      private function setEffectById(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               setEffect(consortiaNewBossModel.bossId > 0 && !consortiaNewBossModel.isOver());
               this.tipData = LanguageMgr.GetTranslation("consortia.view.ConsortiaActivityItem.tipData0");
               break;
            case 1:
               setEffect(model.secretInfo.treeState == 1);
               this.tipData = LanguageMgr.GetTranslation("consortia.view.ConsortiaActivityItem.tipData1");
               break;
            case 2:
               setEffect(false);
               this.tipData = LanguageMgr.GetTranslation("consortia.view.ConsortiaActivityItem.tipData2");
               break;
            case 3:
               setEffect(model.emeDreamInfo.state == 1 || model.emeDreamInfo.state == 2);
               this.tipData = LanguageMgr.GetTranslation("consortia.view.ConsortiaActivityItem.tipData3");
               break;
            case 4:
               setEffect(false);
               this.tipData = LanguageMgr.GetTranslation("consortia.view.ConsortiaActivityItem.tipData4");
               break;
            case 5:
               setEffect(CrossGuildManager.instance.model.state == 6);
               this.tipData = LanguageMgr.GetTranslation("consortia.view.ConsortiaActivityItem.tipData5");
               break;
            case 6:
               setEffect(false);
               this.tipData = LanguageMgr.GetTranslation("consortia.view.ConsortiaActivityItem.tipData6");
         }
      }
      
      private function setEffect(param1:Boolean) : void
      {
         if(param1 && Boolean(model.getNeedByEffectKey(_data.id)))
         {
            if(!_openStateMc)
            {
               _openStateMc = ComponentFactory.Instance.creatCustomObject("ConsortiaActivityItem.openStateMc");
            }
            _openStateMc.mouseChildren = _openStateMc.mouseEnabled = false;
            addChild(_openStateMc);
            _openStateMc.play();
         }
         else if(_openStateMc)
         {
            ObjectUtils.disposeViolentMc(_openStateMc);
            _openStateMc = null;
         }
      }
      
      public function get data() : ConsortiaActivityInfo
      {
         return _data;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get consortiaNewBossModel() : ConsortiaNewBossModel
      {
         return ConsortiaNewBossManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_operateText);
         _operateText = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeViolentMc(_infoTipMc);
         _infoTipMc = null;
         ObjectUtils.disposeObject(_joinBtn);
         _joinBtn = null;
         ObjectUtils.disposeObject(_activityNameImage);
         _activityNameImage = null;
         ObjectUtils.disposeViolentMc(_openStateMc);
         _openStateMc = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         super.dispose();
      }
   }
}

