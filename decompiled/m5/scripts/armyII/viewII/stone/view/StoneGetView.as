package armyII.viewII.stone.view
{
   import armyII.viewII.stone.ui.ArmyStoneGetViewUI;
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ArmyEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import mvc.module.armyII.StoneLotterInfo;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class StoneGetView extends ArmyStoneGetViewUI
   {
      
      private var _onePrice:int;
      
      private var _tenCount:int;
      
      private var _tenPrice:int;
      
      private var _maxEngNum:int = 1000;
      
      private var _stoneinfo:StoneLotterInfo;
      
      private var _countTime:TimeDownView;
      
      private var _fullFlg:Bitmap;
      
      private var _bagnumMax:int;
      
      private var _bagDefaultNum:int;
      
      private var _helpBtn:BaseButton;
      
      private const Chip_ID:int = 10000000;
      
      private const ENgin_ID:int = 10020000;
      
      private var poolItems:Array = [];
      
      private var _btnOP:int;
      
      public function StoneGetView()
      {
         super();
         init();
         initEvent();
         ArmySocketOutManager.sendGetStone(1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function init() : void
      {
         var _loc6_:Array = null;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("army.stone.HelpBtn");
         addChild(_helpBtn);
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("runehole_bag");
         if(_loc1_)
         {
            _loc6_ = _loc1_.ConfigValue.split(",");
            _bagDefaultNum = int(_loc6_[0]);
            _bagnumMax = int(_loc6_[1]);
         }
         _fullFlg = ComponentFactory.Instance.creatBitmap("asset.army.fullFlg");
         addChild(_fullFlg);
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = 10000000;
         _sbicon.tipData = _loc4_.templateInfo.Description;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = 10020000;
         _nlicon.tipData = _loc3_.templateInfo.Description;
         _backTime.text = LanguageMgr.GetTranslation("army.stone.engieBackTime");
         _countTime = ComponentFactory.Instance.creatComponentByStylename("army.stone.UpdateTime");
         addChild(_countTime);
         _stoneinfo = ArmyManager.instance.thane.runeCate.stoneLotterInfo;
         _onePrice = TempleteManager.instance.getConfigValue("runehole_spot_use");
         var _loc5_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("runehole_tenspot_use");
         var _loc2_:Array = [];
         if(_loc5_)
         {
            _loc2_ = _loc5_.ConfigValue.split(",");
            _tenCount = int(_loc2_[0]);
            _tenPrice = int(_loc2_[1]);
         }
         refreshChipbagNums();
         _nlprice.text = "" + _onePrice;
         _ptprice.text = "" + _tenPrice;
         checkFullState();
      }
      
      private function checkFullState() : void
      {
         var _loc1_:SimpleDictionary = GoodsManager.instance.getRuneBagList(0,0);
         var _loc3_:Array = _loc1_.getList();
         var _loc2_:int = playerInfo.runeCount + _bagDefaultNum;
         if(_loc3_ && _loc3_.length == _loc2_)
         {
            _fullFlg.visible = true;
         }
         else
         {
            _fullFlg.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         _oneBtn.addEventListener("click",oneHandler);
         _tenBtn.addEventListener("click",tenHandler);
         _bagBtn.addEventListener("click",bagClickHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",updateBagHandler);
         ArmyManager.instance.addEventListener("STONE_GET_CHANGE",infoChangeHandler);
         _taEff.addFrameScript(_taEff.totalFrames - 1,effEndHandler);
         playerInfo.addEventListener("RUNE_COUNT_CHANGE",bagCountHandler);
         _helpBtn.addEventListener("click",__helpClick);
         if(_countTime)
         {
            _countTime.addEventListener("timerDown_complete",_timerCompleteHandler);
         }
      }
      
      private function removeEvent() : void
      {
         _oneBtn.removeEventListener("click",oneHandler);
         _tenBtn.removeEventListener("click",tenHandler);
         _bagBtn.removeEventListener("click",bagClickHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",updateBagHandler);
         ArmyManager.instance.removeEventListener("STONE_GET_CHANGE",infoChangeHandler);
         if(_taEff)
         {
            _taEff.addFrameScript(_taEff.totalFrames - 1,null);
         }
         playerInfo.removeEventListener("RUNE_COUNT_CHANGE",bagCountHandler);
         _helpBtn.removeEventListener("click",__helpClick);
         if(_countTime)
         {
            _countTime.removeEventListener("timerDown_complete",_timerCompleteHandler);
         }
      }
      
      private function _timerCompleteHandler(param1:Event) : void
      {
         ArmySocketOutManager.sendGetStone(1);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("army.stone.Get.helperFrame");
         _loc2_.show();
      }
      
      private function bagCountHandler(param1:Event) : void
      {
         checkFullState();
      }
      
      private function updateBagHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 40)
         {
            checkFullState();
         }
         refreshChipbagNums();
      }
      
      private function effEndHandler() : void
      {
         var _loc1_:String = null;
         if(_btnOP > 0)
         {
            _taEff.stop();
            _oneBtn.enable = true;
            _tenBtn.enable = true;
            if(poolItems.length > 0)
            {
               _loc1_ = poolItems.shift();
               if(_loc1_ != null)
               {
                  FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.FUSHI_GET_SHOW;
                  FrameControllerManager.instance.openControllerByInfo("army",null,_loc1_);
               }
            }
         }
      }
      
      private function infoChangeHandler(param1:ArmyEvent = null) : void
      {
         _power.text = _stoneinfo.runePointNum + "/" + _maxEngNum;
         _runePointTxt.text = "" + _stoneinfo.powerPointNum;
         var _loc3_:int = _tenCount - _stoneinfo.tenSpotCount;
         _loc3_ = int(_loc3_ < 0 ? 0 : _loc3_);
         _lefttime.text = LanguageMgr.GetTranslation("army.stone.hasChouNum",_loc3_ + "/" + _tenCount);
         if(_stoneinfo.powerPointNum >= 100)
         {
            _backTime.visible = false;
            _countTime.visible = false;
         }
         else
         {
            _backTime.visible = true;
            _countTime.visible = true;
            _countTime.timeCount = _stoneinfo.leftTime;
         }
         var _loc2_:int = _stoneinfo.runePointNum > _maxEngNum ? _maxEngNum : int(_stoneinfo.runePointNum);
         var _loc4_:int = -70 * _loc2_ / _maxEngNum;
         _powEff.y = 270 + _loc4_;
         if(_stoneinfo.items != null && _stoneinfo.items.length > 0)
         {
            poolItems.push(_stoneinfo.items);
         }
      }
      
      private function refreshChipbagNums() : void
      {
         var _loc1_:int = int(GoodsManager.instance.getGoodsNumByTempId(10000000));
         _runeChipTxt.text = "" + _loc1_;
      }
      
      private function oneHandler(param1:MouseEvent) : void
      {
         if(_stoneinfo.powerPointNum < _onePrice)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("army.rune.pointNo"));
            return;
         }
         _oneBtn.enable = false;
         _tenBtn.enable = false;
         _btnOP = 1;
         _taEff.gotoAndPlay(1);
         ArmySocketOutManager.sendGetStone(2);
      }
      
      private function tenHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = _tenCount - _stoneinfo.tenSpotCount;
         _loc3_ = int(_loc3_ < 0 ? 0 : _loc3_);
         if(_loc3_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("army.notime.get"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc4_:String = LanguageMgr.GetTranslation("stoneGetView.ten.buy",_tenPrice);
         SharedManagerHelper.ins.needAlert("stoneGetView.ten",buyConfirm,_loc2_,_loc4_);
      }
      
      private function buyConfirm() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _tenPrice)
         {
            RechargeAlertMannager.show();
            return;
         }
         _oneBtn.enable = false;
         _tenBtn.enable = false;
         _btnOP = 2;
         _taEff.gotoAndPlay(1);
         ArmySocketOutManager.sendGetStone(3);
      }
      
      private function bagClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.FUSHI_BAG;
         FrameControllerManager.instance.openControllerByInfo("army");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_countTime);
         _countTime = null;
         ObjectUtils.disposeObject(_fullFlg);
         _fullFlg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         _stoneinfo = null;
      }
   }
}

