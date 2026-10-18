package theseus.war.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import theseus.war.item.TheseusWarEquipHItem;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class TheseusWarEquipPageView extends Sprite
   {
      
      public var _warEquipBg:Bitmap;
      
      public var _warHelpBtn:BaseButton;
      
      public var _warIntensifyBtn:IconButton;
      
      public var _warEquipTitle:FilterFrameText;
      
      private var _helpTxt:FilterFrameText;
      
      public var _warEquipVbox:VBox;
      
      private var _itemList:Vector.<TheseusWarEquipHItem> = new Vector.<TheseusWarEquipHItem>();
      
      public function TheseusWarEquipPageView()
      {
         super();
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusWarEquipHItem = null;
         var _loc2_:int = 0;
         _warEquipBg = ComponentFactory.Instance.creatBitmap("asset.theseus.warEquipBg");
         _warIntensifyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.warIntensifyBtn");
         _warHelpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.warHelpBtn");
         _warEquipTitle = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.warEquipTitle");
         _warEquipVbox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warEquipVbox1");
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warHelpTxt");
         _helpTxt.text = LanguageMgr.GetTranslation("theseus.war.htlpTxt");
         addChild(_warEquipBg);
         addChild(_warHelpBtn);
         addChild(_warIntensifyBtn);
         addChild(_warEquipTitle);
         addChild(_warEquipVbox);
         addChild(_helpTxt);
         _warEquipVbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new TheseusWarEquipHItem(_loc2_ + 1);
            _itemList[_loc2_] = _loc1_;
            _warEquipVbox.addChild(_loc1_);
            _loc2_++;
         }
         _warEquipVbox.commitChanges();
         _warEquipTitle.text = LanguageMgr.GetTranslation("theseus.war.equipTitle");
      }
      
      public function updateView() : void
      {
         var _loc2_:Array = TheseussoulManager.Instance.warsoulModel.getEquipBodyList();
         for each(var _loc1_:TheseusWarEquipHItem in _itemList)
         {
            _loc1_.refreshView(_loc2_);
         }
      }
      
      private function warListInfoHandler(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      private function initEvent() : void
      {
         _warIntensifyBtn.addEventListener("click",doIntensifyHandler);
         _warHelpBtn.addEventListener("click",helpHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",warListInfoHandler);
      }
      
      private function removeEvent() : void
      {
         _warIntensifyBtn.removeEventListener("click",doIntensifyHandler);
         _warHelpBtn.removeEventListener("click",helpHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",warListInfoHandler);
      }
      
      private function doIntensifyHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.theseussoulController.backTheseFrame = "theseussoul";
         FrameControllerManager.instance.openControllerByInfo("theseussoul",5);
      }
      
      private function helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("theseuswar.fight.helpFrame");
         _loc2_.show();
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseusWarEquipHItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_warEquipBg);
         _warEquipBg = null;
         ObjectUtils.disposeObject(_warHelpBtn);
         _warHelpBtn = null;
         ObjectUtils.disposeObject(_warIntensifyBtn);
         _warIntensifyBtn = null;
         ObjectUtils.disposeObject(_warEquipTitle);
         _warEquipTitle = null;
         ObjectUtils.disposeObject(_warEquipVbox);
         _warEquipVbox = null;
         ObjectUtils.disposeObject(_helpTxt);
         _helpTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

