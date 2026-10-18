package monster.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.MonsterAccessoryHammerMsg;
   import com.road.yishi.proto.store.StoreRspMsg;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import monster.MonsterAccessoriesHelpFrame;
   import monster.MonsterAutoHammerFrame;
   import monster.cell.MonsterAccessoriesEquipCell;
   import monster.cell.MonsterAccessoriesItemCell;
   import monster.item.MonsterAccessoriesEffectItem;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.comm.PackageIn;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.MonsterManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterAccessoriesView extends Component
   {
      
      private static const STRENGETHEN_ITEMID:int = 2330001;
      
      private static const PROP_MODULUS:Number = 0.05;
      
      private var _back:MutipleImage;
      
      private var _hammerBtn:IconButton;
      
      private var _strengethenBtn:IconButton;
      
      private var _lvTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _propVbox:VBox;
      
      private var _effectTxt:FilterFrameText;
      
      private var _descBtn:IconButton;
      
      private var _strengethenLvTxt:FilterFrameText;
      
      private var _strengethenBar:ProgressCommon;
      
      private var _item:BaseItemView;
      
      private var _numImg:Image;
      
      private var _numBg:ScaleBitmapImage;
      
      private var _numTxt:FilterFrameText;
      
      private var _intensifyBtn:IconButton;
      
      private var _breakthroughBtn:IconButton;
      
      private var _currCount:FilterFrameText;
      
      private var _equipCell:MonsterAccessoriesEquipCell;
      
      private var _data:GoodsInfo;
      
      private var _breakHbox:HBox;
      
      private var _breakItemList:Array = [];
      
      private var _bagView:MonsterAccessoriesBagView;
      
      private var _itemDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _effectVbox:VBox;
      
      private var _effectItemList:Vector.<MonsterAccessoriesEffectItem>;
      
      private var _strengethenSprite:Sprite = new Sprite();
      
      private var _hammerSprite:Sprite = new Sprite();
      
      private var _selectedVBox:VBox;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _selectedBtnList:Vector.<SelectedButton>;
      
      private var _pushImg:Image;
      
      private var _successImg:Image;
      
      private var _percentImg:Image;
      
      private var _hammerButton:IconButton;
      
      private var _autoHammerButton:IconButton;
      
      private var _successNumImg:BitmapData;
      
      private var _successNumSprite:Sprite;
      
      private var _itemCellHBox:HBox;
      
      private var _itemCellList:Vector.<MonsterAccessoriesItemCell>;
      
      private var _percent:int;
      
      private var _autoHammerFrame:MonsterAutoHammerFrame;
      
      private var _strengethenMC:MovieClip;
      
      private var _successMC:MovieClip;
      
      private var _failMC:MovieClip;
      
      private var _selectedChangeTxt:FilterFrameText;
      
      public function MonsterAccessoriesView()
      {
         super();
         KeyBoardRegister.instance.keyEnable = false;
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.back");
         _hammerBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.hammerBtn");
         _strengethenBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.strengethenBtn");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.lvTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.nameTxt");
         _effectTxt = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.effectTxt");
         _descBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.descBtn");
         _strengethenLvTxt = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.strengethenLvTxt");
         _strengethenBar = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.strengethenBar");
         _item = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.baseItemView");
         _numImg = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.numImg");
         _numBg = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.numBg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.numTxt");
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.intensifyBtn");
         _breakthroughBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.breakthroughBtn");
         _currCount = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.currCount");
         _equipCell = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.EquipCell");
         _propVbox = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.propVbox");
         _breakHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.breakHbox");
         _effectVbox = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.effectVbox");
         _bagView = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.bagView");
         _pushImg = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.pushImg");
         _successImg = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.successImg");
         _percentImg = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.percentImg");
         _hammerButton = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.hammerButton");
         _autoHammerButton = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.autoHammerButton");
         _selectedVBox = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.selectedVBox");
         _itemCellHBox = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.itemCellHbox");
         _successNumImg = ComponentFactory.Instance.creatBitmapData("asset.MonsterAccessoriesView.successNumImg");
         _strengethenMC = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.strengethenMC");
         _successMC = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.successMC");
         _failMC = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.failMC");
         _selectedChangeTxt = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.selectedChangeTxt");
         _successNumSprite = new Sprite();
         _successNumSprite.x = 475;
         _successNumSprite.y = 330;
         addChild(_back);
         addChild(_lvTxt);
         addChild(_nameTxt);
         addChild(_propVbox);
         addChild(_effectTxt);
         addChild(_effectVbox);
         addChild(_hammerSprite);
         _hammerSprite.visible = false;
         addChild(_strengethenSprite);
         addChild(_descBtn);
         _strengethenSprite.addChild(_strengethenLvTxt);
         _strengethenSprite.addChild(_strengethenBar);
         _strengethenSprite.addChild(_breakHbox);
         _strengethenSprite.addChild(_item);
         _strengethenSprite.addChild(_numImg);
         _strengethenSprite.addChild(_numBg);
         _strengethenSprite.addChild(_numTxt);
         _strengethenSprite.addChild(_currCount);
         _strengethenSprite.addChild(_strengethenMC);
         _strengethenSprite.addChild(_breakthroughBtn);
         _breakthroughBtn.visible = false;
         _strengethenSprite.addChild(_intensifyBtn);
         _hammerSprite.addChild(_pushImg);
         _hammerSprite.addChild(_successImg);
         _hammerSprite.addChild(_percentImg);
         _hammerSprite.addChild(_successNumSprite);
         _hammerSprite.addChild(_hammerButton);
         _hammerSprite.addChild(_autoHammerButton);
         _hammerSprite.addChild(_selectedVBox);
         _hammerSprite.addChild(_itemCellHBox);
         _hammerSprite.addChild(_selectedChangeTxt);
         _hammerSprite.addChild(_successMC);
         _hammerSprite.addChild(_failMC);
         _strengethenMC.gotoAndStop(1);
         _successMC.gotoAndStop(1);
         _failMC.gotoAndStop(1);
         addChild(_strengethenBtn);
         _strengethenBtn.visible = false;
         addChild(_hammerBtn);
         addChild(_equipCell);
         addChild(_bagView);
         _itemDic.add("0_0_0",_equipCell);
         NumberViewUtils.refreshValue(0,_successNumSprite,_successNumImg,19,26,17,19,"1234567890");
         initEffect();
         initItemCell();
         initSelectedBtn();
      }
      
      private function initEffect() : void
      {
         var _loc1_:MonsterAccessoriesEffectItem = null;
         var _loc2_:int = 0;
         _effectItemList = new Vector.<MonsterAccessoriesEffectItem>();
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc1_ = new MonsterAccessoriesEffectItem(_loc2_);
            _effectVbox.addChild(_loc1_);
            _effectItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initItemCell() : void
      {
         var _loc2_:MonsterAccessoriesItemCell = null;
         var _loc1_:int = 0;
         _itemCellList = new Vector.<MonsterAccessoriesItemCell>();
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.ItemCell",[_loc1_]);
            _itemDic.add(_loc1_ + "_0_" + 0,_loc2_);
            _itemCellHBox.addChild(_loc2_);
            _itemCellList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function initSelectedBtn() : void
      {
         var _loc2_:SelectedButton = null;
         var _loc1_:int = 0;
         _selectedBtnList = new Vector.<SelectedButton>();
         _selectedBtnGroup = new SelectedButtonGroup();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.checkstyle_2.CheckButton");
            _selectedVBox.addChild(_loc2_);
            _selectedBtnGroup.addSelectItem(_loc2_);
            _selectedBtnList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _numTxt.addEventListener("change",__textChangHandler);
         _numTxt.addEventListener("focusIn",__inHandler);
         _intensifyBtn.addEventListener("click",__intensifyBtnClickHandler);
         _breakthroughBtn.addEventListener("click",__breakthroughBtnClickHandler);
         _hammerBtn.addEventListener("click",__hammerBtnClickHandler);
         _strengethenBtn.addEventListener("click",__strengethenBtnClickHandler);
         if(_selectedBtnGroup)
         {
            _selectedBtnGroup.addEventListener("change",__selectedHandler);
         }
         _hammerButton.addEventListener("click",__hammerButtonClickHandler);
         _autoHammerButton.addEventListener("click",__autoHammerButtonClickHandler);
         _descBtn.addEventListener("click",__descBtnClickHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 86,__intensifyResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 186,__hammerResult);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _numTxt.removeEventListener("change",__textChangHandler);
         _numTxt.removeEventListener("focusIn",__inHandler);
         _intensifyBtn.removeEventListener("click",__intensifyBtnClickHandler);
         _breakthroughBtn.removeEventListener("click",__breakthroughBtnClickHandler);
         _hammerBtn.removeEventListener("click",__hammerBtnClickHandler);
         _strengethenBtn.removeEventListener("click",__strengethenBtnClickHandler);
         if(_selectedBtnGroup)
         {
            _selectedBtnGroup.removeEventListener("change",__selectedHandler);
         }
         _hammerButton.removeEventListener("click",__hammerButtonClickHandler);
         _autoHammerButton.removeEventListener("click",__autoHammerButtonClickHandler);
         _descBtn.removeEventListener("click",__descBtnClickHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 86,__intensifyResult);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 186,__hammerResult);
      }
      
      private function __descBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MonsterAccessoriesHelpFrame = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.helpFrame");
         _loc2_.show();
      }
      
      private function __autoHammerButtonClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         if(!VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt || VIPManager.Instance.model.vipInfo.VipGrade < 4)
         {
            SimpleAlertHelper.instance.data = [__quickHammerHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("vip.newVipOpenView.monsterAutoHammer.alert");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc4_,_loc2_,_loc3_,true,true);
            return;
         }
         if(!isCanHammer)
         {
            return;
         }
         if(!isCanAutoHammer)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterAccessoriesView.notAutoHammer.text"));
            return;
         }
         var _loc5_:int = _selectedBtnGroup.selectIndex + 1;
         _autoHammerFrame = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.autoHammerFrame",[_loc5_]);
         _autoHammerFrame.show();
         model.isAutoHammer = true;
      }
      
      private function __quickHammerHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function __hammerButtonClickHandler(param1:MouseEvent) : void
      {
         if(!isCanHammer)
         {
            return;
         }
         var _loc2_:int = _selectedBtnGroup.selectIndex + 1;
         MonsterManager.instance.sendMonsterHammer(_loc2_,tempIdArr);
      }
      
      private function get isCanAutoHammer() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:GoodsInfo = null;
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _loc2_ = GoodsManager.instance.getHideBagItemByPos(_loc1_);
            if(_loc2_ && _loc2_.templateInfo.SonType == 232)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function get isCanHammer() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         if(_selectedBtnGroup.selectIndex == -1)
         {
            return false;
         }
         if(_percent <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterAccessoriesView.push.goods"));
            return false;
         }
         if(tempIdArr.length == 0)
         {
            return false;
         }
         return true;
      }
      
      private function get tempIdArr() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         var _loc1_:Array = [];
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc3_ = GoodsManager.instance.getHideBagItemByPos(_loc2_);
            if(_loc3_)
            {
               _loc1_.push(_loc3_.templateId);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         _selectedChangeTxt.text = _selectedBtnGroup.selectIndex == -1 ? "" : LanguageMgr.GetTranslation("MonsterAccessoriesView.selectedChangeTxt.text" + _selectedBtnGroup.selectIndex);
         refreshPercent();
      }
      
      private function __strengethenBtnClickHandler(param1:MouseEvent) : void
      {
         model.isStrengethenPanel = true;
         _hammerBtn.visible = _strengethenSprite.visible = model.isStrengethenPanel;
         _strengethenBtn.visible = _hammerSprite.visible = !model.isStrengethenPanel;
         _selectedBtnGroup.selectIndex = -1;
         moveItemGoodBack();
         refreshView();
      }
      
      private function __hammerBtnClickHandler(param1:MouseEvent) : void
      {
         model.isStrengethenPanel = false;
         _hammerBtn.visible = _strengethenSprite.visible = model.isStrengethenPanel;
         _strengethenBtn.visible = _hammerSprite.visible = !model.isStrengethenPanel;
         refreshView();
      }
      
      protected function __intensifyResult(param1:SLGSocketEvent) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:MonsterAccessoriesEquipCell = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreRspMsg = new StoreRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as StoreRspMsg;
         if(_loc2_.strengResult)
         {
            _loc5_ = GoodsManager.instance.getHideBagItemByPos(_loc2_.pos);
            _loc5_.objectId = _loc2_.objectId;
            _loc5_.bagType = _loc2_.bagType;
            _loc5_.strengthenGrade = _loc2_.strengthenGrade;
            _loc5_.strBlessValue = _loc2_.strBlessValue;
            _loc3_ = _itemDic[_loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType];
            if(_loc3_)
            {
               _loc3_.data = _loc5_;
               refreshView();
               _strengethenMC.gotoAndPlay(1);
            }
         }
      }
      
      private function __hammerResult(param1:SLGSocketEvent) : void
      {
         if(model.isAutoHammer)
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonsterAccessoryHammerMsg = new MonsterAccessoryHammerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MonsterAccessoryHammerMsg;
         if(_loc2_.isAuto)
         {
            return;
         }
         if(_loc2_.success)
         {
            this.mouseChildren = this.mouseEnabled = false;
            _successMC.gotoAndPlay(1);
            _successMC.addFrameScript(_successMC.totalFrames - 1,end);
         }
         else
         {
            this.mouseChildren = this.mouseEnabled = false;
            _failMC.gotoAndPlay(1);
            _failMC.addFrameScript(_failMC.totalFrames - 1,end);
         }
      }
      
      private function end() : void
      {
         _successMC.gotoAndStop(1);
         _failMC.gotoAndStop(1);
         this.mouseChildren = this.mouseEnabled = true;
      }
      
      private function __intensifyBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(!strengethenGoodsNum)
         {
            return;
         }
         MonsterManager.instance.sendMonsterIntensify(parseInt(_numTxt.text));
      }
      
      private function __breakthroughBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         MonsterManager.instance.sendMonsterBreakthrough();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType != 0)
         {
            refreshBreakHbox();
            setCurCountTxt();
            return;
         }
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         _loc2_.data = _loc3_;
         if(_loc3_.pos == 0)
         {
            refreshView();
         }
         else
         {
            refreshPercent();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType != 0)
         {
            refreshBreakHbox();
            setCurCountTxt();
            return;
         }
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         _loc2_.data = null;
         if(_loc3_.pos == 0)
         {
            refreshView();
         }
         else
         {
            refreshPercent();
         }
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_numTxt.text);
         if(_loc2_ <= 0)
         {
            _numTxt.text = "1";
         }
         if(_loc2_ >= strengethenGoodsNum)
         {
            _numTxt.text = strengethenGoodsNum + "";
         }
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _numTxt.setSelection(0,_numTxt.text.length);
      }
      
      private function refreshView() : void
      {
         clear();
         if(!_equipCell.data)
         {
            _selectedBtnGroup.selectIndex = -1;
            return;
         }
         _data = _equipCell.data;
         _lvTxt.text = LanguageMgr.GetTranslation("public.level2",_data.strengthenGrade);
         _nameTxt.text = _data.templateInfo.TemplateName;
         _strengethenLvTxt.text = LanguageMgr.GetTranslation("public.level2",_data.strengthenGrade);
         refreshProp();
         refreshEffect();
         refreshState();
      }
      
      private function refreshEffect() : void
      {
         var _loc4_:MonsterAccessoriesEffectItem = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:SkillTempInfo = null;
         var _loc3_:String = null;
         _effectVbox.visible = true;
         var _loc2_:Array = [];
         var _loc1_:int = int(model.getEffectSonType(_data));
         if(_loc1_ != 0)
         {
            _loc5_ = 1;
            while(_loc5_ <= _effectItemList.length)
            {
               _loc4_ = _effectItemList[_loc5_ - 1];
               _loc7_ = int(_data["randomSkill" + _loc5_]);
               if(_loc7_ > 0)
               {
                  _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc7_);
                  _loc4_.data = _loc6_;
               }
               if(_loc4_.data)
               {
                  if(_loc4_.data.SonType == _loc1_)
                  {
                     _loc4_.icon.setFrame(2);
                     _loc2_.push(_loc4_.data.Grades);
                  }
                  else
                  {
                     _loc4_.icon.setFrame(1);
                  }
               }
               _loc5_++;
            }
            _loc3_ = model.getEffectTxt(_loc1_,_loc2_);
            if(_loc3_ != "")
            {
               _effectTxt.text = _loc3_;
            }
         }
         if(_effectTxt.text == "")
         {
            _effectTxt.text = LanguageMgr.GetTranslation("MonsterAccessoriesTipsContent.effectTxt.text");
         }
         _effectTxt.y = 135 - 7 * (_effectTxt.numLines - 1);
      }
      
      private function refreshState() : void
      {
         var _loc3_:int = 0;
         var _loc1_:UpgradeTemplateInfo = null;
         var _loc2_:Boolean = false;
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc5_:int = 0;
         if(model.isStrengethenPanel)
         {
            _loc3_ = int(_data.strengthenGrade);
            _loc1_ = model.accessoriesUpgradeTempAry[_loc3_];
            _loc2_ = _data.strengthenGrade < _data.templateInfo.StrengthenMax;
            _item.visible = _numImg.visible = _numBg.visible = _numTxt.visible = _currCount.visible = _intensifyBtn.visible = _loc2_;
            _breakthroughBtn.visible = !_loc2_;
            _breakthroughBtn.enable = true;
            if(_loc1_)
            {
               _loc4_ = _loc1_;
               if(!_loc2_)
               {
                  initBreakthroughItem();
                  _loc4_ = model.accessoriesUpgradeTempAry[_loc3_ - 1];
               }
               else
               {
                  _loc6_ = new GoodsInfo();
                  _loc6_.templateId = 2330001;
                  _item.data = _loc6_;
                  _intensifyBtn.enable = strengethenGoodsNum >= 1;
                  setCurCountTxt();
                  _numTxt.text = "1";
               }
               if(_loc4_)
               {
                  _loc5_ = int(_loc4_.Data);
                  _strengethenBar.text = _data.strBlessValue + "/" + _loc5_;
                  _strengethenBar.value = _data.strBlessValue > _loc5_ ? 1 : _data.strBlessValue / _loc5_;
               }
            }
            else
            {
               _strengethenBar.text = LanguageMgr.GetTranslation("gemMaze.GemMazeFrame.LvMax");
               _strengethenBar.value = 1;
               _breakthroughBtn.enable = false;
            }
         }
         else
         {
            refreshSelectedBtn();
            refreshPercent();
         }
      }
      
      private function refreshSelectedBtn() : void
      {
         var _loc1_:MonsterAccessoriesEffectItem = null;
         var _loc3_:SelectedButton = null;
         var _loc2_:int = 0;
         _selectedVBox.visible = true;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = _effectItemList[_loc2_];
            _loc3_ = _selectedBtnList[_loc2_];
            if(_loc3_)
            {
               _loc3_.enable = _loc1_.data != null;
            }
            _loc2_++;
         }
         if(_selectedBtnGroup.selectIndex == -1)
         {
            _loc1_ = _effectItemList[0];
            if(_loc1_ && _loc1_.data)
            {
               _selectedBtnGroup.selectIndex = 0;
            }
         }
         else
         {
            _loc1_ = _effectItemList[_selectedBtnGroup.selectIndex];
            if(_loc1_ && !_loc1_.data)
            {
               _loc1_ = _effectItemList[0];
               if(_loc1_ && _loc1_.data)
               {
                  _selectedBtnGroup.selectIndex = 0;
               }
               else
               {
                  _selectedBtnGroup.selectIndex = -1;
               }
            }
         }
      }
      
      private function refreshPercent() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         var _loc2_:int = int(percentArr[_selectedBtnGroup.selectIndex]);
         for each(var _loc4_:GoodsInfo in _loc1_)
         {
            if(_loc4_.pos != 0)
            {
               _loc3_ += int(_loc4_.templateInfo.Property1 * _loc2_ / 100);
            }
         }
         _percent = _selectedBtnGroup.selectIndex == -1 ? 0 : _loc3_;
         _percent = _percent > 100 ? 100 : _percent;
         NumberViewUtils.refreshValue(_percent,_successNumSprite,_successNumImg,19,26,17,19,"1234567890");
         _successNumSprite.x = 495 - _successNumSprite.width;
         _hammerButton.enable = _percent > 0;
         _autoHammerButton.enable = _percent > 0;
      }
      
      private function initBreakthroughItem() : void
      {
         var _loc7_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc6_:Array = null;
         _breakHbox.removeAllChild();
         _breakItemList = [];
         var _loc1_:Array = ConfigInfoManager.instance.getMonsterSkillLvBreak(_data.strengthenGrade);
         var _loc5_:int = _data.templateInfo.Property6 - 1;
         var _loc4_:Array = _loc1_[_loc5_].split(";");
         for each(var _loc3_:String in _loc4_)
         {
            _loc6_ = _loc3_.split(",");
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc6_[0];
            _loc7_.count = _loc6_[1];
            _loc2_ = ComponentFactory.Instance.creatCustomObject("MonsterAccessoriesView.breakthroughItem.BaseItemView");
            _loc2_.data = _loc7_;
            _breakHbox.addChild(_loc2_);
            _breakItemList.push(_loc2_);
         }
         refreshBreakHbox();
      }
      
      private function refreshBreakHbox() : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc1_:String = null;
         var _loc6_:int = 0;
         if(_breakItemList.length == 0)
         {
            return;
         }
         var _loc3_:Boolean = false;
         for each(var _loc2_:BaseItemView in _breakItemList)
         {
            if(_loc2_.data)
            {
               _loc5_ = _loc2_.data;
               _loc4_ = int(GoodsManager.instance.getBagCountByTempId(36,_loc5_.templateId));
               _loc1_ = _loc4_ + "/" + _loc5_.count;
               _loc2_.setItemTextOther(_loc1_);
               _loc6_ = _loc4_ >= _loc5_.count ? 1 : 2;
               if(_loc4_ < _loc5_.count)
               {
                  _loc3_ = true;
               }
               _loc2_.itemText.setFrame(_loc6_);
            }
         }
         _breakthroughBtn.enable = !_loc3_;
      }
      
      private function refreshProp() : void
      {
         var _loc7_:FilterFrameText = null;
         var _loc4_:int = 0;
         var _loc8_:String = null;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc6_:String = null;
         var _loc3_:Sprite = null;
         var _loc10_:Image = null;
         var _loc9_:Array = _data.templateInfo.hasValueAttResi;
         _loc4_ = 0;
         while(_loc4_ < _loc9_.length)
         {
            _loc8_ = _loc9_[_loc4_];
            _loc1_ = int(_data.templateInfo[_loc8_]);
            _loc5_ = _loc1_ + 0.05 * (_data.strengthenGrade - 1) * _loc1_;
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.mainAttText");
            _loc2_ = "";
            if(model.isStrengethenPanel && _data.strengthenGrade < _data.templateInfo.StrengthenMax)
            {
               _loc2_ = "+" + 0.05 * _loc1_;
            }
            _loc6_ = LanguageMgr.GetTranslation("MonsterAccessoriesView.mainAttText.text" + _loc8_,_loc5_) + " " + _loc2_;
            _loc7_.setFrame(_data.templateInfo.Profile);
            _loc7_.htmlText = _loc6_;
            _loc3_ = new Sprite();
            _loc3_.addChild(_loc7_);
            if(model.isStrengethenPanel)
            {
               _loc10_ = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesView.upArrow");
               _loc10_.x = _loc7_.x + _loc7_.textWidth + 5;
               _loc10_.y = _loc7_.y;
               _loc3_.addChild(_loc10_);
            }
            _propVbox.addChild(_loc3_);
            _loc4_++;
         }
      }
      
      private function clear() : void
      {
         _lvTxt.text = "";
         _nameTxt.text = "";
         _propVbox.removeAllChild();
         _effectTxt.text = "";
         _strengethenLvTxt.text = "";
         _strengethenBar.text = "";
         _strengethenBar.value = 0;
         _item.data = null;
         _numTxt.text = "";
         _breakHbox.removeAllChild();
         _effectVbox.visible = false;
         _selectedVBox.visible = false;
         _currCount.text = "";
         _breakItemList = [];
         for each(var _loc1_:MonsterAccessoriesEffectItem in _effectItemList)
         {
            _loc1_.data = null;
         }
      }
      
      private function get percentArr() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("moster_skill_probability");
         if(_loc2_)
         {
            _loc1_ = _loc2_.ConfigValue.split(",");
         }
         return _loc1_;
      }
      
      private function get strengethenGoodsNum() : int
      {
         return GoodsManager.instance.getBagCountByTempId(36,2330001);
      }
      
      private function setCurCountTxt() : void
      {
         _currCount.text = LanguageMgr.GetTranslation("MonsterAccessoriesView.currCount.text",strengethenGoodsNum);
      }
      
      public function moveGoodsBack() : void
      {
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,1,0,0,1);
         }
      }
      
      public function moveItemGoodBack() : void
      {
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            if(_loc2_.pos != 0)
            {
               PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,1,0,0,1);
            }
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         model.isAutoHammer = false;
         model.isStrengethenPanel = true;
         KeyBoardRegister.instance.keyEnable = true;
         moveGoodsBack();
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_propVbox);
         _propVbox = null;
         ObjectUtils.disposeObject(_effectTxt);
         _effectTxt = null;
         ObjectUtils.disposeObject(_effectVbox);
         _effectVbox = null;
         ObjectUtils.disposeObject(_descBtn);
         _descBtn = null;
         ObjectUtils.disposeObject(_strengethenLvTxt);
         _strengethenLvTxt = null;
         ObjectUtils.disposeObject(_strengethenBar);
         _strengethenBar = null;
         ObjectUtils.disposeObject(_breakHbox);
         _breakHbox = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_numImg);
         _numImg = null;
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_currCount);
         _currCount = null;
         ObjectUtils.disposeObject(_breakthroughBtn);
         _breakthroughBtn = null;
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_pushImg);
         _pushImg = null;
         ObjectUtils.disposeObject(_successImg);
         _successImg = null;
         ObjectUtils.disposeObject(_percentImg);
         _percentImg = null;
         ObjectUtils.disposeObject(_successNumSprite);
         _successNumSprite = null;
         ObjectUtils.disposeObject(_hammerButton);
         _hammerButton = null;
         ObjectUtils.disposeObject(_autoHammerButton);
         _autoHammerButton = null;
         ObjectUtils.disposeObject(_selectedVBox);
         _selectedVBox = null;
         ObjectUtils.disposeObject(_itemCellHBox);
         _itemCellHBox = null;
         ObjectUtils.disposeObject(_selectedChangeTxt);
         _selectedChangeTxt = null;
         ObjectUtils.disposeObject(_strengethenBtn);
         _strengethenBtn = null;
         ObjectUtils.disposeObject(_hammerBtn);
         _hammerBtn = null;
         ObjectUtils.disposeObject(_equipCell);
         _equipCell = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_hammerSprite);
         _hammerSprite = null;
         ObjectUtils.disposeObject(_strengethenSprite);
         _strengethenSprite = null;
         ObjectUtils.disposeViolentMc(_strengethenMC);
         _strengethenMC = null;
         ObjectUtils.disposeViolentMc(_successMC);
         _successMC = null;
         ObjectUtils.disposeViolentMc(_failMC);
         _failMC = null;
         ObjectUtils.disposeObject(_autoHammerFrame);
         _autoHammerFrame = null;
         ObjectUtils.disposeObject(_successNumImg);
         _successNumImg = null;
         ObjectUtils.disposeObject(_selectedBtnGroup);
         _selectedBtnGroup = null;
         LogicUtils.disposeDisplayCollection(_itemDic);
         _itemDic = null;
         LogicUtils.disposeDisplayCollection(_effectItemList);
         _effectItemList = null;
         LogicUtils.disposeDisplayCollection(_selectedBtnList);
         _selectedBtnList = null;
         LogicUtils.disposeDisplayCollection(_itemCellList);
         _itemCellList = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

