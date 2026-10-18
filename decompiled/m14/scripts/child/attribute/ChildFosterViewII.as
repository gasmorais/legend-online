package child.attribute
{
   import bag.events.BagEvent;
   import child.equip.ChildBagCell;
   import child.equip.ChildIntensifyEquipView;
   import child.switched.ChildSwitchFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import utils.LogicUtils;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildFosterViewII extends Component
   {
      
      private var _data:ChildData;
      
      private var _upgrageBtn:TextButton;
      
      private var _twoStepBtn:TextButton;
      
      private var _sellChildBtn:TextButton;
      
      private var _enterSetBtn:TextButton;
      
      private var _masterChildBtn:TextButton;
      
      private var _slavedChildBtn:TextButton;
      
      private var _resetBtn:TextButton;
      
      private var _switchBtn:TextButton;
      
      private var _awakeSkillBtn:BaseButton;
      
      private var _emblemBtn:BaseButton;
      
      private var _resiBtn:BaseButton;
      
      private var _reduceResiBtn:BaseButton;
      
      private var _equipGrid:DisplayObject;
      
      private var _fightBgImage:Bitmap;
      
      private var _fightImage:Bitmap;
      
      private var _fightBmd:BitmapData;
      
      private var _fightSp:Sprite;
      
      private var _equipVBox1:VBox;
      
      private var _equipVBox2:VBox;
      
      private var _equipList:Vector.<ChildBagCell>;
      
      private var lastFightBtnClickTime:Number = 0;
      
      private var showType:int;
      
      public function ChildFosterViewII(param1:int)
      {
         super();
         showType = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _upgrageBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.upgrageBtn");
         _twoStepBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.twoStepBtn");
         _sellChildBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.sellChildBtn");
         _enterSetBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.enterSetBtn");
         _masterChildBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.masterChildBtn");
         _slavedChildBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.slavedChildBtn");
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.resetBtn");
         _switchBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.switchBtn");
         _awakeSkillBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.awakeSkillBtn");
         _emblemBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.emblemBtn");
         _resiBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.resiBtn");
         _reduceResiBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.reduceResiBtn");
         _equipGrid = ComponentFactory.Instance.creat("asset.child.ChildFosterViewII.equipGrid");
         if(showType == 2 && Boolean(VersionSwitch.CHILD_ASSIST) && Boolean(playerInfo.isAvenger))
         {
            _fightBgImage = ComponentFactory.Instance.creatBitmap("asset.child.fightBg2");
         }
         else
         {
            _fightBgImage = ComponentFactory.Instance.creatBitmap("asset.child.fightBg");
         }
         _fightImage = ComponentFactory.Instance.creatBitmap("asset.child.ChildAttributeBottomView.fightImage");
         _fightBmd = ComponentFactory.Instance.creatBitmapData("asset.child.ChildAttributeBottomView.fightRes");
         _equipVBox1 = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.equipVBox1");
         _equipVBox2 = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.equipVBox2");
         _fightSp = new Sprite();
         _equipList = new Vector.<ChildBagCell>();
         addChild(_equipGrid);
         addChild(_fightBgImage);
         addChild(_fightImage);
         addChild(_fightSp);
         addChild(_equipVBox1);
         addChild(_equipVBox2);
         if(showType == 2)
         {
            addChild(_awakeSkillBtn);
            addChild(_emblemBtn);
            addChild(_resiBtn);
            addChild(_reduceResiBtn);
         }
         if(VersionSwitch.CHILD_RANK_UP)
         {
            addChild(_upgrageBtn);
            if(VersionSwitch.CHILD_STEP_TWO)
            {
               addChild(_twoStepBtn);
            }
            _twoStepBtn.visible = false;
         }
         addChild(_sellChildBtn);
         _sellChildBtn.visible = false;
         addChild(_switchBtn);
         _switchBtn.visible = false;
         addChild(_enterSetBtn);
         addChild(_masterChildBtn);
         addChild(_slavedChildBtn);
         addChild(_resetBtn);
         _upgrageBtn.text = LanguageMgr.GetTranslation("ChildFosterViewII.upgrageBtn.text");
         _twoStepBtn.text = LanguageMgr.GetTranslation("ChildNSFrame.title");
         _sellChildBtn.text = LanguageMgr.GetTranslation("ChildFosterViewII.sellChildBtn.text");
         _enterSetBtn.text = LanguageMgr.GetTranslation("ChildFosterViewII.enterSetBtn.text");
         _masterChildBtn.text = LanguageMgr.GetTranslation("ChildFosterViewII.masterChildBtn.text");
         _slavedChildBtn.text = LanguageMgr.GetTranslation("ChildFosterViewII.slavedChildBtn.text");
         _resetBtn.text = LanguageMgr.GetTranslation("remotepet.RemotePetListView.restText");
         _switchBtn.text = LanguageMgr.GetTranslation("ChildFosterViewII.switchBtn.text");
         _emblemBtn.tipData = 1;
         _resiBtn.tipData = 2;
         _reduceResiBtn.tipData = 3;
         _awakeSkillBtn.tipData = 4;
         _equipGrid.x = 9;
         _equipGrid.y = 51;
         _fightSp.x = 245;
         _fightSp.y = 375;
         if(showType == 2 && Boolean(VersionSwitch.CHILD_ASSIST) && Boolean(playerInfo.isAvenger))
         {
            _fightImage.x = 67;
            _fightSp.x = 160;
         }
         initEquip();
      }
      
      private function uninitView() : void
      {
         _data = null;
         ObjectUtils.disposeObject(_upgrageBtn);
         _upgrageBtn = null;
         ObjectUtils.disposeObject(_twoStepBtn);
         _twoStepBtn = null;
         ObjectUtils.disposeObject(_sellChildBtn);
         _sellChildBtn = null;
         ObjectUtils.disposeObject(_enterSetBtn);
         _enterSetBtn = null;
         ObjectUtils.disposeObject(_masterChildBtn);
         _masterChildBtn = null;
         ObjectUtils.disposeObject(_slavedChildBtn);
         _slavedChildBtn = null;
         ObjectUtils.disposeObject(_resetBtn);
         _resetBtn = null;
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         ObjectUtils.disposeObject(_awakeSkillBtn);
         _awakeSkillBtn = null;
         ObjectUtils.disposeObject(_emblemBtn);
         _emblemBtn = null;
         ObjectUtils.disposeObject(_reduceResiBtn);
         _reduceResiBtn = null;
         ObjectUtils.disposeObject(_resiBtn);
         _resiBtn = null;
         ObjectUtils.disposeObject(_equipGrid);
         _equipGrid = null;
         ObjectUtils.disposeObject(_fightBgImage);
         _fightBgImage = null;
         ObjectUtils.disposeObject(_fightImage);
         _fightImage = null;
         ObjectUtils.disposeObject(_fightBmd);
         _fightBmd = null;
         ObjectUtils.disposeAllChildren(_fightSp);
         ObjectUtils.disposeObject(_fightSp);
         _fightSp = null;
         ObjectUtils.disposeObject(_equipVBox1);
         _equipVBox1 = null;
         ObjectUtils.disposeObject(_equipVBox2);
         _equipVBox2 = null;
         LogicUtils.disposeDisplayCollection(_equipList);
         _equipList = null;
      }
      
      private function initEquip() : void
      {
         var _loc1_:ChildBagCell = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildEquipBagView.BagCell",[false]);
            _loc1_.celltType = "CELL_EQUIP";
            _loc1_.bagType = 30;
            _loc1_.pos = _loc2_;
            if(_loc2_ < 4)
            {
               _equipVBox1.addChild(_loc1_);
            }
            else
            {
               _equipVBox2.addChild(_loc1_);
            }
            _equipList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function showEnterWarMenu(param1:Boolean) : void
      {
         _masterChildBtn.visible = param1;
         _slavedChildBtn.visible = param1;
         _resetBtn.visible = param1;
         if(data.fightUserId == playerInfo.userId)
         {
            _masterChildBtn.enable = false;
            _slavedChildBtn.enable = true;
            _resetBtn.enable = true;
         }
         else if(data.fightSlaveUserId == playerInfo.userId)
         {
            _masterChildBtn.enable = true;
            _slavedChildBtn.enable = false;
            _resetBtn.enable = true;
         }
         else
         {
            _masterChildBtn.enable = true;
            _slavedChildBtn.enable = true;
            _resetBtn.enable = false;
         }
         if(!VersionSwitch.CHILD_SLAVED)
         {
            _slavedChildBtn.enable = false;
         }
         if(showType == 2)
         {
            if(!VersionSwitch.CHILD_ASSIST || !playerInfo.isAvenger)
            {
               _slavedChildBtn.enable = false;
            }
            else
            {
               _slavedChildBtn.enable = true;
            }
         }
      }
      
      private function initEvent() : void
      {
         if(_upgrageBtn)
         {
            _upgrageBtn.addEventListener("click",__upGradeBtnHandler);
         }
         if(_twoStepBtn)
         {
            _twoStepBtn.addEventListener("click",_twoStepClickHandler);
         }
         if(_sellChildBtn)
         {
            _sellChildBtn.addEventListener("click",__sellChildBtnHandler);
         }
         if(_switchBtn)
         {
            _switchBtn.addEventListener("click",__switchChildHandler);
         }
         if(_enterSetBtn)
         {
            _enterSetBtn.addEventListener("click",__setEnterWarChildStateHandler);
         }
         if(_masterChildBtn)
         {
            _masterChildBtn.addEventListener("click",__setEnterWarChildStateHandler);
         }
         if(_slavedChildBtn)
         {
            _slavedChildBtn.addEventListener("click",__setEnterWarChildStateHandler);
         }
         if(_resetBtn)
         {
            _resetBtn.addEventListener("click",__setEnterWarChildStateHandler);
         }
         if(_awakeSkillBtn)
         {
            _awakeSkillBtn.addEventListener("click",__awakeSkillClickHandler);
         }
         if(_emblemBtn)
         {
            _emblemBtn.addEventListener("click",__nsEmblemResiClickHandler);
         }
         if(_resiBtn)
         {
            _resiBtn.addEventListener("click",__nsEmblemResiClickHandler);
         }
         if(_reduceResiBtn)
         {
            _reduceResiBtn.addEventListener("click",__nsEmblemResiClickHandler);
         }
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         MsgMan.addObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.addObserver("ChildEvent.END_DROP",this,__endDropHandler);
      }
      
      private function removeEvent() : void
      {
         if(_upgrageBtn)
         {
            _upgrageBtn.removeEventListener("click",__upGradeBtnHandler);
         }
         if(_twoStepBtn)
         {
            _twoStepBtn.removeEventListener("click",_twoStepClickHandler);
         }
         if(_sellChildBtn)
         {
            _sellChildBtn.removeEventListener("click",__sellChildBtnHandler);
         }
         if(_switchBtn)
         {
            _switchBtn.removeEventListener("click",__switchChildHandler);
         }
         if(_enterSetBtn)
         {
            _enterSetBtn.removeEventListener("click",__setEnterWarChildStateHandler);
         }
         if(_masterChildBtn)
         {
            _masterChildBtn.removeEventListener("click",__setEnterWarChildStateHandler);
         }
         if(_slavedChildBtn)
         {
            _slavedChildBtn.removeEventListener("click",__setEnterWarChildStateHandler);
         }
         if(_resetBtn)
         {
            _resetBtn.removeEventListener("click",__setEnterWarChildStateHandler);
         }
         if(_emblemBtn)
         {
            _emblemBtn.removeEventListener("click",__nsEmblemResiClickHandler);
         }
         if(_resiBtn)
         {
            _resiBtn.removeEventListener("click",__nsEmblemResiClickHandler);
         }
         if(_reduceResiBtn)
         {
            _reduceResiBtn.removeEventListener("click",__nsEmblemResiClickHandler);
         }
         if(_awakeSkillBtn)
         {
            _awakeSkillBtn.removeEventListener("click",__awakeSkillClickHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         MsgMan.removeObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.removeObserver("ChildEvent.END_DROP",this,__endDropHandler);
      }
      
      private function __startDropHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoodsInfo = param2 as GoodsInfo;
         if(_loc3_ == null)
         {
            return;
         }
         switch(int(_loc3_.templateInfo.SonType) - 601)
         {
            case 0:
               _equipList[3].setFocus();
               break;
            case 2:
               _equipList[0].setFocus();
               break;
            case 3:
               _equipList[2].setFocus();
               break;
            case 5:
               _equipList[1].setFocus();
               break;
            case 6:
               _equipList[4].setFocus();
               _equipList[5].setFocus();
               break;
            case 7:
               _equipList[6].setFocus();
               _equipList[7].setFocus();
         }
      }
      
      private function __endDropHandler(param1:String, param2:Object) : void
      {
         for each(var _loc3_:ChildBagCell in _equipList)
         {
            _loc3_.setNormal();
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_data && _loc2_ && _loc2_.objectId == _data.childId)
         {
            if(_equipList[_loc2_.pos])
            {
               _equipList[_loc2_.pos].data = _loc2_;
            }
            showIntensifyAndComposeTip(_loc2_,_equipList[_loc2_.pos],_loc2_.pos >= 4);
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_data && _loc2_ && _loc2_.objectId == _data.childId)
         {
            if(_equipList[_loc2_.pos])
            {
               _equipList[_loc2_.pos].data = null;
            }
         }
      }
      
      private function __setEnterWarChildStateHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         param1.stopPropagation();
         _equipList[7].mouseEnabled = true;
         _equipList[7].mouseChildren = true;
         if(!data)
         {
            return;
         }
         var _loc2_:String = "";
         if(param1.currentTarget == _enterSetBtn)
         {
            showEnterWarMenu(!_masterChildBtn.visible);
            _equipList[7].mouseEnabled = !_masterChildBtn.visible;
            _equipList[7].mouseChildren = !_masterChildBtn.visible;
         }
         else if(param1.currentTarget == _masterChildBtn)
         {
            showEnterWarMenu(false);
            ChildSender.setEnterWar(data.childId,1);
         }
         else if(param1.currentTarget == _slavedChildBtn)
         {
            showEnterWarMenu(false);
            if(showType == 1)
            {
               if(!model.getChildIsAwakeByType(data.job))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.ChildFosterViewII.slavedEnterWar.alert"));
                  return;
               }
               ChildSender.setEnterWar(data.childId,2);
            }
            else if(showType == 2)
            {
               if(data.childAssistAwakeLevel <= 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.ChildFosterViewII.slavedEnterWar.alert1"));
                  return;
               }
               ChildSender.setEnterWar(data.childId,2);
            }
         }
         else if(param1.currentTarget == _resetBtn)
         {
            showEnterWarMenu(false);
            ChildSender.rest(data.childId);
         }
      }
      
      private function __sellChildBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(_data)
         {
            if(_data.fightUserId > 0 || _data.fightSlaveUserId > 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.canNotSellChild"));
               return;
            }
            if(model.getChildTypeList(_data.job).length <= 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.ChildFosterViewII.sellAlert"));
               return;
            }
            SimpleAlertHelper.instance.data = [sellChildHandlerBack,_data.childId];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("child.sellChildPrompt",_data.name);
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
         }
      }
      
      private function sellChildHandlerBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            ChildSender.sellChild(param3);
         }
      }
      
      private function __upGradeBtnHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            ChildManager.instance.openGrowthFram(_data);
         }
      }
      
      private function _twoStepClickHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            FrameControllerManager.instance.openControllerByInfo("childnursingspirit","NS",_data);
         }
      }
      
      private function __switchChildHandler(param1:MouseEvent) : void
      {
         var _loc2_:ChildSwitchFrame = ComponentFactory.Instance.creatComponentByStylename("child.ChildFosterViewII.ChildSwitchFrame");
         _loc2_.data = data;
         _loc2_.show();
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         if(param1 == null || param1.state != 1)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc3_:Array = null;
         if(_data == null || _data.state != 1)
         {
            return;
         }
         if(_data.nursingSpiritInfo && _data.nursingSpiritInfo.trainInfo.clientFlg == 1 && VersionSwitch.CHILD_STEP_TWO)
         {
            _upgrageBtn.visible = false;
            _twoStepBtn.visible = true;
         }
         else
         {
            _upgrageBtn.visible = true;
            _twoStepBtn.visible = false;
         }
         _sellChildBtn.visible = _switchBtn.visible = showType == 1 ? true : false;
         NumberViewUtils.refreshValue(_data.fightValue,_fightSp,_fightBmd,21,29,16,21,"0123456789");
         var _loc1_:int = Math.ceil(_data.childPower * 100 / 120);
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc4_ = GoodsManager.instance.getItemByPOB(_loc2_,_data.childId,30);
            _loc3_ = GoodsManager.instance.getGoodsByBagType(29);
            if(_loc4_)
            {
               _equipList[_loc2_].data = _loc4_;
               _equipList[_loc2_].showStrengthenGrade();
               showIntensifyAndComposeTip(_loc4_,_equipList[_loc2_],_loc2_ >= 4);
            }
            else if(_loc3_ && _loc3_.length > 0)
            {
               _equipList[_loc2_].data = _loc3_[0] as GoodsInfo;
               _equipList[_loc2_].showStrengthenGrade();
               showIntensifyAndComposeTip(_equipList[_loc2_].data,_equipList[_loc2_],_loc2_ >= 4);
            }
            else
            {
               _equipList[_loc2_].data = null;
            }
            _loc2_++;
         }
         showEnterWarMenu(false);
      }
      
      private function showIntensifyAndComposeTip(param1:GoodsInfo, param2:ChildBagCell, param3:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:Boolean = false;
         var _loc9_:int = ChildIntensifyEquipView.getIntensifyMaterialId(param1.templateInfo.Profile);
         var _loc8_:int = ChildIntensifyEquipView.getIntensifyMaterialNeedNumber(param1.templateInfo.Profile);
         var _loc4_:int = int(GoodsManager.instance.getBagCountByTempId(1,_loc9_));
         var _loc10_:Boolean = param1.strengthenGrade < param1.templateInfo.StrengthenMax && _loc4_ >= _loc8_;
         var _loc5_:ComposeGoodsTemplete = model.getComposeTemByGoodsId(param1.templateId);
         param2.showCanIntensify(_loc10_,param3);
         if(_loc5_)
         {
            _loc6_ = int(_loc5_.Count2);
            _loc11_ = int(GoodsManager.instance.getBagCountByTempId(1,_loc5_.Material2));
            _loc7_ = param1.templateInfo.Profile < 5 && param1.strengthenGrade == param1.templateInfo.StrengthenMax && _loc11_ >= _loc6_;
            param2.showCanCompose(_loc7_,param3);
         }
         else
         {
            param2.showCanCompose(false,param3);
         }
      }
      
      private function __nsEmblemResiClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case _emblemBtn:
               _loc2_ = 1;
               break;
            case _resiBtn:
               _loc2_ = 2;
               break;
            case _reduceResiBtn:
               _loc2_ = 3;
         }
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit","OTHER_GROWTH",_loc2_);
      }
      
      private function __awakeSkillClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit","AWAKE_UPGRADE_FRAME");
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

