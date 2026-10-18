package marry.income
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.cell.MarryTreeBagCell;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.FashionManager;
   import managers.MarryManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.marry.MarriageGodTreeInfo;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.view.base.Progress;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryTreeFosterFrame extends Frame implements IManualSize
   {
      
      private var _fosterBtn:BaseButton;
      
      private var _allInBtn:BaseButton;
      
      private var _bg:MutipleImage;
      
      private var _inComeAdd:FilterFrameText;
      
      private var _treeLevel:FilterFrameText;
      
      private var _nextIncome:FilterFrameText;
      
      private var _fullStateCanget:FilterFrameText;
      
      private var _consumeGold:FilterFrameText;
      
      private var _chooseItems:FilterFrameText;
      
      private var _trainCountDown:FilterFrameText;
      
      private var _itemList1:Vector.<MarryTreeBagCell>;
      
      private var _itemList2:Vector.<MarryTreeBagCell>;
      
      private var _itemDic:SimpleDictionary;
      
      private var _itemContainer1:SimpleTileList;
      
      private var _itemContainer2:SimpleTileList;
      
      private var _itemContainer3:SimpleTileList;
      
      private var _itemContainer4:SimpleTileList;
      
      private var _panel:ScrollPanel;
      
      private var _addNum:int;
      
      private var _total:int;
      
      private var _curentvalue:int;
      
      private var _count:int;
      
      private var _refreshGold:int;
      
      private var _goldTrainButton:BaseButton;
      
      private var _diamondTrainButton:BaseButton;
      
      private var _countDown:TimeDownView;
      
      private var _progress1:Progress;
      
      private var _progress2:Progress;
      
      private var _goldBox:VBox;
      
      private var _diamondBox:VBox;
      
      private var _expText1:FilterFrameText;
      
      private var _expText2:FilterFrameText;
      
      private var _leftTime1:FilterFrameText;
      
      private var _leftTime2:FilterFrameText;
      
      private var _costGold:FilterFrameText;
      
      private var _costDiamond:FilterFrameText;
      
      private var _goldAddtime:int;
      
      private var _diamondAddTime:int;
      
      private var _goldAddCost:int;
      
      private var _diamondAddCost:int;
      
      private var _godAddExp:int;
      
      private var _diamondAddExp:int;
      
      private var _goldTrainCost:int;
      
      private var _canTrain:Boolean = false;
      
      private var _achieveMaxLevel:Boolean = false;
      
      public function MarryTreeFosterFrame()
      {
         super();
         initview();
         initConfigValue();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,730,360);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initConfigValue() : void
      {
         _goldAddtime = needValue("marriage_tree_gold_max");
         _diamondAddTime = needValue("marriage_tree_point_max");
         _goldAddCost = needValue("marriage_tree_gold");
         _diamondAddCost = needValue("marriage_tree_water_point");
         _godAddExp = needValue("marriage_tree_gold_addgp");
         _diamondAddExp = needValue("marriage_tree_point_addgp");
         _goldTrainCost = needValue("marriage_tree_train_gold");
      }
      
      private function initview() : void
      {
         titleText = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.bg");
         _fosterBtn = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.fosterBtn");
         _allInBtn = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.allInBtn");
         _goldTrainButton = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.goldTrainBtn");
         _diamondTrainButton = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.diamondTrainBtn");
         _inComeAdd = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.inComeTextField");
         _treeLevel = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.treeLevel");
         _nextIncome = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.nextIncome");
         _fullStateCanget = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.fullStateCanget");
         _consumeGold = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.consumeGold");
         _chooseItems = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.chooseItem");
         _trainCountDown = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.trainCountDown");
         _expText1 = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.expText1");
         _expText2 = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.expText2");
         _leftTime1 = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.leftTime1");
         _leftTime2 = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.leftTime2");
         _costGold = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.costGold");
         _costDiamond = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.costDiamond");
         _countDown = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.TimeDown");
         _progress1 = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.progress1");
         _progress2 = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.progress2");
         _fosterBtn.enable = false;
         _inComeAdd.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.fillStateValue");
         _refreshGold = 100000;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("fresh_martree_item");
         if(_loc1_ && parseInt(_loc1_.ConfigValue))
         {
            _refreshGold = parseInt(_loc1_.ConfigValue);
         }
         addToContent(_bg);
         addToContent(_fosterBtn);
         addToContent(_allInBtn);
         addToContent(_inComeAdd);
         addToContent(_treeLevel);
         addToContent(_nextIncome);
         _nextIncome.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.nextIncome");
         addToContent(_fullStateCanget);
         _fullStateCanget.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.fullStateCanget");
         addToContent(_consumeGold);
         addToContent(_chooseItems);
         _chooseItems.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.chooseItems");
         addToContent(_trainCountDown);
         _trainCountDown.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.trainCountDown");
         addToContent(_expText1);
         addToContent(_expText2);
         addToContent(_leftTime1);
         addToContent(_leftTime2);
         addToContent(_costGold);
         addToContent(_costDiamond);
         addToContent(_countDown);
         _countDown.timeCount = 0;
         addToContent(_progress1);
         addToContent(_progress2);
         addToContent(_goldTrainButton);
         addToContent(_diamondTrainButton);
         initGrid();
         setIncomeGoods();
         refreshView();
      }
      
      private function initGrid() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MarryTreeBagCell = null;
         var _loc3_:MarryTreeBagCell = null;
         _itemContainer1 = ComponentFactory.Instance.creatCustomObject("MarryTreeFosterFrame.ItemContainer1",[4]);
         _itemContainer2 = ComponentFactory.Instance.creatCustomObject("MarryTreeFosterFrame.ItemContainer2",[4]);
         _itemContainer3 = ComponentFactory.Instance.creatCustomObject("MarryTreeFosterFrame.ItemContainer3",[4]);
         _itemContainer4 = ComponentFactory.Instance.creatCustomObject("MarryTreeFosterFrame.ItemContainer4",[4]);
         _panel = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.panel");
         addToContent(_itemContainer1);
         addToContent(_panel);
         _panel.setView(_itemContainer2);
         addToContent(_itemContainer3);
         addToContent(_itemContainer4);
         _itemList1 = new Vector.<MarryTreeBagCell>();
         _itemList2 = new Vector.<MarryTreeBagCell>();
         _itemDic = new SimpleDictionary();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MarryTreeFosterFrame.MarryTreeBagCell1");
            _loc1_.data = null;
            _loc1_.pos = _loc2_;
            _itemContainer1.addChild(_loc1_);
            _itemList1.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 20)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("MarryTreeFosterFrame.MarryTreeBagCell2");
            _loc3_.data = null;
            _loc3_.pos = -1;
            _itemContainer2.addChild(_loc3_);
            _itemList2.push(_loc3_);
            _loc2_++;
         }
         initGoods();
      }
      
      private function initGoods() : void
      {
         var _loc3_:int = 0;
         var _loc4_:MarryTreeBagCell = null;
         cleanGoods();
         var _loc1_:Array = [];
         var _loc5_:SimpleDictionary = GoodsManager.instance.getGeneralBagList();
         for each(var _loc6_:GoodsInfo in _loc5_)
         {
            if(filterGoods(_loc6_))
            {
               _loc1_.push(_loc6_);
            }
         }
         var _loc2_:int = Math.ceil(_loc1_.length / 5) * 5;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_itemList2.length <= _loc3_)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject("MarryTreeFosterFrame.MarryTreeBagCell2");
               _loc4_.data = null;
               _loc4_.pos = -1;
               _itemContainer2.addChild(_loc4_);
               _itemList2.push(_loc4_);
            }
            if(_loc1_.length > _loc3_)
            {
               _itemList2[_loc3_].data = _loc1_[_loc3_];
               _itemList2[_loc3_].pos = _loc1_[_loc3_].pos;
               _itemDic.add(_loc1_[_loc3_].pos + "_" + _loc1_[_loc3_].bagType,_itemList2[_loc3_]);
            }
            _loc3_++;
         }
         marryModel.endPos1 = 0;
      }
      
      private function cleanGoods() : void
      {
         if(_itemDic)
         {
            for each(var _loc1_:MarryTreeBagCell in _itemDic)
            {
               _loc1_.data = null;
               _loc1_.pos = -1;
            }
            _itemDic.clear();
         }
      }
      
      private function addInfoToItem(param1:GoodsInfo, param2:Vector.<MarryTreeBagCell>) : void
      {
         var _loc3_:MarryTreeBagCell = null;
         if(param1)
         {
            _loc3_ = findEmptyItem(param2);
            if(_loc3_)
            {
               _loc3_.data = param1;
               _loc3_.pos = param1.pos;
               _itemDic.add(param1.pos + "_" + param1.bagType,_loc3_);
            }
         }
      }
      
      private function findEmptyItem(param1:Vector.<MarryTreeBagCell>) : MarryTreeBagCell
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1[_loc3_].data != null)
            {
               if(param1[_loc3_].data.pos == -1)
               {
                  return param1[_loc3_];
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      private function get nowInfo() : UpgradeTemplateInfo
      {
         var _loc1_:int = int(godTreeInfo.treeGrade);
         return TempleteManager.instance.getTemplateByLevelAndType(_loc1_,121);
      }
      
      private function get nextInfo() : UpgradeTemplateInfo
      {
         var _loc2_:int = int(godTreeInfo.treeGrade);
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc2_ + 1,121);
         while(_loc1_ == null)
         {
            _loc2_ -= 1;
            _achieveMaxLevel = true;
            _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(_loc2_ + 1,121);
            if(_loc2_ < 0)
            {
               _loc1_ = new UpgradeTemplateInfo();
            }
         }
         return _loc1_;
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 10;
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("mar_tree_train_count");
         if(_loc4_ && !StringHelper.isNullOrEmpty(_loc4_.ConfigValue))
         {
            _loc1_ = int(TempleteManager.instance.getConfigInfoByConfigName("mar_tree_train_count").ConfigValue);
         }
         var _loc3_:GoodsInfo = new GoodsInfo();
         _treeLevel.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.treeLevel",godTreeInfo.treeGrade);
         if(!_achieveMaxLevel)
         {
            _progress1.setData(godTreeInfo.treeGp,nextInfo.Data);
         }
         else
         {
            _progress1.setData(1,1,true);
            _nextIncome.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.Income");
         }
         _progress2.setData(godTreeInfo.treeStateValue,1000);
         var _loc2_:int = DateFormatter.parse(godTreeInfo.treeEarningDate,"YYYY-MM-DD hh:mm:ss").time / 1000 + 43200 - playerModel.sysCurTimeBySecond;
         _countDown.timeCount = _loc2_;
         _canTrain = _loc2_ <= 0;
         setEndPos();
         setAddTxt();
         setTextValue();
         setIncomeGoods();
      }
      
      private function setTextValue() : void
      {
         _expText1.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.gainnExp",_godAddExp);
         _expText2.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.gainnExp",_diamondAddExp);
         _leftTime1.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.leftTime",_goldAddtime - godTreeInfo.treeGoldWater + "/" + _goldAddtime);
         _leftTime2.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.leftTime",_diamondAddTime - godTreeInfo.treeDiamondWater + "/" + _diamondAddTime);
         _costGold.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.costGold",_goldAddCost);
         _costDiamond.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.costDiamond",_diamondAddCost);
         _consumeGold.text = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.consumeGold",_goldTrainCost);
      }
      
      private function get godTreeInfo() : MarriageGodTreeInfo
      {
         return MarryManager.instance.model.marriageData.godTreeInfo;
      }
      
      private function setIncomeGoods() : void
      {
         var _loc6_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc9_:Array = null;
         var _loc8_:GoodsInfo = null;
         var _loc7_:BaseItemView = null;
         var _loc3_:Array = null;
         var _loc4_:GoodsInfo = null;
         _itemContainer3.disposeAllChildren();
         _itemContainer4.disposeAllChildren();
         var _loc5_:Array = nowInfo.TemplateName.split("|");
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("MarryTreeFosterFrame.MarryTreeBagCell3");
            _itemContainer3.addChild(_loc2_);
            if(_loc5_[_loc6_] != null)
            {
               _loc9_ = _loc5_[_loc6_].split(",");
               _loc8_ = new GoodsInfo();
               _loc8_.templateId = _loc9_[0];
               _loc8_.count = _loc9_[1];
               _loc2_.data = _loc8_;
               _loc2_.pos = _loc6_;
            }
            _loc6_++;
         }
         var _loc1_:Array = nextInfo.TemplateName.split("|");
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc7_ = ComponentFactory.Instance.creatCustomObject("MarryTreeFosterFrame.MarryTreeBagCell3");
            _itemContainer4.addChild(_loc7_);
            if(_loc1_[_loc6_] != null)
            {
               _loc3_ = _loc1_[_loc6_].split(",");
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = _loc3_[0];
               _loc4_.count = _loc3_[1];
               _loc7_.data = _loc4_;
               _loc7_.pos = _loc6_;
            }
            _loc6_++;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __infoUpdateHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __curentvalueChangeHandler(param1:String, param2:Object) : void
      {
         if(param2 == null)
         {
            return;
         }
         _curentvalue = int(param2);
         refreshView();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _fosterBtn.addEventListener("click",__fosterBtnHandler);
         _allInBtn.addEventListener("click",__allInBtnHandler);
         _goldTrainButton.addEventListener("click",__trainButtonHandler);
         _diamondTrainButton.addEventListener("click",__trainButtonHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         MsgMan.addObserver("MarryEventType.MARRIAGE_DATA",this,__infoUpdateHandler);
         MsgMan.addObserver("MarryEventType.TREE_CHANGE_CLIENT",this,__curentvalueChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_fosterBtn)
         {
            _fosterBtn.removeEventListener("click",__fosterBtnHandler);
         }
         if(_allInBtn)
         {
            _allInBtn.removeEventListener("click",__allInBtnHandler);
         }
         _goldTrainButton.removeEventListener("click",__trainButtonHandler);
         _diamondTrainButton.removeEventListener("click",__trainButtonHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         MsgMan.removeObserver("MarryEventType.MARRIAGE_DATA",this,__infoUpdateHandler);
         MsgMan.removeObserver("MarryEventType.TREE_CHANGE_CLIENT",this,__curentvalueChangeHandler);
      }
      
      private function __trainButtonHandler(param1:MouseEvent) : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(_achieveMaxLevel)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.treeMaxLevel"));
            return;
         }
         switch(param1.currentTarget)
         {
            case _goldTrainButton:
               if(_goldAddtime - godTreeInfo.treeGoldWater <= 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("godarrive.GodArriveFrame.NoLeftCount"));
                  return;
               }
               if(ResourceManager.instance.gold.count < _goldAddCost)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("star.view.MakeStarView.command02"));
                  return;
               }
               MarrySender.opMarryTree(1006,0);
               break;
            case _diamondTrainButton:
               if(_diamondAddTime - godTreeInfo.treeDiamondWater <= 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("godarrive.GodArriveFrame.NoLeftCount"));
                  return;
               }
               if(checkIsExpired(SharedManager.instance.diamondTrainAlertDate))
               {
                  _loc4_ = ComponentFactory.Instance.creatComponentByStylename("marry.diamondTrainNotAlert");
                  _loc3_ = LanguageMgr.GetTranslation("marry.income.MarryTreeDiamondTrainContent.Alert",_diamondAddCost);
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
                  _loc4_.show(_loc3_,_loc2_,checkPointForDiamondTrain,null,"center",2,true);
               }
               else
               {
                  doDiamondTrain();
               }
         }
      }
      
      private function checkPointForDiamondTrain(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.diamondTrainAlertDate = new Date();
            SharedManager.instance.saveDiamondTrainAlertDate();
            SharedManager.instance.diamondTrainUseBind = param2;
            SharedManager.instance.saveUpdiamondTrainUseBind();
         }
         doDiamondTrain(param2);
      }
      
      private function doDiamondTrain(param1:Boolean = true) : void
      {
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         if(_loc2_ < _diamondAddCost)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc3_:int = param1 ? 2 : 1;
         MarrySender.opMarryTree(1006,_loc3_);
      }
      
      private function needValue(param1:String) : int
      {
         var _loc2_:ConfigInfosTempInfo = null;
         var _loc3_:int = 10;
         _loc2_ = TempleteManager.instance.getConfigInfoByConfigName(param1);
         return int(_loc2_.ConfigValue);
      }
      
      private function checkIsExpired(param1:Date) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function __refreshBtnHandler(param1:MouseEvent) : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(marryModel.refreshTreeAlter)
         {
            refreshCall();
         }
         else
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc3_ = LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.refreshContent",_refreshGold);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_.show(_loc3_,_loc2_,refreshCall,null,"center",2,true);
         }
      }
      
      private function refreshCall(param1:Boolean = true) : void
      {
         if(_refreshGold > ResourceManager.instance.gold.count)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
         }
         else
         {
            MarrySender.opMarryTree(1005);
         }
         marryModel.refreshTreeAlter = param1;
      }
      
      private function __allInBtnHandler(param1:MouseEvent) : void
      {
         var _loc7_:GoodsInfo = null;
         var _loc5_:int = 0;
         if(marryModel.endPos1 > 9)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command02"));
            return;
         }
         var _loc2_:Array = [];
         var _loc6_:SimpleDictionary = GoodsManager.instance.getGeneralBagList();
         for each(_loc7_ in _loc6_)
         {
            if(filterGoods(_loc7_))
            {
               _loc2_.push(_loc7_);
            }
         }
         var _loc3_:int = int(_itemList1.length);
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(_itemList1[_loc5_].data == null)
            {
               _loc7_ = _loc2_[_loc4_] as GoodsInfo;
               if(_loc7_)
               {
                  PlayerManager.instance.moveBagToBag(_loc7_.bagType,_loc7_.objectId,_loc7_.pos,0,0,_loc5_,1);
                  _loc4_ += 1;
               }
            }
            _loc5_++;
         }
      }
      
      private function __fosterBtnHandler(param1:MouseEvent) : void
      {
         if(_curentvalue >= 800)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.income.MarryTreeFosterFrame.enoughValue"));
         }
         else
         {
            MarrySender.opMarryTree(1002);
         }
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("MarryTreeFosterFrame.HelpFrame");
         _loc2_.show();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:MarryTreeBagCell = null;
         var _loc3_:GoodsInfo = param1.info;
         if(filterGoods(_loc3_))
         {
            if(_loc3_.bagType == 0)
            {
               if(_itemList1[_loc3_.pos])
               {
                  _itemList1[_loc3_.pos].data = _loc3_;
                  _itemDic.add(_loc3_.pos + "_" + _loc3_.bagType,_itemList1[_loc3_.pos]);
                  setAddTxt();
               }
            }
            else if(_loc3_.bagType == 1)
            {
               _loc2_ = _itemDic[_loc3_.pos + "_" + _loc3_.bagType];
               if(_loc2_)
               {
                  _loc2_.data = _loc3_;
               }
               else
               {
                  addInfoToItem(_loc3_,_itemList2);
               }
            }
            setEndPos();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:MarryTreeBagCell = null;
         var _loc3_:GoodsInfo = param1.info;
         if(filterGoods(_loc3_))
         {
            _loc2_ = _itemDic[_loc3_.pos + "_" + _loc3_.bagType];
            if(_loc2_)
            {
               _loc2_.data = null;
               if(_loc3_.bagType == 0)
               {
                  setAddTxt();
               }
            }
            setEndPos();
         }
      }
      
      private function setAddTxt() : void
      {
         _addNum = 0;
         for each(var _loc1_:MarryTreeBagCell in _itemList1)
         {
            if(!_loc1_.data)
            {
            }
         }
      }
      
      private function filterGoods(param1:GoodsInfo) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return param1.templateInfo.Feed > 0;
      }
      
      private function setEndPos() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(_itemList1.length);
         var _loc1_:Boolean = false;
         var _loc4_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_itemList1[_loc3_].data)
            {
               _loc1_ = true;
            }
            else if(_loc4_ == false)
            {
               _loc4_ = true;
               marryModel.endPos1 = _itemList1[_loc3_].pos;
            }
            _loc3_++;
         }
         if(_loc4_ == false)
         {
            marryModel.endPos1 = 10;
         }
         _fosterBtn.enable = _loc1_ && _canTrain;
         _loc2_ = int(_itemList2.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_itemList2[_loc3_].data == null)
            {
               marryModel.endPos2 = _itemList2[_loc3_].pos;
               break;
            }
            _loc3_++;
         }
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get playerIndo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1)
         {
            _curentvalue = int(param1.frameData);
         }
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         FashionManager.instance.fashionModel.moveGoodsBack();
         removeEvent();
         cleanGoods();
         ObjectUtils.disposeAllChildren(this);
         if(_fosterBtn)
         {
            _fosterBtn.dispose();
         }
         _fosterBtn = null;
         if(_allInBtn)
         {
            _allInBtn.dispose();
         }
         _allInBtn = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_inComeAdd)
         {
            _inComeAdd.dispose();
         }
         _inComeAdd = null;
         if(_panel)
         {
            _panel.dispose();
         }
         _panel = null;
         if(_itemContainer1)
         {
            _itemContainer1.dispose();
         }
         _itemContainer1 = null;
         if(_itemContainer2)
         {
            _itemContainer2.dispose();
         }
         _itemContainer2 = null;
         if(_itemContainer3)
         {
            _itemContainer3.dispose();
         }
         _itemContainer3 = null;
         if(_itemContainer4)
         {
            _itemContainer4.dispose();
         }
         _itemContainer4 = null;
         if(_diamondTrainButton)
         {
            _diamondTrainButton.dispose();
         }
         _diamondTrainButton = null;
         if(_goldTrainButton)
         {
            _goldTrainButton.dispose();
         }
         _goldTrainButton = null;
         if(_treeLevel)
         {
            _treeLevel.dispose();
         }
         _treeLevel = null;
         if(_nextIncome)
         {
            _nextIncome.dispose();
         }
         _nextIncome = null;
         if(_fullStateCanget)
         {
            _fullStateCanget.dispose();
         }
         _fullStateCanget = null;
         if(_consumeGold)
         {
            _consumeGold.dispose();
         }
         _consumeGold = null;
         if(_chooseItems)
         {
            _chooseItems.dispose();
         }
         _chooseItems = null;
         if(_trainCountDown)
         {
            _trainCountDown.dispose();
         }
         _trainCountDown = null;
         if(_countDown)
         {
            _countDown.dispose();
         }
         _countDown = null;
         if(_costDiamond)
         {
            _costDiamond.dispose();
         }
         _costDiamond = null;
         if(_costGold)
         {
            _costGold.dispose();
         }
         _costGold = null;
         if(_leftTime2)
         {
            _leftTime2.dispose();
         }
         _leftTime2 = null;
         if(_leftTime1)
         {
            _leftTime1.dispose();
         }
         _leftTime1 = null;
         if(_expText2)
         {
            _expText2.dispose();
         }
         _expText2 = null;
         if(_expText1)
         {
            _expText1.dispose();
         }
         _expText1 = null;
         if(_progress1)
         {
            _progress1.dispose();
         }
         _progress1 = null;
         if(_progress2)
         {
            _progress2.dispose();
         }
         _progress2 = null;
         _itemList1 = null;
         _itemList2 = null;
         _itemDic = null;
         super.dispose();
      }
   }
}

