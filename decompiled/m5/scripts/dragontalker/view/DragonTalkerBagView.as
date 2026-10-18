package dragontalker.view
{
   import bag.view.ItemSellView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dragontalker.DragonTalkerSellHelp;
   import dragontalker.cell.DragonTalkerTalismanBagCell;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import utils.LogicUtils;
   import yishi.manager.CursorManagerII;
   import yishi.manager.NotificationManager;
   import yishi.utils.MsgMan;
   
   public class DragonTalkerBagView extends Component
   {
      
      private static const ROW_NUM:int = 13;
      
      private static const COL_NUM:int = 7;
      
      private var _back:ScaleFrameImage;
      
      private var _talismanText:FilterFrameText;
      
      private var _propBtn:SelectedIconButton;
      
      private var _expBtn:SelectedIconButton;
      
      private var _sellButton:TextButton;
      
      private var _propGroup:SelectedButtonGroup;
      
      private var _typeHbox:HBox;
      
      private var _typeBtn1:SelectedButton;
      
      private var _typeBtn2:SelectedButton;
      
      private var _typeBtn3:SelectedButton;
      
      private var _typeBtn4:SelectedButton;
      
      private var _typeBtn5:SelectedButton;
      
      private var _typeBtn6:SelectedButton;
      
      private var _typeGroup:SelectedButtonGroup;
      
      private var _bagPanel:ScrollPanel;
      
      private var _bagList:SimpleTileList;
      
      private var _talismanList:Vector.<DragonTalkerTalismanBagCell>;
      
      private var _viewType:int;
      
      private var bagSontype:int;
      
      private var _sellView:ItemSellView;
      
      public function DragonTalkerBagView()
      {
         super();
         initView();
         initTalismanBagView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.back");
         _talismanText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.talismanText");
         _propBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.propBtn");
         _expBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.expBtn");
         _sellButton = ComponentFactory.Instance.creatComponentByStylename("dragontalker.sellButton");
         _sellButton.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.sell");
         _typeHbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.typeHbox");
         _typeBtn1 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.typeBtn1");
         _typeBtn2 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.typeBtn2");
         _typeBtn3 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.typeBtn3");
         _typeBtn4 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.typeBtn4");
         _typeBtn5 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.typeBtn5");
         _typeBtn6 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.typeBtn6");
         _bagList = ComponentFactory.Instance.creatCustomObject("DragonTalkerBagView.bagList",[7]);
         _bagPanel = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBagView.bagPanel");
         addChild(_back);
         _back.mouseEnabled = _back.mouseChildren = false;
         addChild(_talismanText);
         addChild(_propBtn);
         addChild(_expBtn);
         addChild(_sellButton);
         addChild(_typeHbox);
         addChild(_bagPanel);
         _bagPanel.setView(_bagList);
         _typeHbox.addChild(_typeBtn1);
         _typeHbox.addChild(_typeBtn2);
         _typeHbox.addChild(_typeBtn3);
         _typeHbox.addChild(_typeBtn4);
         _typeHbox.addChild(_typeBtn5);
         _typeHbox.addChild(_typeBtn6);
         _propGroup = new SelectedButtonGroup();
         _propGroup.addSelectItem(_propBtn);
         _propGroup.addSelectItem(_expBtn);
         _propGroup.selectIndex = 0;
         _typeGroup = new SelectedButtonGroup();
         _typeGroup.addSelectItem(_typeBtn1);
         _typeGroup.addSelectItem(_typeBtn2);
         _typeGroup.addSelectItem(_typeBtn3);
         _typeGroup.addSelectItem(_typeBtn4);
         _typeGroup.addSelectItem(_typeBtn5);
         _typeGroup.addSelectItem(_typeBtn6);
         _typeGroup.selectIndex = 0;
      }
      
      private function initTalismanBagView() : void
      {
         var _loc2_:* = 0;
         var _loc1_:DragonTalkerTalismanBagCell = null;
         _talismanList = new Vector.<DragonTalkerTalismanBagCell>();
         _bagList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 13 * 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerBagView.bagCell");
            _bagList.addChild(_loc1_);
            _talismanList.push(_loc1_);
            _loc2_++;
         }
         _bagList.commitChanges();
         _bagPanel.invalidateViewport();
      }
      
      private function __openSellViewHandler(param1:*) : void
      {
         if(!_sellView)
         {
            _sellView = ComponentFactory.Instance.creatComponentByStylename("dragontalker.ItemSellView",[1]);
            _sellView.addEventListener("dispose",__disposeHandler1);
            addChild(_sellView);
         }
         _sellView.addSellGoods(param1.info);
      }
      
      private function addEvent() : void
      {
         if(_sellButton)
         {
            _sellButton.addEventListener("click",__sellHandler);
         }
         if(_propGroup)
         {
            _propGroup.addEventListener("change",__propTabChangeHandler);
         }
         if(_typeGroup)
         {
            _typeGroup.addEventListener("change",__typeTabChangeHandler);
         }
         MsgMan.addObserver("TALISMAN_REMOVE_EQUIP",this,__removeEquipHandler);
         MsgMan.addObserver("DRAGON_TALKER_TALISMAN_UPDATE",this,__updateDragonTalkerEquipHandler);
         MsgMan.addObserver("HIDE_DIC_CHANGE",this,__updateDragonTalkerEquipHandler);
         if(_sellView)
         {
            _sellView.addEventListener("dispose",__disposeHandler1);
         }
         DragonTalkerSellHelp.Ins.addEventListener("SELL_GOODS",__openSellViewHandler);
      }
      
      private function removeEvent() : void
      {
         if(_sellButton)
         {
            _sellButton.removeEventListener("click",__sellHandler);
         }
         if(_propGroup)
         {
            _propGroup.removeEventListener("change",__propTabChangeHandler);
         }
         if(_typeGroup)
         {
            _typeGroup.removeEventListener("change",__typeTabChangeHandler);
         }
         MsgMan.removeObserver("TALISMAN_REMOVE_EQUIP",this,__removeEquipHandler);
         MsgMan.removeObserver("DRAGON_TALKER_TALISMAN_UPDATE",this,__updateDragonTalkerEquipHandler);
         MsgMan.removeObserver("HIDE_DIC_CHANGE",this,__updateDragonTalkerEquipHandler);
         if(_sellView)
         {
            _sellView.removeEventListener("dispose",__disposeHandler1);
         }
         DragonTalkerSellHelp.Ins.removeEventListener("SELL_GOODS",__openSellViewHandler);
      }
      
      private function __disposeHandler1(param1:Event) : void
      {
         if(_sellView)
         {
            _sellView.removeEventListener("dispose",__disposeHandler1);
         }
         _sellView = null;
      }
      
      private function __sellHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         DragonTalkerSellHelp.Ins.onSellButtonClickHandler(this);
      }
      
      private function __updateDragonTalkerEquipHandler(param1:String, param2:Object) : void
      {
         refreshBagDataView();
      }
      
      private function __removeEquipHandler(param1:String, param2:Object) : void
      {
         var _loc3_:DragonTalkerTalismanInfo = param2 as DragonTalkerTalismanInfo;
         _propGroup.selectIndex = 0;
         _typeGroup.selectIndex = _loc3_.goodsTempInfo.SonType - 401;
      }
      
      private function __propTabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         refreshView();
         NotificationManager.instance.sendNotification("FILTER_GOODS");
      }
      
      private function __typeTabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_typeGroup.getSelectedItem())
         {
            case _typeBtn1:
            case _typeBtn2:
            case _typeBtn3:
            case _typeBtn4:
            case _typeBtn5:
            case _typeBtn6:
         }
         refreshView();
         MsgMan.notifyObserver("MUTI_TALISMAN_STATE_CHANGE");
         NotificationManager.instance.sendNotification("FILTER_GOODS");
      }
      
      private function refreshView() : void
      {
         switch(viewType - 1)
         {
            case 0:
               bagSontype = _propGroup.selectIndex == 0 ? _typeGroup.selectIndex + 401 : 407;
               _talismanText.text = "";
               _typeHbox.visible = _propGroup.selectIndex == 0 ? true : false;
               _propBtn.visible = _expBtn.visible = true;
               _bagPanel.height = _propGroup.selectIndex == 0 ? 343 : 373;
               _bagPanel.y = _propGroup.selectIndex == 0 ? 80 : 50;
               _propBtn.y = _expBtn.y = 17;
               _back.setFrame(1);
               break;
            case 1:
               bagSontype = _propGroup.selectIndex == 0 ? _typeGroup.selectIndex + 401 : 407;
               _talismanText.text = "";
               _typeHbox.visible = _propGroup.selectIndex == 0 ? true : false;
               _propBtn.visible = _expBtn.visible = true;
               _bagPanel.height = _propGroup.selectIndex == 0 ? 308 : 336;
               _bagPanel.y = _propGroup.selectIndex == 0 ? 80 : 50;
               _propBtn.y = _expBtn.y = 10;
               _back.setFrame(2);
               break;
            case 2:
               bagSontype = _typeGroup.selectIndex + 401;
               _talismanText.text = LanguageMgr.GetTranslation("DragonTalkerBagView.talismanText.text");
               _typeHbox.visible = true;
               _propBtn.visible = _expBtn.visible = false;
               _bagPanel.height = 308;
               _bagPanel.y = 80;
               _propBtn.y = _expBtn.y = 10;
               _back.setFrame(2);
         }
         _bagPanel.invalidateViewport();
         refreshBagDataView();
      }
      
      private function refreshBagDataView() : void
      {
         var _loc3_:* = 0;
         var _loc2_:DragonTalkerTalismanBagCell = null;
         var _loc1_:Array = model.getTalismanListBySontype(bagSontype);
         _loc3_ = 0;
         while(_loc3_ < 13 * 7)
         {
            _loc2_ = _talismanList[_loc3_];
            _loc2_.data = _loc3_ < _loc1_.length ? _loc1_[_loc3_] : null;
            _loc3_++;
         }
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function set viewType(param1:int) : void
      {
         _viewType = param1;
         model.bagViewType = param1;
         refreshView();
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         DragonTalkerSellHelp.Ins.stopSelling();
         CursorManagerII.instance.resetCursor();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_talismanText);
         _talismanText = null;
         ObjectUtils.disposeObject(_propBtn);
         _propBtn = null;
         ObjectUtils.disposeObject(_expBtn);
         _expBtn = null;
         ObjectUtils.disposeObject(_sellButton);
         _sellButton = null;
         ObjectUtils.disposeObject(_bagPanel);
         _bagPanel = null;
         ObjectUtils.disposeObject(_bagList);
         _bagList = null;
         ObjectUtils.disposeObject(_typeHbox);
         _typeHbox = null;
         ObjectUtils.disposeObject(_typeBtn1);
         _typeBtn1 = null;
         ObjectUtils.disposeObject(_typeBtn2);
         _typeBtn2 = null;
         ObjectUtils.disposeObject(_typeBtn3);
         _typeBtn3 = null;
         ObjectUtils.disposeObject(_typeBtn4);
         _typeBtn4 = null;
         ObjectUtils.disposeObject(_typeBtn5);
         _typeBtn5 = null;
         ObjectUtils.disposeObject(_typeBtn6);
         _typeBtn6 = null;
         ObjectUtils.disposeObject(_sellView);
         _sellView = null;
         _propGroup.dispose();
         _propGroup = null;
         _typeGroup.dispose();
         _typeGroup = null;
         LogicUtils.disposeDisplayCollection(_talismanList);
         _talismanList = null;
         super.dispose();
      }
   }
}

