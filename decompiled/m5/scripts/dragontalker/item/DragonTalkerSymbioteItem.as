package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.FrameControllerManager;
   
   public class DragonTalkerSymbioteItem extends Component
   {
      
      private var itemBack:ScaleFrameImage;
      
      private var gradeText:FilterFrameText;
      
      private var percentBack:Bitmap;
      
      private var percentText:FilterFrameText;
      
      private var upgradeBtn:BaseButton;
      
      private var _index:int;
      
      private var curUpgradeTemp:UpgradeTemplateInfo;
      
      private var nextUpgradeTemp:UpgradeTemplateInfo;
      
      private var data:DragonTalkerSymbioteInfo;
      
      public function DragonTalkerSymbioteItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         itemBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSymbioteItem.itemBack");
         gradeText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSymbioteItem.gradeText");
         percentBack = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSymbioteItem.percentBack");
         percentText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSymbioteItem.percentText");
         upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSymbioteItem.upgradeBtn");
         addChild(itemBack);
         addChild(gradeText);
         addChild(percentBack);
         addChild(percentText);
         addChild(upgradeBtn);
         percentBack.visible = false;
      }
      
      private function addEvent() : void
      {
         upgradeBtn.addEventListener("click",__upgradeBtnClickHandler);
         addEventListener("mouseOver",__onOverHandler);
         addEventListener("mouseOut",__onOutHandler);
      }
      
      private function removeEvent() : void
      {
         if(upgradeBtn)
         {
            upgradeBtn.removeEventListener("click",__upgradeBtnClickHandler);
         }
         removeEventListener("mouseOver",__onOverHandler);
         removeEventListener("mouseOut",__onOutHandler);
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         if(!curUpgradeTemp)
         {
            return;
         }
         percentText.text = LanguageMgr.GetTranslation("DragonTalkerSymbioteItem.percentText.text",curUpgradeTemp.ActiveObject);
         percentBack.visible = true;
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         percentText.text = "";
         percentBack.visible = false;
      }
      
      private function __upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("dragontalker","SYMBIOTE_FRAME",index);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         itemBack.setFrame(index + 1);
         upgradeBtn.x = itemBack.getFrameImage(index).width - upgradeBtn.width;
         upgradeBtn.y = itemBack.getFrameImage(index).height - upgradeBtn.height;
         percentBack.x = (itemBack.getFrameImage(index).width - percentBack.width) / 2;
         percentBack.y = (itemBack.getFrameImage(index).height - percentBack.height) / 2;
         percentText.y = percentBack.y;
         data = model.getSymbioteInfoByIndex(index);
         if(data)
         {
            gradeText.text = LanguageMgr.GetTranslation("public.level2",data.grade);
            curUpgradeTemp = model.symbioteUpgradeArr[data.grade - 1];
            nextUpgradeTemp = model.symbioteUpgradeArr[data.grade];
            upgradeBtn.visible = nextUpgradeTemp == null ? false : true;
            this.tipData = index + 401;
         }
         else
         {
            gradeText.text = "";
            percentText.text = "";
            upgradeBtn.visible = false;
            this.tipData = null;
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(itemBack);
         itemBack = null;
         ObjectUtils.disposeObject(gradeText);
         gradeText = null;
         ObjectUtils.disposeObject(upgradeBtn);
         upgradeBtn = null;
         ObjectUtils.disposeObject(percentBack);
         percentBack = null;
         ObjectUtils.disposeObject(percentText);
         percentText = null;
         super.dispose();
      }
   }
}

