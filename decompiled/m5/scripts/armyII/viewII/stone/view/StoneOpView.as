package armyII.viewII.stone.view
{
   import armyII.viewII.stone.item.StoneBagEquipView;
   import armyII.viewII.stone.item.StoneGroupItem;
   import armyII.viewII.stone.ui.StoneOpViewUI;
   import bag.events.BagEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.armyII.RuneInfo;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   
   public class StoneOpView extends StoneOpViewUI
   {
      
      private var _kbg:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("army.stoneop.mBack1");
      
      private var _kbg2:ScaleBitmapImage;
      
      private var _bag:StoneBagEquipView;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _bagnumMax:int;
      
      private var _bagDefaultNum:int;
      
      private var _openBagNum:int;
      
      private var _data:RuneInfo;
      
      private var _groupItem:StoneGroupItem;
      
      public var needPlayOpenEffect:Boolean = false;
      
      public function StoneOpView()
      {
         addChild(_kbg);
         _kbg2 = ComponentFactory.Instance.creatComponentByStylename("army.stoneop.mBack2");
         addChild(_kbg2);
         super();
         init();
         initEvent();
         _btnGroup.selectIndex = 0;
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         _loc2_ = 6;
         var _loc5_:Array = null;
         _groupItem = new StoneGroupItem();
         addChild(_groupItem);
         _groupItem.y = 97;
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_opBtn0);
         _btnGroup.addSelectItem(_opBtn1);
         _btnGroup.addSelectItem(_opBtn2);
         _btnGroup.addSelectItem(_opBtn3);
         _btnGroup.addSelectItem(_opBtn4);
         _btnGroup.addSelectItem(_opBtn5);
         _dkhbox.beginChanges();
         _dkhbox.addChild(_opBtn0);
         _dkhbox.addChild(_opBtn1);
         _dkhbox.addChild(_opBtn2);
         _dkhbox.addChild(_opBtn3);
         _dkhbox.addChild(_opBtn4);
         _dkhbox.addChild(_opBtn5);
         _dkhbox.commitChanges();
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan0"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan1"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan2"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan3"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan4"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan5"));
         _combox.listPanel.list.defaultSelectItemByCellValue = _combox.listPanel.vectorListModel.getElementAt(0);
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("runehole_bag");
         if(_loc1_)
         {
            _loc5_ = _loc1_.ConfigValue.split(",");
            _bagDefaultNum = int(_loc5_[0]);
            _bagnumMax = int(_loc5_[1]);
         }
         var _loc4_:int = Math.ceil(_bagnumMax / 6);
         _bag = new StoneBagEquipView(6,_loc4_,1);
         _opbagspanel.setView(_bag);
         _openBagNum = PlayerManager.instance.currentPlayerModel.playerInfo.runeCount;
         var _loc3_:int = _openBagNum + _bagDefaultNum;
         _bag.openNum = _loc3_;
      }
      
      public function set data(param1:RuneInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _groupItem.updateView(_data.runeHole,_data.templateInfo.RuneType);
            if(needPlayOpenEffect)
            {
               _groupItem.playOpenEffect();
            }
            _fwIcon.icon = IconFactory.getTecIconByIcon(_data.templateInfo.Icon);
            _fwnameTxt.text = _data.templateInfo.TemplateName + LanguageMgr.GetTranslation("public.level2",_data.grade);
         }
         _fwIcon.tipData = _data;
      }
      
      private function initEvent() : void
      {
         _dkBtn.addEventListener("click",dkHandler);
         _btnGroup.addEventListener("change",groupHandler);
         _combox.listPanel.list.addEventListener("listItemClick",__onQuickSellItemClick);
         GoodsManager.instance.addEventListener("UPDATE_BAG",updateBagHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",deleteBagHandler);
         NotificationManager.instance.addEventListener("RUNE_UPGRADE",__runeRefreshHandler);
         NotificationManager.instance.addEventListener("playRuneEquipEff",playEquipEffhandler);
         NotificationManager.instance.addEventListener("stopRuneEquipEff",stopEquipEffhandler);
      }
      
      private function removeEvent() : void
      {
         _dkBtn.removeEventListener("click",dkHandler);
         _btnGroup.removeEventListener("change",groupHandler);
         _combox.listPanel.list.removeEventListener("listItemClick",__onQuickSellItemClick);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",updateBagHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",deleteBagHandler);
         NotificationManager.instance.removeEventListener("RUNE_UPGRADE",__runeRefreshHandler);
         NotificationManager.instance.removeEventListener("playRuneEquipEff",playEquipEffhandler);
         NotificationManager.instance.removeEventListener("stopRuneEquipEff",stopEquipEffhandler);
      }
      
      private function playEquipEffhandler(param1:NotificationEvent) : void
      {
         _groupItem.playEff(int(param1.data));
      }
      
      private function stopEquipEffhandler(param1:NotificationEvent) : void
      {
         _groupItem.stopEff();
      }
      
      private function __runeRefreshHandler(param1:NotificationEvent) : void
      {
         var _loc2_:RuneInfo = param1.data as RuneInfo;
         if(!_data)
         {
            return;
         }
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.templateInfo.RuneType != _data.templateInfo.RuneType)
         {
            return;
         }
         data = _loc2_;
      }
      
      private function updateBagHandler(param1:BagEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType == 40)
         {
            _bag.updateItem(_loc3_,"add");
         }
         else if(_loc3_.bagType == 41)
         {
            _loc2_ = _loc3_.pos - (_data.templateInfo.RuneType - 1) * 10;
            _groupItem.updateItemCell(_loc2_,_loc3_);
         }
      }
      
      private function deleteBagHandler(param1:BagEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType == 40)
         {
            _bag.updateItem(_loc3_,"del");
         }
         else if(_loc3_.bagType == 41)
         {
            _loc2_ = _loc3_.pos - (_data.templateInfo.RuneType - 1) * 10;
            _groupItem.updateItemCell(_loc2_,null);
         }
      }
      
      private function __onQuickSellItemClick(param1:ListItemEvent) : void
      {
         _bag.beginCommit();
         var _loc2_:int = _combox ? _combox.currentSelectedIndex + 1 : 0;
         _bag.profie = _loc2_ - 1;
         _bag.endCommit();
      }
      
      private function groupHandler(param1:Event) : void
      {
         _bag.beginCommit();
         _bag.xing = _btnGroup.selectIndex;
         _bag.endCommit();
      }
      
      private function dkHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.FUSHI_DIAOKE;
         FrameControllerManager.instance.openControllerByInfo("army",null,_data);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_kbg);
         _kbg = null;
         ObjectUtils.disposeObject(_kbg2);
         _kbg2 = null;
         ObjectUtils.disposeObject(_bag);
         _bag = null;
         ObjectUtils.disposeObject(_groupItem);
         _groupItem = null;
         super.dispose();
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         _data = null;
      }
   }
}

