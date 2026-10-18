package armyII.viewII.stone.view
{
   import armyII.viewII.stone.item.StoneBagView;
   import armyII.viewII.stone.ui.StoneBagOpUI;
   import bag.events.BagEvent;
   import bag.helper.BagHelper;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import mvc.module.armyII.StoneLotterInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class StoneBagOPView extends StoneBagOpUI
   {
      
      private var _kbg:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("army.stonebag.Back1");
      
      private var _bag:StoneBagView;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _stoneinfo:StoneLotterInfo;
      
      private var _bagnumMax:int;
      
      private var _bagDefaultNum:int;
      
      private var _openBagNum:int;
      
      private var _bState:int = -1;
      
      private var _buyOnceNum:int;
      
      private var _buyOncePrice:int;
      
      private const OP_STATE_0:int = 0;
      
      private const OP_STATE_1:int = 1;
      
      private const OP_STATE_2:int = 2;
      
      private const Chip_ID:int = 10000000;
      
      private var _helpBtn:BaseButton;
      
      public function StoneBagOPView()
      {
         addChild(_kbg);
         super();
         init();
         initEvent();
         _btnGroup.selectIndex = 0;
      }
      
      private function init() : void
      {
         var _loc6_:Array = null;
         var _loc3_:Array = null;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("army.stone.bag.HelpBtn");
         addChild(_helpBtn);
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = 10000000;
         _bagsjicon.tipData = _loc5_.templateInfo.Description;
         _stoneinfo = ArmyManager.instance.thane.runeCate.stoneLotterInfo;
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_opBtn0);
         _btnGroup.addSelectItem(_opBtn1);
         _btnGroup.addSelectItem(_opBtn2);
         _btnGroup.addSelectItem(_opBtn3);
         _btnGroup.addSelectItem(_opBtn4);
         _btnGroup.addSelectItem(_opBtn5);
         _bagbbox.beginChanges();
         _bagbbox.addChild(_opBtn0);
         _bagbbox.addChild(_opBtn1);
         _bagbbox.addChild(_opBtn2);
         _bagbbox.addChild(_opBtn3);
         _bagbbox.addChild(_opBtn4);
         _bagbbox.addChild(_opBtn5);
         _bagbbox.commitChanges();
         _openLockBtn.tipData = LanguageMgr.GetTranslation("stonebagOp.lockTip");
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("runehole_bag");
         if(_loc1_)
         {
            _loc6_ = _loc1_.ConfigValue.split(",");
            _bagDefaultNum = int(_loc6_[0]);
            _bagnumMax = int(_loc6_[1]);
         }
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("runehole_bag_buy");
         if(_loc2_)
         {
            _loc3_ = _loc2_.ConfigValue.split(",");
            _buyOnceNum = int(_loc3_[0]);
            _buyOncePrice = int(_loc3_[1]);
         }
         var _loc4_:int = Math.ceil(_bagnumMax / 60);
         _pagbar.initBtnEvent();
         _pagbar.setMaxPage(_loc4_);
         _bag = new StoneBagView(12,5,_loc4_);
         addChild(_bag);
         _bag.x = 36;
         _bag.y = 77;
         refreshChipbagNums();
         btnState = 0;
         refreshBagNums();
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan0"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan1"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan2"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan3"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan4"));
         _combox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("army.stone.saixuan5"));
         _combox.listPanel.list.defaultSelectItemByCellValue = _combox.listPanel.vectorListModel.getElementAt(0);
      }
      
      private function set btnState(param1:int) : void
      {
         if(_bState == param1)
         {
            return;
         }
         _bState = param1;
         FrameControllerManager.instance.armyController.model.stoneBtnState = _bState;
         switch(_bState)
         {
            case 0:
               _fjbtn1.visible = false;
               _bfjbtn2.visible = true;
               (_bfjbtn2.icon as ScaleFrameImage).setFrame(1);
               _bfjbtn2.x = 22;
               break;
            case 1:
               _fjbtn1.visible = true;
               _bfjbtn2.visible = true;
               (_fjbtn1.icon as ScaleFrameImage).setFrame(2);
               (_bfjbtn2.icon as ScaleFrameImage).setFrame(2);
               _fjbtn1.x = 22;
               _bfjbtn2.x = 150;
               break;
            case 2:
               _fjbtn1.visible = true;
               _bfjbtn2.visible = true;
               (_fjbtn1.icon as ScaleFrameImage).setFrame(1);
               (_bfjbtn2.icon as ScaleFrameImage).setFrame(3);
               _fjbtn1.x = 22;
               _bfjbtn2.x = 150;
         }
      }
      
      private function refreshBagNums() : void
      {
         _openBagNum = playerInfo.runeCount;
         var _loc1_:int = _openBagNum + _bagDefaultNum;
         _bag.openNum = _loc1_;
         _bnum.text = LanguageMgr.GetTranslation("army.stone.bagMax",_loc1_ + "/" + _bagnumMax);
         _addboxBtn.enable = _loc1_ < _bagnumMax;
      }
      
      private function initEvent() : void
      {
         _fjbtn1.addEventListener("click",clickHandler1);
         _bfjbtn2.addEventListener("click",clickHandler2);
         _openLockBtn.addEventListener("click",lockGoodsHandler);
         _addboxBtn.addEventListener("click",addboxHandler);
         _btnGroup.addEventListener("change",groupHandler);
         _combox.listPanel.list.addEventListener("listItemClick",__onQuickSellItemClick);
         _pagbar.addEventListener("change",pageChangeHandler);
         NotificationManager.instance.addEventListener("StoneBagCell.Event",selectHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",updateBagHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",deleteBagHandler);
         playerInfo.addEventListener("RUNE_COUNT_CHANGE",bagCountChangeHandler);
         _helpBtn.addEventListener("click",__helpClick);
      }
      
      private function removeEvent() : void
      {
         _fjbtn1.removeEventListener("click",clickHandler1);
         _bfjbtn2.removeEventListener("click",clickHandler2);
         _openLockBtn.removeEventListener("click",lockGoodsHandler);
         _addboxBtn.removeEventListener("click",addboxHandler);
         _btnGroup.removeEventListener("change",groupHandler);
         _combox.listPanel.list.removeEventListener("listItemClick",__onQuickSellItemClick);
         _pagbar.removeEventListener("change",pageChangeHandler);
         NotificationManager.instance.removeEventListener("StoneBagCell.Event",selectHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",updateBagHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",deleteBagHandler);
         playerInfo.removeEventListener("RUNE_COUNT_CHANGE",bagCountChangeHandler);
         _helpBtn.removeEventListener("click",__helpClick);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("army.stone.Bag.helperFrame");
         _loc2_.show();
      }
      
      private function lockGoodsHandler(param1:MouseEvent) : void
      {
         if(_bState > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("army.stone.noDoLock"));
            return;
         }
         SoundManager.instance.play("022");
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         BagHelper.instance.vpLockBtnClickHandler(this);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function bagCountChangeHandler(param1:Event) : void
      {
         refreshBagNums();
      }
      
      private function addboxHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = _buyOncePrice * _buyOnceNum;
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("stonebagOp.buyBag",_loc4_,_buyOnceNum);
         SimpleAlertHelper.instance.data = [buyBagConfirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,false,true,true,2,"USEBINDPOINT_ALERT",180);
      }
      
      private function buyBagConfirm(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc4_ = param2 ? 0 : 1;
            _loc3_ = _buyOncePrice * _buyOnceNum;
            if(_loc4_ == 1)
            {
               if(playerInfo.point < _loc3_)
               {
                  RechargeAlertMannager.show();
                  return;
               }
            }
            ArmySocketOutManager.sendBuyBox(_loc4_);
         }
      }
      
      private function updateBagHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 40)
         {
            _bag.updateItem(_loc2_,"add");
         }
         refreshChipbagNums();
      }
      
      private function refreshChipbagNums() : void
      {
         var _loc1_:int = int(GoodsManager.instance.getGoodsNumByTempId(10000000));
         _bagspnumtxt.text = "" + _loc1_;
      }
      
      private function deleteBagHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 40)
         {
            _bag.updateItem(_loc2_,"del");
         }
      }
      
      private function selectHandler(param1:Event) : void
      {
         var _loc2_:Array = _bag.getChooseList();
         if(_loc2_.length > 0)
         {
            btnState = 2;
         }
         else
         {
            btnState = 1;
         }
      }
      
      private function clickHandler1(param1:MouseEvent) : void
      {
         if(_bState == 1)
         {
            btnState = 0;
            _bag.cancelQuickChoose(false);
         }
         else if(_bState == 2)
         {
            btnState = 1;
            _bag.cancelQuickChoose(true);
         }
      }
      
      private function clickHandler2(param1:MouseEvent) : void
      {
         var _loc9_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(_bState == 0)
         {
            btnState = 1;
            _bag.cancelQuickChoose(true);
         }
         else if(_bState == 1)
         {
            _bag.quickChoose();
            _loc9_ = _bag.getChooseList();
            if(_loc9_.length > 0)
            {
               btnState = 2;
            }
         }
         else if(_bState == 2)
         {
            _loc9_ = _bag.getChooseList();
            _loc4_ = chooseListToPosString(_loc9_);
            for each(var _loc6_:GoodsInfo in _loc9_)
            {
               if(_loc6_.templateInfo.Profile >= 4)
               {
                  _loc5_ = true;
                  break;
               }
            }
            if(_loc5_)
            {
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc7_ = LanguageMgr.GetTranslation("public.prompt");
               _loc8_ = LanguageMgr.GetTranslation("stoneGetView.resovle.tip");
               SimpleAlertHelper.instance.data = [__alertResponse,_loc4_];
               SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc2_,_loc3_,false,true);
            }
            else if(_loc4_ == "")
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("army.stone.solveNogood"));
            }
            else
            {
               ArmySocketOutManager.sendEquipResoveStone(_loc4_);
            }
         }
      }
      
      private function chooseListToPosString(param1:Array) : String
      {
         var _loc6_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(param1.length);
         var _loc5_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = param1[_loc4_];
            _loc5_.push(_loc6_.pos);
            _loc4_++;
         }
         return _loc5_.join(",");
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean, param3:String) : void
      {
         if(param1)
         {
            ArmySocketOutManager.sendEquipResoveStone(param3);
         }
      }
      
      private function pageChangeHandler(param1:Event) : void
      {
         _bag.gotoPage(_pagbar.getCurPage());
         if(_bState != 0)
         {
            _bag.cancelQuickChoose(true);
            btnState = 1;
         }
         refreshBagNums();
      }
      
      private function __onQuickSellItemClick(param1:ListItemEvent) : void
      {
         _bag.beginCommit();
         var _loc2_:int = _combox ? _combox.currentSelectedIndex + 1 : 0;
         _bag.profie = _loc2_ - 1;
         _bag.endCommit();
         if(_bState != 0)
         {
            _bag.cancelQuickChoose(true);
            btnState = 1;
         }
      }
      
      private function groupHandler(param1:Event) : void
      {
         _pagbar.setCurPage(1);
         _bag.beginCommit();
         _bag.xing = _btnGroup.selectIndex;
         _bag.endCommit();
         if(_bState != 0)
         {
            _bag.cancelQuickChoose(true);
            btnState = 1;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         FrameControllerManager.instance.armyController.model.stoneBtnState = -1;
         ObjectUtils.disposeObject(_kbg);
         _kbg = null;
         ObjectUtils.disposeObject(_bag);
         _bag = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         if(BagHelper.instance.isVpLock)
         {
            BagHelper.instance.vpLockBtnClickHandler(this);
         }
         super.dispose();
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         _stoneinfo = null;
      }
   }
}

