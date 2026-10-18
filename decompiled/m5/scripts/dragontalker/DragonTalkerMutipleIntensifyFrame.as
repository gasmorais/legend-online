package dragontalker
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.dragontalker.MaterialListMsg;
   import dragontalker.item.DragonTalkerMutipleIntensifyItem;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import utils.LogicUtils;
   import yishi.manager.SharedManagerHelper;
   import yishi.utils.MsgMan;
   
   public class DragonTalkerMutipleIntensifyFrame extends Frame
   {
      
      private var _bg1:ScaleBitmapImage;
      
      private var _titleBg:ScaleLeftRightImage;
      
      private var _expImage:Bitmap;
      
      private var _nameTitleText:FilterFrameText;
      
      private var _numberTitleText:FilterFrameText;
      
      private var _deleteTitleText:FilterFrameText;
      
      private var _totalExpText:FilterFrameText;
      
      private var _panel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _intensifyBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _totalExp:int;
      
      private var _itemList:Vector.<DragonTalkerMutipleIntensifyItem>;
      
      public function DragonTalkerMutipleIntensifyFrame()
      {
         super();
         initView();
         addEvent();
         model.isOpenMutiIntensify = true;
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("DragonTalkerMutipleIntensifyFrame.title.text");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.bg1");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.titleBg");
         _expImage = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerMutipleIntensifyFrame.expImage");
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerMutipleIntensifyFrame.intensifyBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.cancelBtn");
         _nameTitleText = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.name");
         _numberTitleText = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.number");
         _deleteTitleText = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.delete");
         _totalExpText = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.totalPrice");
         _panel = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.panel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("army.itemSellView.vBox");
         addToContent(_bg1);
         addToContent(_titleBg);
         addToContent(_expImage);
         addToContent(_intensifyBtn);
         addToContent(_cancelBtn);
         addToContent(_nameTitleText);
         addToContent(_numberTitleText);
         addToContent(_deleteTitleText);
         addToContent(_totalExpText);
         _totalExpText.x = 123;
         _totalExpText.y = 368;
         addToContent(_panel);
         _panel.setView(_vBox);
         _nameTitleText.text = LanguageMgr.GetTranslation("DragonTalkerMutipleIntensifyFrame.nameTitleText.text");
         _numberTitleText.text = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.numberText");
         _deleteTitleText.text = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.deleteText");
         _itemList = new Vector.<DragonTalkerMutipleIntensifyItem>();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _intensifyBtn.addEventListener("click",__mutiIntensifyBtnHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         MsgMan.addObserver("MUTI_INTENSIFY_TALISMAN_DELETE",this,__talismanDeleteHandler);
         MsgMan.addObserver("MUTI_INTENSIFY_COUNT_CHANGE",this,__countChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_intensifyBtn)
         {
            _intensifyBtn.removeEventListener("click",__mutiIntensifyBtnHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelHandler);
         }
         MsgMan.removeObserver("MUTI_INTENSIFY_TALISMAN_DELETE",this,__talismanDeleteHandler);
         MsgMan.removeObserver("MUTI_INTENSIFY_COUNT_CHANGE",this,__countChangeHandler);
      }
      
      private function __countChangeHandler(param1:String, param2:Object) : void
      {
         _totalExp = 0;
         for each(var _loc3_:DragonTalkerMutipleIntensifyItem in _itemList)
         {
            _totalExp += _loc3_.count * _loc3_.info.goodsTempInfo.Property1;
         }
         _totalExpText.text = _totalExp + "";
      }
      
      private function __talismanDeleteHandler(param1:String, param2:Object) : void
      {
         var _loc4_:DragonTalkerTalismanInfo = param2 as DragonTalkerTalismanInfo;
         model.setMutipleIntensifyList(_loc4_,false);
         for each(var _loc3_:DragonTalkerMutipleIntensifyItem in _itemList)
         {
            if(_loc3_.info == _loc4_)
            {
               _totalExp -= _loc3_.count * _loc4_.goodsTempInfo.Property1;
               _itemList.splice(_itemList.indexOf(_loc3_),1);
               break;
            }
         }
         _totalExpText.text = _totalExp + "";
         _panel.invalidateViewport();
         MsgMan.notifyObserver("MUTI_TALISMAN_STATE_CHANGE");
      }
      
      public function addIntensifyGoods(param1:DragonTalkerTalismanInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc2_:DragonTalkerMutipleIntensifyItem in _itemList)
         {
            if(_loc2_.info == param1)
            {
               return;
            }
         }
         var _loc3_:DragonTalkerMutipleIntensifyItem = new DragonTalkerMutipleIntensifyItem();
         _loc3_.info = param1;
         _itemList.push(_loc3_);
         _vBox.addChild(_loc3_);
         _panel.invalidateViewport();
         _totalExp += param1.count * param1.goodsTempInfo.Property1;
         _totalExpText.text = _totalExp + "";
         model.setMutipleIntensifyList(param1,true);
         MsgMan.notifyObserver("MUTI_TALISMAN_STATE_CHANGE");
      }
      
      private function __mutiIntensifyBtnHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         if(!model.hasMutiIntensifyList())
         {
            return;
         }
         if(model.firstNoExpTalismanInfo)
         {
            _loc3_ = DragonTalkerViewHelper.GetTextColorByProfile(model.firstNoExpTalismanInfo.goodsTempInfo.Profile,model.firstNoExpTalismanInfo.goodsTempInfo.TemplateName);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("DragonTalkerIntensifyView.strength.talismanAlert2",_loc3_);
            SharedManagerHelper.ins.needAlert("DragonTalkerIntensifyView.strength.Alert2",confirmResultHandler,_loc2_,_loc4_);
         }
         else
         {
            confirmResultHandler();
         }
      }
      
      private function confirmResultHandler() : void
      {
         var _loc2_:MaterialListMsg = null;
         var _loc3_:Array = [];
         for each(var _loc1_:DragonTalkerMutipleIntensifyItem in _itemList)
         {
            _loc2_ = new MaterialListMsg();
            _loc2_.materialId = _loc1_.info.id;
            _loc2_.count = _loc1_.count;
            _loc3_.push(_loc2_);
         }
         DragonTalkerManager.instance.sendMutiIntensifyTalisman(model.intensifyTalismanInfo.id,_loc3_);
         dispose();
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.isOpenMutiIntensify = false;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_expImage);
         _expImage = null;
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_nameTitleText);
         _nameTitleText = null;
         ObjectUtils.disposeObject(_numberTitleText);
         _numberTitleText = null;
         ObjectUtils.disposeObject(_deleteTitleText);
         _deleteTitleText = null;
         ObjectUtils.disposeObject(_totalExpText);
         _totalExpText = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         model.setMutipleIntensifyList(null,false,true);
         MsgMan.notifyObserver("MUTI_TALISMAN_STATE_CHANGE");
         super.dispose();
      }
   }
}

